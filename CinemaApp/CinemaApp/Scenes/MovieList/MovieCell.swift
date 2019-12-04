//
//  MovieCell.swift
//  CinemaApp
//
//  Created by Ana on 26/11/2019.
//  Copyright © 2019 Ana Popilian. All rights reserved.
//

import UIKit
  
final class MovieCell: UICollectionViewCell, Identifiable {
  
  private enum ViewTrait {
    static let defaultVerticalSpacing: CGFloat = 75
    static let defaultSpacing: CGFloat = 5
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    addSubviews()
    setupConstraints()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  let movieImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFill
    imageView.backgroundColor = .green
    imageView.clipsToBounds = true
    return imageView
  }()
  
  let movieNameLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.boldSystemFont(ofSize: 14)
    label.textAlignment = .center
    label.textColor = .black
    return label
  }()
  
  func bindCell(movie: MovieModel) {
    movieNameLabel.text = movie.title
    
    guard let imageUrl = movie.image else {
      return
    }
    movieImageView.downloadImage(fromUrl: imageUrl)
  }
}


//MARK: - Constraints Zone
private extension MovieCell {
  
  func addSubviews() {
    addSubviewWithoutConstraints(movieImageView)
    addSubviewWithoutConstraints(movieNameLabel)
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
      movieNameLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -ViewTrait.defaultSpacing)
    ])
  }
}
