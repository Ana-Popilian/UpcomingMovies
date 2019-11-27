//
//  ViewController.swift
//  CinemaApp
//
//  Created by Ana on 26/11/2019.
//  Copyright © 2019 Ana Popilian. All rights reserved.
//

import UIKit

final class MovieListViewController: UIViewController {
  
  let networkManager = NetworkManager()
  private var movieData = [Movies]()
  
  private var collectionView: UICollectionView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = .red

    collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    collectionView.dataSource = self
    collectionView.delegate = self
    
    collectionView.register(MovieCell.self, forCellWithReuseIdentifier: MovieCell.identifier)
    
    networkManager.getUpcomingMovies { [weak self] (movies) in
      guard self != nil else { return }
      
      DispatchQueue.main.async {
        self?.collectionView.reloadData()
      }
    }
    
    
    view.addSubviewWithoutConstraints(collectionView)
    NSLayoutConstraint.activate([
      collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
      collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
      collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
    ])
  }
}

//extension MovieListViewController {
//
//  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//    //     let movie = movieData[indexPath.row]
//  }
//}

extension MovieListViewController: UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    12
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.identifier, for: indexPath) as! MovieCell
    cell.backgroundColor = .yellow
    return cell
  }
}


//MARK : - UICollectionViewDelegateFlowLayout
extension MovieListViewController: UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let width = (view.frame.width / 3 - 16)
    return CGSize(width: width, height: 100)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
  }
}
