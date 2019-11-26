//
//  UIView+Additions.swift
//  CinemaApp
//
//  Created by Ana on 26/11/2019.
//  Copyright © 2019 Ana Popilian. All rights reserved.
//

import UIKit

extension UIView {
  
  func addSubviewWithoutConstraints(_ subview: UIView) {
    subview.translatesAutoresizingMaskIntoConstraints = false
    addSubview(subview)
  }
}
