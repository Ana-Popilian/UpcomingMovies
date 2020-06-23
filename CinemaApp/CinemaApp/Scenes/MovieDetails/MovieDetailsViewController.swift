//
//  MovieDetailsViewController.swift
//  CinemaApp
//
//  Created by Ana on 13/12/2019.
//  Copyright © 2019 Ana Popilian. All rights reserved.
//

import UIKit

final class MovieDetailsViewController: UIViewController {
  
  var currentMovie: MovieModel!
  private var movieDetailsView: MovieDetailsView!
  
  override func loadView() {
    
    movieDetailsView = MovieDetailsView()
    
    navigationController?.navigationBar.barTintColor = ColorHelper.customGray
    navigationController?.navigationBar.tintColor = UIColor.black
    
    view = movieDetailsView
    movieDetailsView.bindView(movie: currentMovie)
  }
}
