//
//  ViewController.swift
//  CinemaApp
//
//  Created by Ana on 26/11/2019.
//  Copyright © 2019 Ana Popilian. All rights reserved.
//


import UIKit

final class MovieListViewController: UIViewController {
  
  private var page = 0
  private var mainView: MovieListView!
  private var networkManager = NetworkManager()
  
  override func viewDidAppear(_ animated: Bool) {
    navigationController?.navigationBar.barStyle = .black
  }
  
  override func loadView() {
    mainView = MovieListView(delegate: self)
    view = mainView
    
    navigationController?.navigationBar.barTintColor = ColorHelper.customGray
    
    setTitle()
    fetchNewData()
    getGenreData()
  }
  
  override var preferredStatusBarStyle: UIStatusBarStyle {
    .lightContent
  }
  
  func setTitle() {
    let font =  UIFont.systemFont(ofSize: 16)
    let label = UILabel(text: "Upcoming Movies", font: font, textAlignment: .center, textColor: .white)
    self.navigationItem.titleView = label
  }
}


//MARK: - Private Zone
extension MovieListViewController: MovieListDelegate {
  
  func pushViewController(movie: MovieModel, genres: Genres) {
    let nextViewController = MovieDetailsViewController()
    nextViewController.currentMovie = movie
    nextViewController.genreData = genres
    navigationController?.pushViewController(nextViewController, animated: true)
  }
  
  func fetchNewData() {
    page += 1
    
    let url = URL(string: "https://api.themoviedb.org/3/movie/upcoming?api_key=6dac60d5bfa0f64225d7b8e75c53069e&language=en-US&page=\(page)")!
    
    networkManager.getData(of: Movies.self, from: url) { (response) in
      switch response {
        
      case .failure(let error):
        if error is DataError {
          print(error)
        } else {
          print(error.localizedDescription)
        }
        print(error.localizedDescription)
        
      case .success(let movies):
        
        var indexPaths = [IndexPath]()
        let startIndex = self.mainView.getDataCount()
        
        for (index, _) in movies.results.enumerated() {
          indexPaths.append(IndexPath(row: startIndex + index, section: 0))
        }
        DispatchQueue.main.async {
          self.mainView.insertNewItems(movies.results, at: indexPaths)
        }
      }
    }
  }
  
  func getGenreData() {
    let networkManager = NetworkManager()
    let url = URL(string: "https://api.themoviedb.org/3/genre/movie/list?api_key=6dac60d5bfa0f64225d7b8e75c53069e&language=en-US")!
    networkManager.getData(of: Genres.self, from: url) { (response) in
      
      switch response {
      case .failure(let error):
        if error is DataError {
          print(error)
        } else {
          print(error.localizedDescription)
        }
        print(error.localizedDescription)
        
      case .success(let result):
        self.mainView.updateGenres(result)
      }
    }
  }
}
