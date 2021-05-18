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
   private var imageView: UIImageView!
   private var userScoreLabel: UILabel!
   private var separatorView: UIView!
   private var genreLabel: UILabel!
   private var releaseDateLabel: UILabel!
   private var overviewLabel: UILabel!
   
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
      
      releaseDateLabel.text = "Release Date: \(formattedDate)"
      overviewLabel.text = ("Overview \n\n \(movie.overview)")
      
      if movie.vote > 0 {
         userScoreLabel.text = ("User Score: \(movie.vote) / 10")
      } else {
         userScoreLabel.text = ("User Score: Not Rated")
      }
      
      guard let imageUrl = movie.backdropPath else {
         imageView.addPlaceholder()
         return
      }
      imageView.downloadImage(fromUrl: imageUrl, width: ViewTrait.imageWidth)
   }
   
   func setGenres( _ names: [String]) {
      genreLabel.text = "Genre: \(names.joined(separator: ", "))"
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
      imageView = UIImageView()
      imageView.contentMode = .scaleAspectFill
      imageView.clipsToBounds = true
      imageView.backgroundColor = ColorHelper.customGray
   }
   
   func setupUserScoreLabel() {
      let font = UIFont.systemFont(ofSize: 15)
      userScoreLabel = UILabel(font: font, textAlignment: .center, textColor: .white)
   }
   
   func setupSeparatorView() {
      separatorView = UIView()
      separatorView.backgroundColor = .white
   }
   
   func setupMovieGenreLabel() {
      let font = UIFont.systemFont(ofSize: 14)
      genreLabel = UILabel(text: "Genre:", font: font, textAlignment: .natural, textColor: .white)
      genreLabel.numberOfLines = 0
   }
   
   func setupMovieReleaseDateLabel() {
      let font = UIFont.systemFont(ofSize: 14)
      releaseDateLabel = UILabel(font: font, textAlignment: .natural, textColor: .white)
   }
   
   func setupMovieOverviewTextView() {
      let font = UIFont.systemFont(ofSize: 14)
      overviewLabel = UILabel(font: font, textAlignment: .natural, textColor: .white)
      overviewLabel.numberOfLines = 0
   }
}


//MARK: - Constraints Zone
private extension MovieDetailsView {
   
   func addSubviews() {
      addSubviewWC(scrollView)
      scrollView.addSubviewWC(containerView)
      containerView.addSubviewWC(imageView)
      containerView.addSubviewWC(userScoreLabel)
      containerView.addSubviewWC(separatorView)
      containerView.addSubviewWC(genreLabel)
      containerView.addSubviewWC(releaseDateLabel)
      containerView.addSubviewWC(overviewLabel)
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
         
         imageView.topAnchor.constraint(equalTo: containerView.topAnchor),
         imageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
         imageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
         
         userScoreLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: ViewTrait.defaultVerticalSpacing),
         userScoreLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: ViewTrait.defaultHorizontalSpacing),
         userScoreLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -ViewTrait.defaultHorizontalSpacing),
         
         separatorView.topAnchor.constraint(equalTo: userScoreLabel.bottomAnchor, constant: ViewTrait.defaultVerticalSpacing),
         separatorView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: ViewTrait.defaultHorizontalSpacing),
         separatorView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -ViewTrait.defaultHorizontalSpacing),
         separatorView.heightAnchor.constraint(equalToConstant: ViewTrait.separatorHeight),
         
         genreLabel.topAnchor.constraint(equalTo: separatorView.bottomAnchor, constant: ViewTrait.defaultVerticalSpacing),
         genreLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: ViewTrait.defaultHorizontalSpacing),
         genreLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -ViewTrait.defaultHorizontalSpacing),
         
         releaseDateLabel.topAnchor.constraint(equalTo: genreLabel.bottomAnchor, constant: ViewTrait.defaultVerticalSpacing),
         releaseDateLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: ViewTrait.defaultHorizontalSpacing),
         releaseDateLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -ViewTrait.defaultHorizontalSpacing),
         
         overviewLabel.topAnchor.constraint(equalTo: releaseDateLabel.bottomAnchor, constant: ViewTrait.defaultVerticalSpacing),
         overviewLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: ViewTrait.defaultHorizontalSpacing),
         overviewLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -ViewTrait.defaultHorizontalSpacing),
         overviewLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -ViewTrait.defaultVerticalSpacing)
      ])
   }
}
