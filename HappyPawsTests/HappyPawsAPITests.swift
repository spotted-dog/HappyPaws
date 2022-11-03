//
//  HappyPawsTests.swift
//  HappyPawsTests
//
//  Created by Greg Pearman on 10/29/22.
//

import XCTest
@testable import HappyPaws

class HappyPawsAPITests: XCTestCase {
  let timeout: TimeInterval = 4
  var expectation: XCTestExpectation!

  override func setUpWithError() throws {
    expectation = expectation(description: "API responds in a reasonable time")
  }

  override func tearDownWithError() throws {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }

  func testAPIKeyNotReplaces() async {

    XCTAssertFalse(APIConstants.dogAPIKey.contains("<your API key here>"),
                   "You failed to provide a proper Dog API key.")

    self.expectation.fulfill()
    await waitForExpectations(timeout: timeout)
  }

  func testGetAllDogBreeds() async {
    do {
      let dogBreeds = try await DogAPI.getAllDogBreeds()

      XCTAssertFalse(dogBreeds.isEmpty,
                     "DogAPI get all breeds should have returned at least one dog breed, gsap!")
    } catch {
      XCTFail("Caught unexpected error from API call: \(error)")
    }

    self.expectation.fulfill()
    await waitForExpectations(timeout: timeout)
  }

}
