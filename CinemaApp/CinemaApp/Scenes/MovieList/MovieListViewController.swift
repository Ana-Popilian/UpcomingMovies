//
//  ViewController.swift
//  CinemaApp
//
//  Created by Ana on 26/11/2019.
//  Copyright © 2019 Ana Popilian. All rights reserved.
//

import UIKit

class MovieListViewController: UIViewController {
  
  let networkManager = NetworkManager()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    networkManager.getUpcomingMovies { [weak self] (movies) in
      guard self != nil else { return }
    }
  }
}

