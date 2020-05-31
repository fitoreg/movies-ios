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
    
    @IBOutlet weak var tableView: UITableView!
    
    var moviesList = [Movie]()
    var selectedMovie = Movie()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
       NetworkService.shared.fetchFilms(completion: { (movies, error) in
            if let movies = movies {
                self.moviesList = movies
                self.tableView.reloadData()
            }
        })
    }
    


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "showDetail" {
            let detailVC = segue.destination as! MovieDetailViewController
            detailVC.movie = self.selectedMovie
        }
    }
}

// MARK: UITableViewDelegate
extension MoviesListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MoviesListCell", for: indexPath) as! MoviesListCell
        let movie = moviesList[indexPath.row]

        Nuke.loadImage(with: URL(string: movie.posterThumbnailURL)!, into: cell.moviePosterImageView)
        
        cell.movieTitleLabel.text = movie.title
        cell.genreLabel.text = movie.genre
        cell.yearLabel.text = movie.releaseYear
        cell.ratingsLabel.text = movie.rating
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedMovie = moviesList[indexPath.row]
        self.performSegue(withIdentifier: "showDetail", sender: nil)
    }
}
