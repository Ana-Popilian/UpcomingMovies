//
//  MovieListViewControllerTests.swift
//  CinemaAppTests
//
//  Created by Ana Popilian on 23/12/2020.
//  Copyright © 2020 Ana Popilian. All rights reserved.
//

import Foundation
import XCTest
@testable import CinemaApp

final class MovieListViewControllerTests: XCTestCase {
    private var networkManager: NetworkManagerMock!
    private static let testMoviesModel = makeTestMovies()
    private static let testGenres = makeGenres()
    private var injectorPassedMovieData: MovieModel!
    private var injectorPassedGenresData: Genres!
    
    private static func makeTestMovies() -> Movies {
        let model = MovieModel(id: 1, title: "A", vote: 5, genre: [], portraitPath: "A", backdropPath: "A", overview: "A", releaseDate: "12")
        
        return Movies(results: [model])
    }
    
    private static func makeGenres() -> Genres {
        let model = [GenreModel(id: 1, name: "A")]
        return Genres(genres: model)
    }
    
    func testFetchNewDataFaillure() {
        let myVC = MovieListViewController(injector: self, mainView: MovieListMock())
        XCTAssertNil(myVC.error, "Error should be nil")
        networkManager.resultIsSuccess = false
        myVC.fetchNewData()
        XCTAssertNotNil(myVC.error, "Error should not be nil")
    }
    
    
    func testFetchNewDataSuccess() {
        let mainView = MovieListMock()
        mainView.expectation = XCTestExpectation(description: "insert new items")
        
        let myVC = MovieListViewController(injector: self, mainView: mainView)
        XCTAssertNil(myVC.movieData, "Data should be nil")
        myVC.fetchNewData()
        XCTAssertNotNil(myVC.movieData, "Data should not be nil")
        
        wait(for: [mainView.expectation!], timeout: 0.1)
        XCTAssertEqual(MovieListViewControllerTests.testMoviesModel.results.first?.id, mainView.passedMovieModel.first?.id)
    }
    
    func testGetGenresFaillure() {
        let myVC = MovieListViewController(injector: self, mainView: MovieListMock())
        XCTAssertNil(myVC.error, "Error should be nil")
        networkManager.resultIsSuccess = false
        myVC.getGenreData()
        XCTAssertNotNil(myVC.error, "Error should not be nil")
    }
    
    func testGetGenresSuccess() {
        let mainView = MovieListMock()
        mainView.expectation = XCTestExpectation(description: "update genres")
        
        let myVC = MovieListViewController(injector: self, mainView: mainView)
        XCTAssertNil(myVC.genres, "Genres should be nil")
        myVC.getGenreData()
        XCTAssertNotNil(myVC.genres, "Genres should not be nil")
        
        wait(for: [mainView.expectation!], timeout: 0.1)
        XCTAssertEqual(MovieListViewControllerTests.testGenres.genres.first?.id, mainView.passedGenres.genres.first?.id)
    }
    
    func testPushViewController() {
        let myVC = MovieListViewController(injector: self, mainView: MovieListMock())
        let movie = MovieModel(id: 1, title: "A", vote: 1, genre: [], portraitPath: "A", backdropPath: "A", overview: "a", releaseDate: "1")
        let genreModel = [GenreModel(id: 1, name: "A")]
        let genres = Genres(genres: genreModel)
        myVC.pushViewController(movie: movie, genres: genres)
        XCTAssertEqual(movie.id, injectorPassedMovieData.id)
        XCTAssertEqual(genres.genres.first?.id, injectorPassedGenresData.genres.first?.id)
    }
}


extension MovieListViewControllerTests: InjectorProtocol {
    func makeNetworkManager() -> NetworkManagerProtocol {
        networkManager = NetworkManagerMock()
        return networkManager
    }
    
    func makeMovieListViewController(movie: MovieModel, genres: Genres) -> MovieDetailsViewControllerProtocol {
        injectorPassedMovieData = movie
        injectorPassedGenresData = genres
        return MovieDetailsViewControllerMock()
    }
    
    class NetworkManagerMock: NetworkManagerProtocol {
        var resultIsSuccess = true
        
        func getData<T>(of type: T.Type, from url: URL, completion: @escaping (Result<T, Error>) -> Void) where T : Decodable {
            if resultIsSuccess {
                if type is Movies.Type {
                    completion(.success(MovieListViewControllerTests.testMoviesModel as! T))
                    
                } else {
                    completion(.success(MovieListViewControllerTests.testGenres as! T))
                }
                
            } else {
                completion(.failure(NSError(domain: "A", code: 1)))
            }
        }
    }
    
    class MovieListMock: UIView, MovieListViewProtocol {
        var passedMovieModel: [MovieModel]!
        var passedGenres: Genres!
        var expectation: XCTestExpectation?
        
        func insertNewItems(_ items: [MovieModel], at indexPaths: [IndexPath]) {
            passedMovieModel = items
            expectation?.fulfill()
        }
        
        func updateGenres(_ genres: Genres) {
            passedGenres = genres
            expectation?.fulfill()
        }
        
        func getDataCount() -> Int {
            return 2
        }
        var delegate: MovieListDelegate?
    }
    
    class MovieDetailsViewControllerMock: UIViewController, MovieDetailsViewControllerProtocol { }
}
