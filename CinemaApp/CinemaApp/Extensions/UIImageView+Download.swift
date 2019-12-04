//
//  UIImage+Download.swift
//  CinemaApp
//
//  Created by Ana on 04/12/2019.
//  Copyright © 2019 Ana Popilian. All rights reserved.
//

import UIKit

extension UIImageView {
  
  func downloadImage(fromUrl url: String) {
    let networkManager = NetworkManager()
    networkManager.fetchImage(imageUrl: url, completion: { data in
      guard let data = data else {
        return
      }
      
      let image = UIImage(data: data)
      DispatchQueue.main.async {
        self.image = image
      }
    })
  }
}
