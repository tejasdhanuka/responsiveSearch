//
//  ResponsiveSearchTests.swift
//  ResponsiveSearchTests
//
//  Created by Tejas, Dhanuka on 2020/02/18.
//  Copyright © 2020 Tejas. All rights reserved.
//

import XCTest
@testable import ResponsiveSearch

class ResponsiveSearchTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testPerformanceDecodeCities() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
            _ = "cities".decode(Array<CityInfo>.self)
        }
    }
    
    func testPerformanceSearchCities() {
        let cities: [CityInfo] = "cities".decode(Array<CityInfo>.self) ?? []
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
            _ = cities.filtered(with: "a")
        }
    }
    
    func testPerformanceSortCities() {
        let cities: [CityInfo] = "cities".decode(Array<CityInfo>.self) ?? []
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
            _ = cities.sortedByCityFirst()
        }
    }

}
