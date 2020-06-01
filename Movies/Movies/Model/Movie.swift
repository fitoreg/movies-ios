//
//  Movie.swift
//  Movies
//
//  Created by Fitore Gashi on 5/31/20.
//  Copyright © 2020 Fitore Gashi. All rights reserved.
//

import UIKit

/*
"id": 8,
"title": "Avengers: End Game",
"duration": "180 mins",
"genre": "Sci-Fi",
"releaseYear": "2019",
"director": "Joe & Anthony Ruso",
"rating": "8.4",
"country": "USA",
"trailerURL": "https://www.youtube.com/watch?v=TcMBFSGVi1c",
"posterThumbnailURL": "https://images-na.ssl-images-amazon.com/images/I/71HyTegC0SL._AC_SY879_.jpg"
*/

struct Movie: Encodable, Decodable {
    
  var id: String
  var title: String
  var duration: String
  var genre: String
  var releaseYear: String
  var director: String
  var rating: String
  var country: String
  var trailerURL: String
  var posterThumbnailURL: String

  enum CodingKeys: String, CodingKey {
    case id
    case title
    case duration
    case genre
    case releaseYear
    case director
    case rating
    case country
    case trailerURL
    case posterThumbnailURL
  }
    
    init?() {
        return nil
    }
        
    init(id: String, title: String, duration: String, genre: String, releaseYear: String, director: String, rating: String, country: String, trailerURL: String, posterThumbnailURL: String) {
        self.id = id
        self.title = title
        self.duration = duration
        self.genre = genre
        self.releaseYear = releaseYear
        self.director = director
        self.rating = rating
        self.country = country
        self.trailerURL = trailerURL
        self.posterThumbnailURL = posterThumbnailURL
    }
}




