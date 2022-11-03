//
//  HappyPawaWelcomeUITests.swift
//  HappyPawsUITests
//
//  Created by Greg Pearman on 11/3/22.
//

import XCTest

class HappyPawsWelcomeUITests: XCTestCase {
  var app: XCUIApplication!
  var tabBar: XCUIElement!
  var welcomeTab: XCUIElement!
  var splashScreenPause: UInt32 = 15

  override func setUpWithError() throws {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    app = XCUIApplication()
    app.launch()
    tabBar = app.tabBars["Tab Bar"]
    welcomeTab = tabBar.buttons["WelcomeTab"]

    // In UI tests it is usually best to stop immediately when a failure occurs.
    continueAfterFailure = false

    // In UI tests it’s important to set the initial state - such as interface orientation -
    // required for your tests before they run. The setUp method is a good place to do this.
    XCUIDevice.shared.orientation = .portrait
  }

  override func tearDownWithError() throws {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }

  func testWelcomeTabDisplaysWelcomeView() {
    sleep(splashScreenPause)

    welcomeTab.tap()
    XCTAssert(
      app.staticTexts[
        "Welcome!"
      ].waitForExistence(timeout: 2)
    )
  }

  func testWelcomeViewDisplaysOnboadingSheet() throws {
    sleep(splashScreenPause)

    let onboardingSheetButton = app.buttons["ShowOnboardingSheetButton"]
    let onboardingViewCloseButton = app.buttons["CloseOnboardingViewButton"]

    welcomeTab.tap()
    onboardingSheetButton.tap()

    XCTAssert(onboardingViewCloseButton.waitForExistence(timeout: 2))

    onboardingViewCloseButton.tap()
  }
}
