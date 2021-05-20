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
   private var mainView: MovieListViewProtocol
   private let networkManager: NetworkManagerProtocol
   var error: Error!
   var movieData: Movies!
   var genres: Genres!
   var injector: InjectorProtocol
   
   override func viewDidAppear(_ animated: Bool) {
      navigationController?.navigationBar.barStyle = .black
   }
   
   init(injector: InjectorProtocol, mainView: MovieListViewProtocol) {
      self.networkManager = injector.makeNetworkManager()
      self.mainView = mainView
      self.injector = injector
      super.init(nibName: nil, bundle: nil)
   }
   
   required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
   
   override func loadView() {
      mainView.delegate = self
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
      let font = UIFont.systemFont(ofSize: 16)
      let label = UILabel(text: "Upcoming Movies", font: font, textAlignment: .center, textColor: .white)
      self.navigationItem.titleView = label
   }
}


//MARK: - Private Zone
extension MovieListViewController: MovieListDelegate {
   
   func pushViewController(movie: MovieModel, genres: Genres) {
      let nextViewController = self.injector.makeMovieListViewController(movie: movie, genres: genres)
      navigationController?.pushViewController(nextViewController, animated: true)
   }
   
   func fetchNewData() {
      page += 1
      
      let url = URL(string: "https://api.themoviedb.org/3/movie/upcoming?api_key=6dac60d5bfa0f64225d7b8e75c53069e&language=en-US&page=\(page)")!
      
      networkManager.getData(of: Movies.self, from: url) { (response) in
         switch response {
         
         case .failure(let error):
            self.error = error
            
         case .success(let movies):
            self.movieData = movies
            
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
      
      let url = URL(string: "https://api.themoviedb.org/3/genre/movie/list?api_key=6dac60d5bfa0f64225d7b8e75c53069e&language=en-US")!
      networkManager.getData(of: Genres.self, from: url) { (response) in
         
         switch response {
         
         case .failure(let error):
            self.error = error
            
         case .success(let result):
            self.genres = result
            
            DispatchQueue.main.async {
               self.mainView.updateGenres(result)
            }
         }
      }
   }
}
