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
  let popularity: Double
  let image: String?
  let voteAverage: Double
  let overview: String
  let releaseDate: String
  
  private enum CodingKeys: String, CodingKey {
    case id
    case title
    case popularity
    case image = "poster_path"
    case voteAverage = "vote_average"
    case overview
    case releaseDate = "release_date"
  }
}

struct Movies: Codable {
  var results: [MovieModel]
}
