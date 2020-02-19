//
//  SearchFilterTests.swift
//  ResponsiveSearchTests
//
//  Created by Tejas, Dhanuka on 2020/02/19.
//  Copyright © 2020 Tejas. All rights reserved.
//

import XCTest
@testable import ResponsiveSearch

class SearchFilterTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSearchFilter() {
        
        let cities: [CityInfo] = "citiesTest".decode(Array<CityInfo>.self) ?? []
        let inputCities: [CityInfo] = cities.sortedByCityFirst()
        
        XCTAssertTrue(inputCities.count > 0, "The json file provided does not contain a valid input")
        
        let emptyFilterOutput: [CityInfo] = inputCities.filtered(with: "")
        XCTAssertEqual(inputCities.count, emptyFilterOutput.count, "If there is no filter, it should return the original array")
        
        let cityOnlyFilterOutput: [CityInfo] = inputCities.filtered(with: "H")
        XCTAssertTrue(cityOnlyFilterOutput.count == 2, "Based on the test data, keyword 'H' should return 2 results")
        
        let cityOnlyCaseInsensitiveFilterOutput: [CityInfo] = inputCities.filtered(with: "h")
        XCTAssertEqual(cityOnlyFilterOutput.count, cityOnlyCaseInsensitiveFilterOutput.count, "Filter query should be case insensitive")
        
        let cityOnlyExactFilterOutput: [CityInfo] = inputCities.filtered(with: "hurzuf")
        XCTAssertTrue(cityOnlyExactFilterOutput.count == 1, "Based on the test data, keyword 'hurzuf' should return only 1 result")
        
        let countryOnlyExactFilterOutput: [CityInfo] = inputCities.filtered(with: "us")
        XCTAssertTrue(countryOnlyExactFilterOutput.count == 2, "Based on the test data, keyword 'us' should return 2 results")
        XCTAssertEqual(countryOnlyExactFilterOutput.first?.name, "Arizona", "Based on the test data, keyword 'us' should return first result with city 'Arizona'")
        XCTAssertEqual(countryOnlyExactFilterOutput.last?.name, "Denver", "Based on the test data, keyword 'us' should return last result with city 'Denver'")
        
        let cityAndCountrySingleFilterOutput: [CityInfo] = inputCities.filtered(with: "a")
        XCTAssertTrue(cityAndCountrySingleFilterOutput.count == 2, "Based on the test data, keyword 'us' should return only 1 result")
        XCTAssertEqual(cityAndCountrySingleFilterOutput.first?.name, "Arizona", "Based on the test data, keyword 'a' should return first result with city 'Arizona'")
        XCTAssertEqual(cityAndCountrySingleFilterOutput.last?.name, "Sydney", "Based on the test data, keyword 'a' should return last result with city 'Sydney'")
        
        let invalidFilterOutput: [CityInfo] = inputCities.filtered(with: "$")
        XCTAssertTrue(invalidFilterOutput.isEmpty, "If the input filter is invalid, it shouldnt return any cities")
    }
    
}
