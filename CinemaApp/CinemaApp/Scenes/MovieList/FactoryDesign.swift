//
//  FactoryDesign.swift
//  CinemaApp
//
//  Created by Ana Popilian on 23/12/2020.
//  Copyright © 2020 Ana Popilian. All rights reserved.
//

import UIKit

protocol MovieDetailsViewControllerProtocol where Self: UIViewController { }

protocol InjectorProtocol {
    func makeNetworkManager() -> NetworkManagerProtocol
    func makeMovieListViewController(movie: MovieModel, genres: Genres) -> MovieDetailsViewControllerProtocol
}

struct AppInjector: InjectorProtocol {
    private init() {}
    
    static let shared = AppInjector()
}


// MARK: - InjectorProtocolExtension
extension InjectorProtocol {
    func makeNetworkManager() -> NetworkManagerProtocol {
        return NetworkManager()
    }
    
    func makeMovieListViewController(movie: MovieModel, genres: Genres) -> MovieDetailsViewControllerProtocol {
        return MovieDetailsViewController(movie: movie, genres: genres)
    }
}
