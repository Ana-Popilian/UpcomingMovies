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
    static let defaultVerticalSpacing: CGFloat = 25
    static let bottomVerticalSpacing: CGFloat = -60
    static let defaultHorizontalSpacing: CGFloat = 10
    
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
    label.text = "Frozen"
    label.textColor = .white
    return label
  }()
  
  private let movieImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFill
    imageView.clipsToBounds = true
    imageView.image = UIImage(named: "ic_imagePlaceholder")
    imageView.backgroundColor = .red
    return imageView
  }()
  
  private let movieReleaseDateLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.boldSystemFont(ofSize: 14)
    label.textAlignment = .center
    label.text = "25.12.2019"
    label.textColor = .white
    return label
  }()
  
  private let moviePopularityLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.boldSystemFont(ofSize: 14)
    label.textAlignment = .center
    label.text = "Frozen is 98%"
    label.textColor = .white
    return label
  }()
  
  private let movieOverviewLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.boldSystemFont(ofSize: 14)
    label.textAlignment = .natural
    label.numberOfLines = 4
    label.text = "Frozen is a movie In order to change the color of status bar we have do two changes define the property of view controller-based status bar property in your info.plist file"
    label.textColor = .white
    return label
  }()
  
  func bindView(movie: MovieModel) {
    movieNameLabel.text = movie.title
    movieReleaseDateLabel.text = movie.releaseDate
    moviePopularityLabel.text = String(movie.popularity)
    movieOverviewLabel.text = movie.overview
    
    guard let imageUrl = movie.image else {
      movieImageView.contentMode = .scaleAspectFit
      return
    }
    movieImageView.downloadImage(fromUrl: imageUrl, downloadFinishedHandler: {
      
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
    addSubviewWithoutConstraints(movieOverviewLabel)
  }
  
  func setupConstraints() {
    NSLayoutConstraint.activate([
      
      movieNameLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: ViewTrait.defaultVerticalSpacing),
      movieNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
      movieNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
      
      movieImageView.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
      movieImageView.topAnchor.constraint(equalTo: movieNameLabel.bottomAnchor, constant: ViewTrait.defaultVerticalSpacing),
      movieImageView.widthAnchor.constraint(equalToConstant: 300),
      movieImageView.heightAnchor.constraint(equalToConstant: 300),
      
      movieReleaseDateLabel.topAnchor.constraint(equalTo: movieImageView.bottomAnchor, constant: ViewTrait.defaultVerticalSpacing),
      movieReleaseDateLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
      movieReleaseDateLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
      
      moviePopularityLabel.topAnchor.constraint(equalTo: movieReleaseDateLabel.bottomAnchor, constant: ViewTrait.defaultVerticalSpacing),
      moviePopularityLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
      moviePopularityLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
      
      movieOverviewLabel.topAnchor.constraint(equalTo: moviePopularityLabel.bottomAnchor, constant: ViewTrait.defaultVerticalSpacing),
      movieOverviewLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: ViewTrait.defaultHorizontalSpacing),
      movieOverviewLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -ViewTrait.defaultHorizontalSpacing),
      movieOverviewLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: ViewTrait.bottomVerticalSpacing)
      
    ])
  }
}
