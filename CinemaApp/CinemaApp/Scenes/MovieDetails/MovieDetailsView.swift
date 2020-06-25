//
//  MovieDetailsView.swift
//  CinemaApp
//
//  Created by Ana on 13/12/2019.
//  Copyright © 2019 Ana Popilian. All rights reserved.
//

import UIKit


final class MovieDetailsView : UIView {
  
  private var movieImageView: UIImageView!
  private var movieReleaseDateLabel: UILabel!
  private var moviePopularityLabel: UILabel!
  private var movieOverviewLabel: UILabel!
  
  private enum ViewTrait {
    static let defaultVerticalSpacing: CGFloat = 15
    static let defaultHorizontalSpacing: CGFloat = 10
    static let imageHeight: CGFloat = UIScreen.main.bounds.height * 0.4
    static let imageWidth: Int = 500
    static let smallFontSize: UIFont = UIFont.systemFont(ofSize: 14)
    static let bigFontSize: UIFont = UIFont.boldSystemFont(ofSize: 15)
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = ColorHelper.customGray
    
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
    movieReleaseDateLabel.text = ("Release Date: \(movie.releaseDate)")
    moviePopularityLabel.text = ("Popularity: \(movie.popularity)")
    movieOverviewLabel.text = ("Overview \n\(movie.overview)")
    
    guard let imageUrl = movie.image else {
      movieImageView.addPlaceholder()
      return
    }
    movieImageView.downloadImage(fromUrl: imageUrl, width: ViewTrait.imageWidth)
  }
}


// MARK: - Private Zone
private extension MovieDetailsView {
  
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
    movieOverviewLabel = UILabel()
    movieOverviewLabel.font = ViewTrait.smallFontSize
    movieOverviewLabel.textAlignment = .natural
    movieOverviewLabel.textColor = .black
    movieOverviewLabel.numberOfLines = 20
  }
}


//MARK: - Constraints Zone
private extension MovieDetailsView {
  
  func addSubviews() {
    addSubviewWC(movieImageView)
    addSubviewWC(movieReleaseDateLabel)
    addSubviewWC(moviePopularityLabel)
    addSubviewWC(movieOverviewLabel)
  }
  
  func setupConstraints() {
    NSLayoutConstraint.activate([
      
      movieImageView.topAnchor.constraint(equalTo:safeAreaLayoutGuide.topAnchor),
      movieImageView.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
      movieImageView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
      movieImageView.heightAnchor.constraint(equalToConstant: ViewTrait.imageHeight),
      
      movieReleaseDateLabel.topAnchor.constraint(equalTo: movieImageView.bottomAnchor, constant: ViewTrait.defaultVerticalSpacing),
      movieReleaseDateLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
      movieReleaseDateLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
      
      moviePopularityLabel.topAnchor.constraint(equalTo: movieReleaseDateLabel.bottomAnchor, constant: ViewTrait.defaultVerticalSpacing),
      moviePopularityLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
      moviePopularityLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
      
      movieOverviewLabel.topAnchor.constraint(equalTo: moviePopularityLabel.bottomAnchor, constant: ViewTrait.defaultVerticalSpacing),
      movieOverviewLabel.leadingAnchor.constraint(equalTo: movieImageView.leadingAnchor, constant: ViewTrait.defaultHorizontalSpacing),
      movieOverviewLabel.trailingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: -ViewTrait.defaultHorizontalSpacing),
      movieOverviewLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50)
    ])
  }
}
