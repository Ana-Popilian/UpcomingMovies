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
    
    view = movieDetailsView
    view.backgroundColor = ColorHelper.darkPurple
    movieDetailsView.bindView(movie: currentMovie)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
}
