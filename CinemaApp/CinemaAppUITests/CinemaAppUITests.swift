//
//  CinemaAppUITests.swift
//  CinemaAppUITests
//
//  Created by Ana Popilian on 18/05/2021.
//  Copyright © 2021 Ana Popilian. All rights reserved.
//

import XCTest

class CinemaAppUITests: XCTestCase {
   
   var app: XCUIApplication!
   
   override func setUp() {
      super.setUp()
      // Put setup code here. This method is called before the invocation of each test method in the class.
      
      // In UI tests it is usually best to stop immediately when a failure occurs.
      continueAfterFailure = false
      app = XCUIApplication()
      app.launchArguments = ["uitesting"]
      app.launch()
      // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
   }
   
   override func tearDown() {
      super.tearDown()
   }
   
   //   func testActivityIndicatorLoading() {
   //      app = XCUIApplication()
   //      app.launch()
   //      XCTAssertTrue(app.activityIndicator.exists)
   //   }
   
   func testLoadMovieList() {
      app = XCUIApplication()
      app.launch()
      XCTAssertTrue(app.collectionView.exists)
   }
   
   func testLoadImage() {
      app = XCUIApplication()
      app.launch()
      XCTAssertTrue(app.movieImageView.exists)
   }
   
   func testShowMovieTitleLabel() {
      app = XCUIApplication()
      app.launch()
      XCTAssertTrue(app.movieNameLabel.exists)
   }
   
   func testDisplayScreenTitle() {
      app = XCUIApplication()
      app.launch()
      XCTAssertTrue(app.screenTitleLabel.exists)
   }
   
   func testTapOnCollectionViewCell() {
      app = XCUIApplication()
      app.launch()
      app.collectionView.tap()
      XCTAssertTrue(app.movieDetailsTitleLabel.exists)
   }
   
   func testLaunchPerformance() throws {
      if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
         // This measures how long it takes to launch your application.
         measure(metrics: [XCTApplicationLaunchMetric()]) {
            XCUIApplication().launch()
         }
      }
   }
}


// MARK: - XCUIApplication extension
private extension XCUIApplication {
   
   var collectionView: XCUIElement { self.collectionViews["collection-view"] }
   var activityIndicator: XCUIElement { self.activityIndicators["activity-indicator"] }
   var movieImageView: XCUIElement { self.images["image-view"] }
   var movieNameLabel: XCUIElement { self.staticTexts["movie-label"] }
   var screenTitleLabel: XCUIElement { self.staticTexts["title-label"] }
   var movieDetailsTitleLabel: XCUIElement { self.staticTexts["movie-title"] }
}
