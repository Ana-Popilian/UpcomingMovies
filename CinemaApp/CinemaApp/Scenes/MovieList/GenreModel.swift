//
//  GenreModel.swift
//  CinemaApp
//
//  Created by Ana on 30/06/2020.
//  Copyright © 2020 Ana Popilian. All rights reserved.
//

import Foundation

struct GenreModel: Codable {
  
  let id: Int
  let name: String
}

struct Genres: Codable {
  let genres: [GenreModel]
}
