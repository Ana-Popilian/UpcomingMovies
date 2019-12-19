//
//  UIImage+Download.swift
//  CinemaApp
//
//  Created by Ana on 04/12/2019.
//  Copyright © 2019 Ana Popilian. All rights reserved.
//

import UIKit

extension UIImageView {
  
  func downloadImage(fromUrl url: String, width: Int = 154, downloadFinishedHandler: @escaping (() -> Void)) {
    
    let networkManager = NetworkManager()
    networkManager.fetchImage(imageUrl: url, width: width, completion: { data in
      guard let data = data else {
        DispatchQueue.main.async {
          downloadFinishedHandler()
        }
        return
      }
      
      let image = UIImage(data: data)
      DispatchQueue.main.async {
        self.image = image
        downloadFinishedHandler()
      }
    })
  }
}
