//
//  NetworkManager.swift
//  CinemaApp
//
//  Created by Ana on 26/11/2019.
//  Copyright © 2019 Ana Popilian. All rights reserved.
//

import Foundation

final class NetworkManager: NSObject {
  
  let movieCell = MovieCell()
  
  func getUpcomingMovies(page: Int, completionHandler: @escaping (_ movies: [MovieModel]) -> Void) {
    
    guard let url = URL(string: "https://api.themoviedb.org/3/movie/upcoming?api_key=6dac60d5bfa0f64225d7b8e75c53069e&language=en-US&page=\(page)") else {
      fatalError("url must be valid!!!")
    }
    
    let request = URLSession.shared.dataTask(with: url) { (data, response, error) in
      
      do {
        let decoder = JSONDecoder()
        let response = try decoder.decode(Movies.self, from: data!)
        
        completionHandler(response.results)
        
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
  
  func fetchImage(imageUrl: String, completion: @escaping (Data?) -> ()) {
    let baseURl = "https://image.tmdb.org/t/p/w154/"
    let url = URL(string: baseURl + imageUrl)!
    
    let request = URLRequest(url: url)
    let sessionConfig = URLSessionConfiguration.default
    sessionConfig.timeoutIntervalForResource = 5
    
    let session = URLSession(configuration: sessionConfig)
    
    let task = session.dataTask(with: request, completionHandler: { data, response, error in
      completion(data)
    })
    task.resume()
  }
}


