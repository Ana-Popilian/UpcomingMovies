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
  
  private enum ViewTrait {
    static let defaultVerticalSpacing: CGFloat = 75
    static let defaultSpacing: CGFloat = 2
  }
  
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
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
    movieImageView.contentMode = .scaleAspectFill
  }
  
  private let movieImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFill
    imageView.clipsToBounds = true
    return imageView
  }()
  
  private let movieNameLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.boldSystemFont(ofSize: 12)
    label.textAlignment = .center
    label.textColor = .white
    return label
  }()
  
  func bindCell(movie: MovieModel) {
    
    activityIndicator.startAnimating()
    movieNameLabel.text = movie.title
    
    guard let imageUrl = movie.image else {
      activityIndicator.stopAnimating()
      movieImageView.image = UIImage(named: "ic_imagePlaceholder")!
      movieImageView.contentMode = .scaleAspectFit
      return
    }
    movieImageView.downloadImage(fromUrl: imageUrl, downloadFinishedHandler: {
      self.activityIndicator.stopAnimating()
    })
  }
}


//MARK: Private Zone
private extension MovieCell {
  
  func setupActivity() {
    activityIndicator = UIActivityIndicatorView(style: .large)
    activityIndicator.color = .white
    activityIndicator.hidesWhenStopped = true
  }
}


//MARK: - Constraints Zone
private extension MovieCell {
  
  func addSubviews() {
    addSubviewWithoutConstraints(movieImageView)
    addSubviewWithoutConstraints(movieNameLabel)
    addSubviewWithoutConstraints(activityIndicator)
    
  }
  
  func setupConstraints() {
    NSLayoutConstraint.activate([
      
      movieImageView.topAnchor.constraint(equalTo: topAnchor, constant: ViewTrait.defaultSpacing),
      movieImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: ViewTrait.defaultSpacing),
      movieImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -ViewTrait.defaultSpacing),
      movieImageView.heightAnchor.constraint(equalToConstant: ViewTrait.defaultVerticalSpacing),
      
      movieNameLabel.topAnchor.constraint(equalTo: movieImageView.bottomAnchor, constant: ViewTrait.defaultSpacing),
      movieNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: ViewTrait.defaultSpacing),
      movieNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -ViewTrait.defaultSpacing),
      movieNameLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -ViewTrait.defaultSpacing),
      
      
      activityIndicator.widthAnchor.constraint(equalToConstant: 30),
      activityIndicator.heightAnchor.constraint(equalToConstant: 30),
      activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
      activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor)
    ])
  }
}
