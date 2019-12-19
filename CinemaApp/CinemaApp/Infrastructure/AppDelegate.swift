//
//  AppDelegate.swift
//  CinemaApp
//
//  Created by Ana on 26/11/2019.
//  Copyright © 2019 Ana Popilian. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
    window = UIWindow(frame: UIScreen.main.bounds)
    
    let nextViewController = MovieListViewController()
    let navigation = UINavigationController(rootViewController: nextViewController)
    
    window?.rootViewController = navigation
    window?.makeKeyAndVisible()
    return true
  }
}

