//
//  MovieDetailViewController.swift
//  Movies
//
//  Created by Fitore Gashi on 5/31/20.
//  Copyright © 2020 Fitore Gashi. All rights reserved.
//

import UIKit
import Nuke
import WebKit

class MovieDetailViewController: UIViewController {
    
    var movie: Movie?

    @IBOutlet weak var posterImageView: UIImageView!
    
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieDurationLabel: UILabel!
    @IBOutlet weak var movieGenreLabel: UILabel!
    @IBOutlet weak var movieReleaseYearLabel: UILabel!
    @IBOutlet weak var movieDirectorLabel: UILabel!
    @IBOutlet weak var movieCountryLabel: UILabel!
    @IBOutlet weak var movieRatingLabel: UILabel!
    
    @IBOutlet weak var trailerWebView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let movie = movie {
            self.title = movie.title
            setupViews(movie: movie)
        }
    }
    
    func setupViews(movie: Movie) {
        
        Nuke.loadImage(with: URL(string: movie.posterThumbnailURL)!, into: posterImageView)
    
        movieTitleLabel.text = "Title: \(movie.title)"
        movieDurationLabel.text = "Duration: \(movie.duration)"
        movieGenreLabel.text = "Genre: \(movie.genre)"
        movieReleaseYearLabel.text = "Release Year: \(movie.releaseYear)"
        movieDirectorLabel.text = "Director: \(movie.director)"
        movieCountryLabel.text = "Country: \(movie.country)"
        movieRatingLabel.text = "Rating: \(movie.rating)"
    }
    

    @IBAction func playTrailerButtonPressed(_ sender: Any) {
        if let movie = movie {
            trailerWebView.load(URLRequest(url: URL(string: movie.trailerURL)!))
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
