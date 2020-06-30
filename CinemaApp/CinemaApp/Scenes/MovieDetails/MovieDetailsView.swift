//
//  MovieDetailsView.swift
//  CinemaApp
//
//  Created by Ana on 13/12/2019.
//  Copyright © 2019 Ana Popilian. All rights reserved.
//

import UIKit


final class MovieDetailsView : UIView {
  
  private var scrollView: UIScrollView!
  private var containerView: UIView!
  private var movieImageView: UIImageView!
  private var userScoreLabel: UILabel!
  private var separatorView: UIView!
  private var movieGenreLabel: UILabel!
  private var movieReleaseDateLabel: UILabel!
  private var movieOverviewLabel: UILabel!
  
  private enum ViewTrait {
    static let defaultVerticalSpacing: CGFloat = 15
    static let defaultHorizontalSpacing: CGFloat = 20
    static let imageWidth: Int = 500
    static let separatorHeight: CGFloat = 1
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = ColorHelper.customGray
    
    setupScrollView()
    setupContainerView()
    setupMovieImageView()
    setupSeparatorView()
    setupMovieGenreLabel()
    setupMovieReleaseDateLabel()
    setupUserScoreLabel()
    setupMovieOverviewTextView()
    
    addSubviews()
    setupConstraints()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func bindView(movie: MovieModel) {
    
    let dateFormatterGet = DateFormatter()
    dateFormatterGet.dateFormat = "yyyy-MM-dd"
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd MMM yyyy"
    let date: Date? = dateFormatterGet.date(from: movie.releaseDate)
    let formattedDate = dateFormatter.string(from: date!)
    
    movieGenreLabel.text = "Genre: \(movie.genre)"
    movieReleaseDateLabel.text = "Release Date: \(formattedDate)"
    userScoreLabel.text = ("User Score: \(movie.vote) / 10")
    movieOverviewLabel.text = ("Overview \n\n \(movie.overview)")
    
    guard let imageUrl = movie.backdropPath else {
      movieImageView.addPlaceholder()
      return
    }
    movieImageView.downloadImage(fromUrl: imageUrl, width: ViewTrait.imageWidth)
  }
}


// MARK: - Private Zone
private extension MovieDetailsView {
  
  func setupScrollView() {
    scrollView = UIScrollView()
  }
  
  func setupContainerView() {
    containerView = UIView()
  }
  
  func setupMovieImageView() {
    movieImageView = UIImageView()
    movieImageView.contentMode = .scaleAspectFill
    movieImageView.clipsToBounds = true
  }
  
  func setupUserScoreLabel() {
     let font = UIFont.systemFont(ofSize: 15)
     userScoreLabel = UILabel(font: font, textAlignment: .center, textColor: .black)
   }
  
  func setupSeparatorView() {
    separatorView = UIView()
    separatorView.backgroundColor = .black
  }
  
  func setupMovieGenreLabel() {
    let font = UIFont.systemFont(ofSize: 14)
    movieGenreLabel = UILabel(text: "Genre:", font: font, textAlignment: .natural, textColor: .black)
  }
  
  func setupMovieReleaseDateLabel() {
    let font = UIFont.systemFont(ofSize: 14)
    movieReleaseDateLabel = UILabel(font: font, textAlignment: .natural, textColor: .black)
  }
  
  func setupMovieOverviewTextView() {
    let font = UIFont.systemFont(ofSize: 14)
    movieOverviewLabel = UILabel(font: font, textAlignment: .natural, textColor: .black)
    movieOverviewLabel.numberOfLines = 0
  }
}


//MARK: - Constraints Zone
private extension MovieDetailsView {
  
  func addSubviews() {
    addSubviewWC(scrollView)
    scrollView.addSubviewWC(containerView)
    containerView.addSubviewWC(movieImageView)
    containerView.addSubviewWC(userScoreLabel)
    containerView.addSubviewWC(separatorView)
    containerView.addSubviewWC(movieGenreLabel)
    containerView.addSubviewWC(movieReleaseDateLabel)
    containerView.addSubviewWC(movieOverviewLabel)
  }
  
  func setupConstraints() {
    NSLayoutConstraint.activate([
      
      scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
      scrollView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
      scrollView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
      scrollView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
      
      containerView.topAnchor.constraint(equalTo: scrollView.topAnchor),
      containerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
      containerView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
      containerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
      containerView.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor),
      
      movieImageView.topAnchor.constraint(equalTo: containerView.topAnchor),
      movieImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
      movieImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
      
      userScoreLabel.topAnchor.constraint(equalTo: movieImageView.bottomAnchor, constant: ViewTrait.defaultVerticalSpacing),
      userScoreLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: ViewTrait.defaultHorizontalSpacing),
      userScoreLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -ViewTrait.defaultHorizontalSpacing),
      
      separatorView.topAnchor.constraint(equalTo: userScoreLabel.bottomAnchor, constant: ViewTrait.defaultVerticalSpacing),
      separatorView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: ViewTrait.defaultHorizontalSpacing),
      separatorView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -ViewTrait.defaultHorizontalSpacing),
      separatorView.heightAnchor.constraint(equalToConstant: ViewTrait.separatorHeight),
      
      movieGenreLabel.topAnchor.constraint(equalTo: separatorView.bottomAnchor, constant: ViewTrait.defaultVerticalSpacing),
      movieGenreLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: ViewTrait.defaultHorizontalSpacing),
      movieGenreLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -ViewTrait.defaultHorizontalSpacing),
      
      movieReleaseDateLabel.topAnchor.constraint(equalTo: movieGenreLabel.bottomAnchor, constant: ViewTrait.defaultVerticalSpacing),
      movieReleaseDateLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: ViewTrait.defaultHorizontalSpacing),
      movieReleaseDateLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -ViewTrait.defaultHorizontalSpacing),
      
      movieOverviewLabel.topAnchor.constraint(equalTo: movieReleaseDateLabel.bottomAnchor, constant: ViewTrait.defaultVerticalSpacing),
      movieOverviewLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: ViewTrait.defaultHorizontalSpacing),
      movieOverviewLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -ViewTrait.defaultHorizontalSpacing),
      movieOverviewLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -ViewTrait.defaultVerticalSpacing)
    ])
  }
}
