//
//  ViewModelPresenterTests.swift
//  ResponsiveSearchTests
//
//  Created by Tejas, Dhanuka on 2020/02/19.
//  Copyright © 2020 Tejas. All rights reserved.
//

import XCTest
@testable import ResponsiveSearch

class ViewModelPresenterTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testViewModelPresenterCityInfo() {
        
        let model = ModelType<[CityInfo]>.cities
        let citiesController = MasterViewController()
        
        let viewModelPresenter = Presenter(view: citiesController, model: model)
        viewModelPresenter.loadInfo()
        
        let expectation = self.expectation(description: "CityDecoding")
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            expectation.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
        
        XCTAssertNotNil(citiesController.decodedInfo)
        XCTAssertTrue(citiesController.decodedInfo.count > 0)
    }
}
