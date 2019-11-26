//
//  NetworkManager.swift
//  CinemaApp
//
//  Created by Ana on 26/11/2019.
//  Copyright © 2019 Ana Popilian. All rights reserved.
//

import Foundation

class NetworkManager {
  
  func getUpcomingMovies(completionHandler: @escaping (_ movies: [MovieModel]) -> Void) {
    
    guard let url = URL(string: "https://api.themoviedb.org/3/movie/upcoming?api_key=6dac60d5bfa0f64225d7b8e75c53069e") else { return }
    let request = URLSession.shared.dataTask(with: url) { (data, response, error) in
      
      do {
        let decoder = JSONDecoder()
        let response = try decoder.decode(Movies.self, from: data!)
        
        completionHandler(response.results)
        print(response)
        
      } catch let DecodingError.dataCorrupted(context) {
        print(context)
      } catch let DecodingError.keyNotFound(key, context) {
        print("Key '\(key)' not found:", context.debugDescription)
        print("codingPath:", context.codingPath)
      } catch let DecodingError.valueNotFound(value, context) {
        print("Value '\(value)' not found:", context.debugDescription)
        print("codingPath:", context.codingPath)
      } catch let DecodingError.typeMismatch(type, context)  {
        print("Type '\(type)' mismatch:", context.debugDescription)
        print("codingPath:", context.codingPath)
      } catch {
        print("error: ", error)
      }
    }
    
    request.resume()
  }
}
