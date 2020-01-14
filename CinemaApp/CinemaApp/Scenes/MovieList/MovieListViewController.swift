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
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    title = "Upcoming Movies"
    
    navigationController?.navigationBar.barTintColor = ColorHelper.darkPurple
    navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
    
    fetchNewData()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
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
}
