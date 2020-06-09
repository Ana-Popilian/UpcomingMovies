//
//  MovieListView.swift
//  CinemaApp
//
//  Created by Ana on 19/12/2019.
//  Copyright © 2019 Ana Popilian. All rights reserved.
//

import UIKit

protocol MovieListDelegate where Self: UIViewController {
  func pushViewController(movie: MovieModel)
  func fetchNewData()
}

final class MovieListView: UIView {
  
  private weak var delegate : MovieListDelegate?
  private var isFetchingData = false
  private var movieData = [MovieModel]()
  private var activityIndicator: UIActivityIndicatorView!
  private var collectionView: UICollectionView!
  
  private enum ViewTrait {
    static let defaultPadding: CGFloat = 8
    static let height: CGFloat = 100
  }
  
  required init(delegate: MovieListDelegate?) {
    self.delegate = delegate
    super.init(frame: .zero)
    
    setupActivityIndicator()
    setupCollectionView()
    
    addSubviews()
    setupConstraints()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func insertNewItems(_ items: [MovieModel], at indexPaths: [IndexPath]) {
    movieData.append(contentsOf: items)
    activityIndicator.stopAnimating()
    collectionView.insertItems(at: indexPaths)
    isFetchingData = false
  }
  
  func getDataCount() -> Int {
    movieData.count
  }
}


//MARK: - Private Zone
private extension MovieListView {
  
  func setupActivityIndicator() {
    activityIndicator = UIActivityIndicatorView(style: .large)
    activityIndicator.color = .white
    activityIndicator.hidesWhenStopped = true
    activityIndicator.startAnimating()
  }
  
  func setupCollectionView() {
    
    collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    collectionView.register(MovieCell.self, forCellWithReuseIdentifier: MovieCell.identifier)
    collectionView.dataSource = self
    collectionView.delegate = self
    collectionView.backgroundColor = ColorHelper.customPurple
    collectionView.showsVerticalScrollIndicator = true
    collectionView.indicatorStyle = .white
  }
}


//MARK: - UIScrollViewDelegate
extension MovieListView: UIScrollViewDelegate {
  
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    if(collectionView.contentOffset.y >= (collectionView.contentSize.height - collectionView.frame.size.height - collectionView.contentSize.height * 0.1) && isFetchingData == false) {
      
      isFetchingData = true
      delegate?.fetchNewData()
    }
  }
}


//MARK: - UICollectionViewDelegate
extension MovieListView: UICollectionViewDelegate {
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let movie = movieData[indexPath.row]
    
    delegate?.pushViewController(movie: movie)
  }
}


//MARK: - UICOllectionViewDataSource
extension MovieListView: UICollectionViewDataSource {
  
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
extension MovieListView: UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let width = (frame.width / 3 - 14)
    return CGSize(width: width, height: ViewTrait.height)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return UIEdgeInsets(top: ViewTrait.defaultPadding, left: ViewTrait.defaultPadding, bottom: ViewTrait.defaultPadding, right: ViewTrait.defaultPadding)
  }
}


//MARK: - Constraints Zone
private extension MovieListView {
  
  func addSubviews() {
    addSubviewWithoutConstraints(activityIndicator)
    addSubviewWithoutConstraints(collectionView)
  }
  
  func setupConstraints() {
    NSLayoutConstraint.activate([
      
      collectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
      collectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
      collectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
      collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
      
      activityIndicator.centerXAnchor.constraint(equalTo: collectionView.centerXAnchor),
      activityIndicator.centerYAnchor.constraint(equalTo: collectionView.centerYAnchor),
    ])
  }
}