//
//  ViewProviderTests.swift
//  ResponsiveSearchTests
//
//  Created by Tejas, Dhanuka on 2020/02/19.
//  Copyright © 2020 Tejas. All rights reserved.
//

import XCTest
@testable import ResponsiveSearch

class ViewProviderTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testViewProviderConfigureDecodedCityInfo() {
        
        let model = ModelType<[CityInfo]>.cities
        let citiesController = MasterViewController()
        
        let viewModelPresenter = Presenter(view: citiesController, model: model)
        citiesController.presenter = viewModelPresenter
        
        let expectation = self.expectation(description: "CityDecoding")
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            expectation.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
        
        let viewProviderTest = MasterViewController()
        viewProviderTest.configure(with: citiesController.decodedInfo)
        
        XCTAssertNotNil(viewProviderTest.decodedInfo)
        XCTAssertTrue(viewProviderTest.decodedInfo.count > 0)
    }
}
