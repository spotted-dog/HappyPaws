//
//  HappyPawsUITests.swift
//  HappyPawsUITests
//
//  Created by Greg Pearman on 10/29/22.
//

import XCTest

class HappyPawsDogsUITests: XCTestCase {
  var app: XCUIApplication!
  var tabBar: XCUIElement!
  var dogHouseTab: XCUIElement!
  var splashScreenPause: UInt32 = 15

  override func setUpWithError() throws {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    app = XCUIApplication()
    app.launch()
    tabBar = app.tabBars["Tab Bar"]
    dogHouseTab = tabBar.buttons["DogHouseTab"]

    // In UI tests it is usually best to stop immediately when a failure occurs.
    continueAfterFailure = false

    // In UI tests it’s important to set the initial state - such as interface orientation -
    // required for your tests before they run. The setUp method is a good place to do this.
    XCUIDevice.shared.orientation = .portrait
  }

  override func tearDownWithError() throws {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }

  func testDogsViewHasDogs() throws {
    sleep(splashScreenPause)

    let dottieTableRow = app.tables.cells["Dottie"]

    dogHouseTab.tap()

    XCTAssert(dottieTableRow.waitForExistence(timeout: 2))
  }

  func testPetDetailsViewFavoriteExists() {
    sleep(splashScreenPause)

    let dottieTableRow = app.tables.cells["Dottie"]

    dogHouseTab.tap()
    dottieTableRow.tap()

    let favoriteButton = app.buttons["FavoriteButton"]

    XCTAssert(favoriteButton.waitForExistence(timeout: 2))

    app.navigationBars["Dottie"].buttons["All Dogs"].tap()
  }
}
