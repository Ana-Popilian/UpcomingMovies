//
//  NetworkManager.swift
//  CinemaApp
//
//  Created by Ana on 26/11/2019.
//  Copyright © 2019 Ana Popilian. All rights reserved.
//

import UIKit

protocol NetworkManagerProtocol {
    func getData<T: Decodable>(of type: T.Type,
                               from url: URL,
                               completion: @escaping (Result <T, Error>) -> Void)
}

enum DataError: Error {
  case invalidResponse
  case invalidData
  case decodingError
  case serverError
}

final class NetworkManager: NetworkManagerProtocol {
  
  func getData<T: Decodable>(of type: T.Type,
                             from url: URL,
                             completion: @escaping (Result <T, Error>) -> Void) {
    
    URLSession.shared.dataTask(with: url) {(data, response, error) in
      if let error = error {
        completion (.failure(error))
        
      }
      
      guard let response = response as? HTTPURLResponse else {
        completion(.failure(DataError.invalidResponse))
        return
      }
      
      if 200 ... 299 ~= response.statusCode {
        if let data = data {
          do {
            let decodedData: T = try JSONDecoder().decode(type, from: data);  completion(.success(decodedData))
          }
          catch {
            completion(.failure(DataError.decodingError))
          }
        } else {
          completion(.failure(DataError.invalidData))
        }
      } else {
        completion(.failure(DataError.serverError))
      }
    } .resume()
  }
  
  func fetchImage(imageUrl: String, width: Int, completion: @escaping (Data?) -> ()) {
    
    let baseURl = "https://image.tmdb.org/t/p/w\(width)/"
    let url = URL(string: baseURl + imageUrl)!
    
    let request = URLRequest(url: url)
    let sessionConfig = URLSessionConfiguration.default
    sessionConfig.timeoutIntervalForResource = 8
    
    let session = URLSession(configuration: sessionConfig)
    
    let task = session.dataTask(with: request, completionHandler: { data, response, error in
      completion(data)
    })
    task.resume()
  }
}
