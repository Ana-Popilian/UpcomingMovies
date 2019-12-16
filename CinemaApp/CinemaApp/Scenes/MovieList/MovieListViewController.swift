//
//  ViewController.swift
//  CinemaApp
//
//  Created by Ana on 26/11/2019.
//  Copyright © 2019 Ana Popilian. All rights reserved.
//


import UIKit

final class MovieListViewController: UIViewController {
  
  private var movieData = [MovieModel]()
  private var page = 0
  private var isFetchingData = false
  
  private var collectionView: UICollectionView!
  
  
  let activityIndicator: UIActivityIndicatorView = {
    let ai = UIActivityIndicatorView(style: .large)
    ai.color = .white
    ai.hidesWhenStopped = true
    ai.startAnimating()
    return ai
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    navigationItem.title = "Upcoming Movies"
    navigationController?.navigationBar.barTintColor = ColorHelper.darkPurple
    navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
    setupView()
    fetchNewData()
  }
  
  private func setupView() {
    
    collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    collectionView.dataSource = self
    collectionView.delegate = self
    collectionView.backgroundColor = ColorHelper.customPurple
    collectionView.showsVerticalScrollIndicator = true
    collectionView.indicatorStyle = .white
    
    collectionView.addSubviewWithoutConstraints(activityIndicator)
    activityIndicator.centerXAnchor.constraint(equalTo: collectionView.centerXAnchor).isActive = true
    activityIndicator.centerYAnchor.constraint(equalTo: collectionView.centerYAnchor, constant: -50).isActive = true
    
    collectionView.register(MovieCell.self, forCellWithReuseIdentifier: MovieCell.identifier)
    
    view.addSubviewWithoutConstraints(collectionView)
    NSLayoutConstraint.activate([
      collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
      collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
      collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
    ])
  }
}

//MARK: - Private Zone
private extension MovieListViewController {
  
  func fetchNewData() {
    let networkManager = NetworkManager()
    page += 1
    networkManager.getUpcomingMovies(page: page, completionHandler: { [weak self] (movies) in
      guard let self = self else { return }
      
      if movies.isEmpty {
        return
      }
      
      var indexPaths = [IndexPath]()
      let currentIndex = self.movieData.count - 1
      
      for _ in movies {
        indexPaths.append(IndexPath(row: currentIndex + 1, section: 0))
      }
      
      self.movieData.append(contentsOf: movies)
      
      DispatchQueue.main.async {
        self.activityIndicator.stopAnimating()
        self.collectionView.insertItems(at: indexPaths)
      }
      
      self.isFetchingData = false
    })
  }
}


extension MovieListViewController: UIScrollViewDelegate {
  
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    if(collectionView.contentOffset.y >= (collectionView.contentSize.height - collectionView.frame.size.height - collectionView.contentSize.height * 0.1) && isFetchingData == false) {
      
      isFetchingData = true
      fetchNewData()
    }
  }
}


extension MovieListViewController {
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    //    let movie = movieData[indexPath.row]
  }
}

extension MovieListViewController: UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    movieData.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.identifier, for: indexPath) as! MovieCell
    
    let movie = movieData[indexPath.row]
    cell.bindCell(movie: movie)
    return cell
  }
}


//MARK : - UICollectionViewDelegateFlowLayout
extension MovieListViewController: UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let width = (view.frame.width / 3 - 14)
    return CGSize(width: width, height: 100)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
  }
}
