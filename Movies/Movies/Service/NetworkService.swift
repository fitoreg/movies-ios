//
//  NetworkService.swift
//  Movies
//
//  Created by Fitore Gashi on 5/31/20.
//  Copyright © 2020 Fitore Gashi. All rights reserved.
//

import UIKit

// Vendor
import Alamofire
import SwiftyJSON

class NetworkService: NSObject {
    
    private override init() { }

    // MARK: Shared Instance
    /*
    The Network Service class is a Singleton, that can be used anywhere in our project by instatiating it once.
    */
    static let shared = NetworkService()
    
    // MARK: GET
    func fetchFilms(completion: @escaping(_ data: [Movie]?, _ error: NSError?) -> Void) {
      
      // GET Request is being called here
      AF.request("http://localhost:8080/movies", method: .get).validate().responseJSON { response in
        switch response.result {
            case .success(let value):
            let json = JSON(value)
            var resultsArray = [Movie]()            
            for item in json {

                // JSON is parsed here
                let idDict = item.1
                let identifier = idDict["id"].stringValue
                let title = idDict["title"].stringValue
                let duration = idDict["duration"].stringValue
                let genre = idDict["genre"].stringValue
                let releaseYear = idDict["releaseYear"].stringValue
                let director = idDict["director"].stringValue
                let rating = idDict["rating"].stringValue
                let country = idDict["country"].stringValue
                let trailerURL = idDict["trailerURL"].stringValue
                let posterThumbnailURL = idDict["posterThumbnailURL"].stringValue
                
                // Created Result Object
                let result = Movie(id: identifier,
                                   title: title,
                                   duration: duration,
                                   genre: genre,
                                   releaseYear: releaseYear,
                                   director: director,
                                   rating: rating,
                                   country: country,
                                   trailerURL: trailerURL,
                                   posterThumbnailURL: posterThumbnailURL)
    
               // add movie object to results array
                resultsArray.append(result)

            }
            
            // Return the array containing all movie objects
            completion(resultsArray, nil)
        case .failure(let error):
            print(error)
        }
      }
    }
    
    // MARK: POST
    func postMovie(movie: Movie) {
        // POST Request is called here
        AF.request("http://localhost:8080/movies",
                   method: .post,
                   parameters: movie,
                   encoder: JSONParameterEncoder.default).response { response in
            debugPrint(response)
        }
    }
}
