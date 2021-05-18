//
//  MovieListView.swift
//  CinemaApp
//
//  Created by Ana on 19/12/2019.
//  Copyright © 2019 Ana Popilian. All rights reserved.
//

import UIKit

protocol MovieListDelegate where Self: UIViewController {
   func pushViewController(movie: MovieModel, genres: Genres)
   func fetchNewData()
}

protocol MovieListViewProtocol where Self: UIView {
   func insertNewItems(_ items: [MovieModel], at indexPaths: [IndexPath])
   func updateGenres(_ genres: Genres)
   func getDataCount() -> Int
   var delegate: MovieListDelegate? { get set }
}

final class MovieListView: UIView, MovieListViewProtocol {
   
   weak var delegate: MovieListDelegate?
   private var isFetchingData = false
   private var movieData = [MovieModel]()
   private var genreData: Genres!
   private var activityIndicator: UIActivityIndicatorView!
   private var collectionView: UICollectionView!
   
   private enum ViewTrait {
      static let defaultPadding: CGFloat = 5
      static let height: CGFloat = UIScreen.main.bounds.width * 0.6
   }
   
   required init() {
      super.init(frame: .zero)
      backgroundColor = ColorHelper.customGray
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
   
   func updateGenres(_ genres: Genres) {
      genreData = genres
   }
   
   func getDataCount() -> Int {
      movieData.count
   }
}


//MARK: - Private Zone
private extension MovieListView {
   
   func setupActivityIndicator() {
      activityIndicator = UIActivityIndicatorView(style: .large)
      activityIndicator.color = .black
      activityIndicator.hidesWhenStopped = true
      activityIndicator.startAnimating()
//      activityIndicator.accessibilityIdentifier = "activity-indicator"
   }
   
   func setupCollectionView() {
      collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
      collectionView.register(MovieCell.self, forCellWithReuseIdentifier: MovieCell.identifier)
      collectionView.dataSource = self
      collectionView.delegate = self
      collectionView.backgroundColor = ColorHelper.customGray
      collectionView.showsVerticalScrollIndicator = true
      collectionView.indicatorStyle = .white
      collectionView.accessibilityIdentifier = "collection-view"
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
      let genres = genreData
      
      delegate?.pushViewController(movie: movie, genres: genres! )
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


//MARK: - UICollectionViewDelegateFlowLayout
extension MovieListView: UICollectionViewDelegateFlowLayout {
   
   func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
      let width : CGFloat = UIScreen.main.bounds.width / 3 - 10
      return CGSize(width: width, height: ViewTrait.height)
   }
   
   func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
      return UIEdgeInsets(top: ViewTrait.defaultPadding, left: ViewTrait.defaultPadding, bottom: ViewTrait.defaultPadding, right: ViewTrait.defaultPadding)
   }
}


//MARK: - Constraints Zone
private extension MovieListView {
   
   func addSubviews() {
      addSubviewWC(activityIndicator)
      addSubviewWC(collectionView)
   }
   
   func setupConstraints() {
      NSLayoutConstraint.activate([
         
         collectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
         collectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
         collectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
         collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
         
         activityIndicator.centerXAnchor.constraint(equalTo: collectionView.centerXAnchor),
         activityIndicator.centerYAnchor.constraint(equalTo: collectionView.centerYAnchor),
      ])
   }
}
