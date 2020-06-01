//
//  MoviesListViewController.swift
//  Movies
//
//  Created by Fitore Gashi on 5/31/20.
//  Copyright © 2020 Fitore Gashi. All rights reserved.
//

import UIKit
import Nuke

class MoviesListViewController: UIViewController {
    
    // Class variables
    var moviesList = [Movie]()
    var filteredMoviesList = [Movie]()
    var selectedMovie = Movie()
    
    // Outlets for UIElements
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()

       // Once the view is loaded and visible, we fetch the movies from our NetworkService
       NetworkService.shared.fetchFilms(completion: { (movies, error) in
            if let movies = movies {
                self.moviesList = movies
                self.filteredMoviesList = movies
                self.tableView.reloadData()
            }
        })
        
        // We add an observer to update the movie list, in case we decide to add another movie
        NotificationCenter.default.addObserver(self, selector: #selector(updateMoviesList(notification:)), name: .updateList, object: nil)
    }
    


    // MARK: - Navigation

    // This method is used to handle the navigation between ViewControllers
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "showDetail" {
            let detailVC = segue.destination as! MovieDetailViewController
            detailVC.movie = self.selectedMovie
        }
        
        if segue.identifier == "showStats" {
            let statsVC = segue.destination as! StatisticsViewController
            statsVC.movies = moviesList
        }
    }
    
    // This method is fired when we add a new movie.
    // First we remove all objects from the array, and fetch the movies from API again
    @objc func updateMoviesList(notification: Notification) {
        self.moviesList.removeAll()
        self.filteredMoviesList.removeAll()
        NetworkService.shared.fetchFilms(completion: { (movies, error) in
             if let movies = movies {
                 self.moviesList = movies
                 self.tableView.reloadData()
             }
         })
    }
    
    // Navigate to StatisticsViewcontroller
    @IBAction func showStatsButtonPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "showStats", sender: nil)
    }
}

// MARK: UITableViewDelegate
extension MoviesListViewController: UITableViewDelegate, UITableViewDataSource {
    
    // This method determines how many rows our table will show
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredMoviesList.count
    }
    
    // This method is called for each table view row. The data to be displayed in each cell is configured here.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MoviesListCell", for: indexPath) as! MoviesListCell
        let movie = filteredMoviesList[indexPath.row]

        Nuke.loadImage(with: URL(string: movie.posterThumbnailURL)!, into: cell.moviePosterImageView)
        
        cell.movieTitleLabel.text = movie.title
        cell.genreLabel.text = movie.genre
        cell.yearLabel.text = movie.releaseYear
        cell.ratingsLabel.text = movie.rating
        
        return cell
    }
    
    // Method to determine height of the row
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    // Once we click on a row, we will navigate to the Movie Detail Screen
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedMovie = filteredMoviesList[indexPath.row]
        self.performSegue(withIdentifier: "showDetail", sender: nil)
    }
}

// This method handles search
extension MoviesListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty == false {
            filteredMoviesList = moviesList.filter { (movie: Movie) -> Bool in
              return movie.title.lowercased().contains(searchText.lowercased())
            }
            tableView.reloadData()
        }
    }
}

extension Notification.Name {
     static let updateList = Notification.Name("updateList")
}


