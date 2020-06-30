//
//  UIView+Additions.swift
//  CinemaApp
//
//  Created by Ana on 26/11/2019.
//  Copyright © 2019 Ana Popilian. All rights reserved.
//

import UIKit

extension UIView {
  
  func addSubviewWC(_ subview: UIView) {
    subview.translatesAutoresizingMaskIntoConstraints = false
    addSubview(subview)
  }
  
  func dropShadow() {
    layer.shadowColor = UIColor.darkGray.cgColor
    layer.shadowOpacity = 1
    layer.shadowOffset = CGSize(width: 1, height: 1)
    layer.shadowRadius = 2
    layer.shouldRasterize = true
    layer.rasterizationScale = UIScreen.main.scale
    
  }
}
