//
//  UILabel+Additions.swift
//  CinemaApp
//
//  Created by Ana on 29/06/2020.
//  Copyright © 2020 Ana Popilian. All rights reserved.
//

import UIKit

extension UILabel {
  
  convenience init(text: String? = nil, font: UIFont, textAlignment: NSTextAlignment, textColor: UIColor) {
    self.init()
    self.text = text
    self.textColor = textColor
    self.font = font
    self.textAlignment = textAlignment
  }
}
