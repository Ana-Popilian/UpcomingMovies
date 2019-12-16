//
//  MovieDetailsViewController.swift
//  CinemaApp
//
//  Created by Ana on 13/12/2019.
//  Copyright © 2019 Ana Popilian. All rights reserved.
//

import UIKit

final class MovieDetailsViewController: UIViewController {
  
  private var movieDetailsView: MovieDetailsView!
  
  override func loadView() {
    
    movieDetailsView = MovieDetailsView()
    
    view = movieDetailsView
    view.backgroundColor = .darkGray
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
}
