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
  
  override func loadView() {
    mainView = MovieListView(delegate: self)
    view = mainView
    
    navigationController?.navigationBar.barTintColor = ColorHelper.customGray
    
    setTitle()
    fetchNewData()
    getGenreData()
  }
  
  func setTitle() {
    let label = UILabel()
    label.text = "Upcoming Movies"
    label.font =  UIFont.systemFont(ofSize: 16)
    label.textAlignment = .center
    self.navigationItem.titleView = label
  }
}


//MARK: - Private Zone
extension MovieListViewController: MovieListDelegate {
  
  func pushViewController(movie: MovieModel) {
    let nextViewController = MovieDetailsViewController()
    nextViewController.currentMovie = movie
    navigationController?.pushViewController(nextViewController, animated: true)
  }
  
  func fetchNewData() {
    let networkManager = NetworkManager()
    page += 1
    networkManager.getUpcomingMovies(page: page, completionHandler: { [weak self] (movies) in
      guard let self = self else { return }
      
      if movies.isEmpty {
        return
      }
      
      var indexPaths = [IndexPath]()
      let startIndex = self.mainView.getDataCount()
      
      for (index, _) in movies.enumerated() {
        indexPaths.append(IndexPath(row: startIndex + index, section: 0))
      }
      
      DispatchQueue.main.async {
        self.mainView.insertNewItems(movies, at: indexPaths)
      }
    })
  }
  
  func getGenreData() {
    let networkManager = NetworkManager()
    networkManager.fetchMovieGenres(completionHandler: { [weak self] (genre) in
      guard self != nil else { return }
      print(genre)
    })
  }
}
