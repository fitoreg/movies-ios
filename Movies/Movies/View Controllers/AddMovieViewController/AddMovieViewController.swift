//
//  AddMovieViewController.swift
//  Movies
//
//  Created by Fitore Gashi on 6/1/20.
//  Copyright © 2020 Fitore Gashi. All rights reserved.
//

import UIKit
import Alamofire
import CRNotifications

class AddMovieViewController: UIViewController {

    @IBOutlet weak var movieTitleTextField: UITextField!
    @IBOutlet weak var movieDurationTextField: UITextField!
    @IBOutlet weak var movieGenreTextField: UITextField!
    @IBOutlet weak var movieReleaseYearTextField: UITextField!
    @IBOutlet weak var movieDirectorReleaseYear: UITextField!
    @IBOutlet weak var movieRatingTextField: UITextField!
    @IBOutlet weak var movieCountryTextField: UITextField!
    @IBOutlet weak var movieTrailerTextField: UITextField!
    @IBOutlet weak var moviePosterTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "Add Movie"
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func addMovieButtonPressed(_ sender: Any) {
        if (movieTitleTextField.text!.isEmpty || movieDurationTextField.text!.isEmpty || movieGenreTextField.text!.isEmpty || movieReleaseYearTextField.text!.isEmpty || movieDirectorReleaseYear.text!.isEmpty || movieRatingTextField.text!.isEmpty || movieCountryTextField.text!.isEmpty || movieTrailerTextField.text!.isEmpty || moviePosterTextField.text!.isEmpty) {
            CRNotifications.showNotification(type: CRNotifications.error, title: "Error!", message: "Please fill all text fields", dismissDelay: 3)
        } else {
            let movie = Movie(id: "", title: movieTitleTextField.text!,
                              duration: movieDurationTextField.text!,
                              genre: movieGenreTextField.text!,
                              releaseYear: movieReleaseYearTextField.text!,
                              director: movieDirectorReleaseYear.text!,
                              rating: movieRatingTextField.text!,
                              country: movieCountryTextField.text!,
                              trailerURL: movieTrailerTextField.text!,
                              posterThumbnailURL: moviePosterTextField.text!)
            NetworkService.shared.postMovie(movie: movie)
            CRNotifications.showNotification(type: CRNotifications.success, title: "Success!", message: "Movie added successfully!", dismissDelay: 3)
            self.dismiss(animated: true) {
                NotificationCenter.default.post(name: .updateList, object: nil)
            }
        }
    }
}
