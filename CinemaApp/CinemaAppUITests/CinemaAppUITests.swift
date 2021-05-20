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
      
      continueAfterFailure = false
      app = XCUIApplication()
      app.launch()
   }
   
   override func tearDown() {
      super.tearDown()
   }
   
   func testCellElements() {
      wait(forElement: app.movieImageView, timeout: 3)
      wait(forElement: app.movieNameLabel, timeout: 3)
   }
   
   func testScrollView() {
      let firstDisplayedCells = app.collectionView.cells.matching(identifier: "collection-cell").count
      app.collectionView.swipeUp()
      let allCells = firstDisplayedCells + app.collectionView.cells.matching(identifier: "collection-cell").count
      
      XCTAssertNotEqual(firstDisplayedCells, allCells)
   }
   
   func testTapOnCollectionViewCell() {
      app.collectionViewCell.firstMatch.tap()
      wait(forElement: app.movieDetailsTitleLabel, timeout: 3)
      wait(forElement: app.movieDetailsImageView, timeout: 3)
      wait(forElement: app.movieScoreLabel, timeout: 3)
      XCTAssertTrue(app.movieSeparatorView.exists)
      wait(forElement: app.movieGenreLabel, timeout: 3)
      wait(forElement: app.movieReleaseDateLabel, timeout: 3)
      wait(forElement: app.movieOverviewLabel, timeout: 3)
   }
   
   func testGoBack() {
      app.collectionViewCell.firstMatch.tap()
      app.backButton.tap()
      wait(forElement: app.movieImageView, timeout: 3)
   }
}


// MARK: - XCUIApplication extension
private extension XCUIApplication {
   
   var collectionView: XCUIElement { self.collectionViews["collection-view"]}
   var collectionViewCell: XCUIElement { self.collectionViews.cells["collection-cell"] }
   var movieImageView: XCUIElement { self.collectionViews.cells.images["image-view"] }
   var movieNameLabel: XCUIElement { self.collectionViews.cells.staticTexts["movie-label"] }
   var screenTitleLabel: XCUIElement { self.staticTexts["title-label"] }
   var movieDetailsTitleLabel: XCUIElement { self.navigationBars.staticTexts["movie-title"] }
   var movieDetailsImageView: XCUIElement { self.scrollViews.images["movie-image"] }
   var movieScoreLabel: XCUIElement { self.scrollViews.staticTexts["movie-score"] }
   var movieSeparatorView: XCUIElement { self.scrollViews.otherElements["separator-view"] }
   var movieGenreLabel: XCUIElement { self.scrollViews.staticTexts["movie-genre"] }
   var movieReleaseDateLabel: XCUIElement { self.scrollViews.staticTexts["movie-release"] }
   var movieOverviewLabel: XCUIElement { self.scrollViews.staticTexts["movie-overview"] }
   var backButton: XCUIElement { self.navigationBars.buttons["Back"] }
}
