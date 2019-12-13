//
//  MovieDetailsView.swift
//  CinemaApp
//
//  Created by Ana on 13/12/2019.
//  Copyright © 2019 Ana Popilian. All rights reserved.
//

import UIKit


final class MovieDetailsView : UIView{
  
  
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
  
  private let movieOverviewLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.boldSystemFont(ofSize: 14)
    label.textAlignment = .center
    label.textColor = .white
    return label
  }()
}


//MARK: - Constraints Zone
private extension MovieDetailsView {
  
  func addSubviews() {
    addSubviewWithoutConstraints(movieNameLabel)
    addSubviewWithoutConstraints(movieReleaseDateLabel)
    addSubviewWithoutConstraints(moviePopularityLabel)
    addSubviewWithoutConstraints(movieOverviewLabel)
  }
  
  func setupConstraints() {
    NSLayoutConstraint.activate([
      
    ])
  }
}
