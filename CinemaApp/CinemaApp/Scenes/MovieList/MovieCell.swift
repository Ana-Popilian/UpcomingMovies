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
  private var movieNameLabel: UILabel!
  
  private enum ViewTrait {
    static let movieImageHeight: CGFloat = 160
    static let defaultSpacing: CGFloat = 5
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = ColorHelper.customGray
    layer.cornerRadius = 10
    clipsToBounds = true
    
//    layer.shadowColor = UIColor.red.cgColor
//    layer.shadowOpacity = 0.5
//    layer.masksToBounds = false
//    layer.shadowOffset = .zero
//    layer.shadowRadius = 2
//    layer.shadowPath = UIBezierPath(rect: bounds).cgPath
//    layer.shouldRasterize = true
//    layer.rasterizationScale = UIScreen.main.scale
    
    setupContainerView()
    setupMovieImageView()
    setupMovieNameLabel()
    
    setupActivity()
    addSubviews()
    setupConstraints()
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
    
    guard let imageUrl = movie.image else {
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
  
  func setupActivity() {
    activityIndicator = UIActivityIndicatorView(style: .large)
    activityIndicator.color = .black
    activityIndicator.hidesWhenStopped = true
  }
  
  func setupContainerView() {
    containerView = UIView()
    containerView.backgroundColor = .white
  }
  
  func setupMovieImageView() {
    movieImageView = UIImageView()
    movieImageView.contentMode = .scaleAspectFill
  }
  
  func setupMovieNameLabel() {
    movieNameLabel = UILabel()
    movieNameLabel.font = UIFont.systemFont(ofSize: 13)
    movieNameLabel.textAlignment = .center
    movieNameLabel.textColor = .black
    movieNameLabel.numberOfLines = 2
  }
}


//MARK: - Constraints Zone
private extension MovieCell {
  
  func addSubviews() {
    addSubviewWC(containerView)
    containerView.addSubviewWC(movieImageView)
    containerView.addSubviewWC(movieNameLabel)
    containerView.addSubviewWC(activityIndicator)
  }
  
  func setupConstraints() {
    NSLayoutConstraint.activate([
      containerView.topAnchor.constraint(equalTo: topAnchor),
      containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
      containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
      containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
      
      movieImageView.topAnchor.constraint(equalTo: containerView.topAnchor),
      movieImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
      movieImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
      movieImageView.heightAnchor.constraint(equalToConstant: ViewTrait.movieImageHeight),
      
      movieNameLabel.topAnchor.constraint(equalTo: movieImageView.bottomAnchor, constant: ViewTrait.defaultSpacing),
      movieNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
      movieNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
      movieNameLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
      
      activityIndicator.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
      activityIndicator.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
    ])
  }
}
