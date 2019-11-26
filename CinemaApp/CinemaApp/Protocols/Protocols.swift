//
//  Protocols.swift
//  CinemaApp
//
//  Created by Ana on 26/11/2019.
//  Copyright © 2019 Ana Popilian. All rights reserved.
//

import Foundation

protocol Identifiable {
  
  static var identifier: String { get }
}

extension Identifiable {
  
  static var identifier: String {
    return String(describing: self)
  }
}
