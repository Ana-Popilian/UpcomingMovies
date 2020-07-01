//
//  MovieModel.swift
//  CinemaApp
//
//  Created by Ana on 26/11/2019.
//  Copyright © 2019 Ana Popilian. All rights reserved.
//

import Foundation

struct MovieModel: Codable {
  
  let id: Int
  let title: String
  let vote: Double
  let genre: [Int]
  let portraitPath: String?
  let backdropPath: String?
  let overview: String
  let releaseDate: String
  
  private enum CodingKeys: String, CodingKey {
    case id
    case title
    case vote = "vote_average"
    case backdropPath = "backdrop_path"
    case genre = "genre_ids"
    case portraitPath = "poster_path"
    case overview
    case releaseDate = "release_date"
  }
}

struct Movies: Codable {
  var results: [MovieModel]
}
