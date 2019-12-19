//
//  MovieDetailsView.swift
//  CinemaApp
//
//  Created by Ana on 13/12/2019.
//  Copyright © 2019 Ana Popilian. All rights reserved.
//

import UIKit


final class MovieDetailsView : UIView{
  
  private enum ViewTrait {
    static let defaultVerticalSpacing: CGFloat = 20
    static let bottomVerticalSpacing: CGFloat = -30
    static let defaultHorizontalSpacing: CGFloat = 10
    static let imageHeight: CGFloat = 300
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    addSubviews()
    setupConstraints()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
  private let movieNameLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.boldSystemFont(ofSize: 16)
    label.textAlignment = .center
    label.textColor = .white
    return label
  }()
  
  private let movieImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFill
    imageView.clipsToBounds = true
    return imageView
  }()
  
  private let movieReleaseDateLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.boldSystemFont(ofSize: 14)
    label.textAlignment = .center
    label.textColor = .white
    return label
  }()
  
  private let moviePopularityLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.boldSystemFont(ofSize: 14)
    label.textAlignment = .center
    label.textColor = .white
    return label
  }()
  
  private let movieOverviewTextView: UITextView = {
    let textView = UITextView()
    textView.font = UIFont.boldSystemFont(ofSize: 14)
    textView.textAlignment = .natural
    textView.textColor = .white
    textView.isEditable = false
    textView.backgroundColor = ColorHelper.darkPurple
    return textView
  }()
  
  func bindView(movie: MovieModel) {
    movieNameLabel.text = movie.title
    movieReleaseDateLabel.text = ("Realease Date: \(movie.releaseDate)")
    moviePopularityLabel.text = ("Popularity: \(movie.popularity)")
    movieOverviewTextView.text = movie.overview
    
    guard let imageUrl = movie.image else {
      movieImageView.contentMode = .scaleAspectFit
      return
    }

    movieImageView.downloadImage(fromUrl: imageUrl, width: 300, downloadFinishedHandler: {
      
    })
  }
}


//MARK: - Constraints Zone
private extension MovieDetailsView {
  
  func addSubviews() {
    addSubviewWithoutConstraints(movieNameLabel)
    addSubviewWithoutConstraints(movieImageView)
    addSubviewWithoutConstraints(movieReleaseDateLabel)
    addSubviewWithoutConstraints(moviePopularityLabel)
    addSubviewWithoutConstraints(movieOverviewTextView)
  }
  
  func setupConstraints() {
    NSLayoutConstraint.activate([
      
      movieNameLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: ViewTrait.defaultVerticalSpacing),
      movieNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
      movieNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
      
      movieImageView.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
      movieImageView.topAnchor.constraint(equalTo: movieNameLabel.bottomAnchor, constant: ViewTrait.defaultVerticalSpacing),
      movieImageView.widthAnchor.constraint(equalToConstant: ViewTrait.imageHeight),
      movieImageView.heightAnchor.constraint(equalToConstant: ViewTrait.imageHeight),
      
      movieReleaseDateLabel.topAnchor.constraint(equalTo: movieImageView.bottomAnchor, constant: ViewTrait.defaultVerticalSpacing),
      movieReleaseDateLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
      movieReleaseDateLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
      
      moviePopularityLabel.topAnchor.constraint(equalTo: movieReleaseDateLabel.bottomAnchor, constant: ViewTrait.defaultVerticalSpacing),
      moviePopularityLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
      moviePopularityLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
      
      movieOverviewTextView.topAnchor.constraint(equalTo: moviePopularityLabel.bottomAnchor, constant: ViewTrait.defaultVerticalSpacing),
      movieOverviewTextView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: ViewTrait.defaultHorizontalSpacing),
      movieOverviewTextView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -ViewTrait.defaultHorizontalSpacing),
      movieOverviewTextView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: ViewTrait.bottomVerticalSpacing)
      
    ])
  }
}
