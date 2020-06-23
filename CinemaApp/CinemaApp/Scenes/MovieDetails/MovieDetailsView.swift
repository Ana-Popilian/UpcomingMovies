//
//  MovieDetailsView.swift
//  CinemaApp
//
//  Created by Ana on 13/12/2019.
//  Copyright © 2019 Ana Popilian. All rights reserved.
//

import UIKit


final class MovieDetailsView : UIView {
  
  private var movieNameLabel: UILabel!
  private var movieImageView: UIImageView!
  private var movieReleaseDateLabel: UILabel!
  private var moviePopularityLabel: UILabel!
  private var movieOverviewTextView: UILabel!
  
  private enum ViewTrait {
    static let defaultVerticalSpacing: CGFloat = 15
    static let defaultHorizontalSpacing: CGFloat = 10
    static let imageHeight: Int = 350
    static let imageWidth: Int = 300
    static let smallFontSize: UIFont = UIFont.systemFont(ofSize: 14)
    static let bigFontSize: UIFont = UIFont.boldSystemFont(ofSize: 15)
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = ColorHelper.customGray
    
    setupMovieNameLabel()
    setupMovieImageView()
    setupMovieReleaseDateLabel()
    setupMoviePopularityLabel()
    setupMovieOverviewTextView()
    
    addSubviews()
    setupConstraints()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func bindView(movie: MovieModel) {
    movieNameLabel.text = movie.title
    movieReleaseDateLabel.text = ("Release Date: \(movie.releaseDate)")
    moviePopularityLabel.text = ("Popularity: \(movie.popularity)")
    movieOverviewTextView.text = ("Overview \n\(movie.overview)")
    
    guard let imageUrl = movie.image else {
      movieImageView.addPlaceholder()
      return
    }
    movieImageView.downloadImage(fromUrl: imageUrl, width: ViewTrait.imageWidth)
  }
}


// MARK: - Private Zone
private extension MovieDetailsView {
  
  func setupMovieNameLabel() {
    movieNameLabel = UILabel()
    movieNameLabel.font = ViewTrait.bigFontSize
    movieNameLabel.numberOfLines = 2
    movieNameLabel.textAlignment = .center
    movieNameLabel.textColor = .black
  }
  
  func setupMovieImageView() {
    movieImageView = UIImageView()
    movieImageView.contentMode = .scaleAspectFill
    movieImageView.clipsToBounds = true
  }
  
  func setupMovieReleaseDateLabel() {
    movieReleaseDateLabel = UILabel()
    movieReleaseDateLabel.font = ViewTrait.smallFontSize
    movieReleaseDateLabel.textAlignment = .center
    movieReleaseDateLabel.textColor = .black
  }
  
  func setupMoviePopularityLabel() {
    moviePopularityLabel = UILabel()
    moviePopularityLabel.font = ViewTrait.smallFontSize
    moviePopularityLabel.textAlignment = .center
    moviePopularityLabel.textColor = .black
  }
  
  func setupMovieOverviewTextView() {
    movieOverviewTextView = UILabel()
    movieOverviewTextView.font = ViewTrait.smallFontSize
    movieOverviewTextView.textAlignment = .natural
    movieOverviewTextView.textColor = .black
    movieOverviewTextView.numberOfLines = 20
  }
}


//MARK: - Constraints Zone
private extension MovieDetailsView {
  
  func addSubviews() {
    addSubviewWC(movieNameLabel)
    addSubviewWC(movieImageView)
    addSubviewWC(movieReleaseDateLabel)
    addSubviewWC(moviePopularityLabel)
    addSubviewWC(movieOverviewTextView)
  }
  
  func setupConstraints() {
    NSLayoutConstraint.activate([
      
      movieNameLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: ViewTrait.defaultVerticalSpacing),
      movieNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
      movieNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
      
      movieImageView.topAnchor.constraint(equalTo: movieNameLabel.bottomAnchor, constant: ViewTrait.defaultVerticalSpacing),
      movieImageView.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
      movieImageView.widthAnchor.constraint(equalToConstant: CGFloat(ViewTrait.imageHeight)),
      movieImageView.heightAnchor.constraint(equalToConstant: CGFloat(ViewTrait.imageHeight)),
      
      movieReleaseDateLabel.topAnchor.constraint(equalTo: movieImageView.bottomAnchor, constant: ViewTrait.defaultVerticalSpacing),
      movieReleaseDateLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
      movieReleaseDateLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
      
      moviePopularityLabel.topAnchor.constraint(equalTo: movieReleaseDateLabel.bottomAnchor, constant: ViewTrait.defaultVerticalSpacing),
      moviePopularityLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
      moviePopularityLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
      
      movieOverviewTextView.topAnchor.constraint(equalTo: moviePopularityLabel.bottomAnchor, constant: ViewTrait.defaultVerticalSpacing),
      movieOverviewTextView.leadingAnchor.constraint(equalTo: movieImageView.leadingAnchor),
      movieOverviewTextView.trailingAnchor.constraint(equalTo: movieImageView.trailingAnchor),
      movieOverviewTextView.bottomAnchor.constraint(equalTo: bottomAnchor)
    ])
  }
}
