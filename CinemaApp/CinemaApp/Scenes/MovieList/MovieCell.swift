//
//  MovieCell.swift
//  CinemaApp
//
//  Created by Ana on 26/11/2019.
//  Copyright © 2019 Ana Popilian. All rights reserved.
//

import UIKit

final class MovieCell: UICollectionViewCell, Identifiable {
   
   private var activityIndicator: UIActivityIndicatorView!
   private var containerView: UIView!
   private var movieImageView: UIImageView!
   private var nameContainerView: UIView!
   private var movieNameLabel: UILabel!
   
   private enum ViewTrait {
      static let imageMult: CGFloat = 0.7
      static let defaultSpacing: CGFloat = 3
   }
   
   override init(frame: CGRect) {
      super.init(frame: frame)
      
      dropShadow()
      
      setupContainerView()
      setupMovieImageView()
      setupNameContainer()
      setupMovieNameLabel()
      
      setupActivityIndicator()
      addSubviews()
      setupConstraints()
      accessibilityIdentifier = "collection-cell"
   }
   
   required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
   
   override func prepareForReuse() {
      super.prepareForReuse()
      movieImageView.image = nil
   }
   
   func bindCell(movie: MovieModel) {
      
      activityIndicator.startAnimating()
      movieNameLabel.text = movie.title
      
      guard let imageUrl = movie.portraitPath else {
         activityIndicator.stopAnimating()
         movieImageView.addPlaceholder()
         return
      }
      movieImageView.downloadImage(fromUrl: imageUrl, downloadFinishedHandler: {
         self.activityIndicator.stopAnimating()
      })
   }
}


//MARK: - Private Zone
private extension MovieCell {
   
   func setupActivityIndicator() {
      activityIndicator = UIActivityIndicatorView(style: .large)
      activityIndicator.color = .black
      activityIndicator.hidesWhenStopped = true
   }
   
   func setupContainerView() {
      containerView = UIView()
      containerView.backgroundColor = .white
      containerView.layer.cornerRadius = 10
      containerView.clipsToBounds = true
   }
   
   func setupMovieImageView() {
      movieImageView = UIImageView()
      movieImageView.contentMode = .scaleAspectFill
      movieImageView.accessibilityIdentifier = "image-view"
   }
   
   func setupNameContainer() {
      nameContainerView = UIView()
   }
   
   func setupMovieNameLabel() {
      let font = UIFont.systemFont(ofSize: 12)
      movieNameLabel = UILabel(font: font, textAlignment: .center, textColor: .black)
      movieNameLabel.numberOfLines = 3
      movieNameLabel.accessibilityIdentifier = "movie-label"
   }
}


//MARK: - Constraints Zone
private extension MovieCell {
   
   func addSubviews() {
      addSubviewWC(containerView)
      containerView.addSubviewWC(activityIndicator)
      containerView.addSubviewWC(movieImageView)
      containerView.addSubviewWC(nameContainerView)
      nameContainerView.addSubviewWC(movieNameLabel)
   }
   
   func setupConstraints() {
      NSLayoutConstraint.activate([
         containerView.topAnchor.constraint(equalTo: topAnchor, constant: ViewTrait.defaultSpacing),
         containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: ViewTrait.defaultSpacing),
         containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -ViewTrait.defaultSpacing),
         containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -ViewTrait.defaultSpacing),
         
         movieImageView.topAnchor.constraint(equalTo: containerView.topAnchor),
         movieImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
         movieImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
         movieImageView.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: ViewTrait.imageMult),
         
         nameContainerView.topAnchor.constraint(equalTo: movieImageView.bottomAnchor),
         nameContainerView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
         nameContainerView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
         nameContainerView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
         
         movieNameLabel.leadingAnchor.constraint(equalTo: nameContainerView.leadingAnchor, constant: ViewTrait.defaultSpacing),
         movieNameLabel.centerYAnchor.constraint(equalTo: nameContainerView.centerYAnchor),
         movieNameLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -ViewTrait.defaultSpacing),
         
         activityIndicator.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
         activityIndicator.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
      ])
   }
}
