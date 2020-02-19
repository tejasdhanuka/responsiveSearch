//
//  ResponsiveSearchUITests.swift
//  ResponsiveSearchUITests
//
//  Created by Tejas, Dhanuka on 2020/02/18.
//  Copyright © 2020 Tejas. All rights reserved.
//

import XCTest

extension XCUIApplication {
    var isDisplayingCitiesList: Bool {
        return otherElements["citiesListView"].exists
    }
}

class ResponsiveSearchUITests: XCTestCase {
    let app = XCUIApplication()

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCitiesList() {
        // Use recording to get started writing UI tests.
        
        app.tables.element.cells["Cell-7"].swipeUp()
        
        XCTAssertTrue(app.tables.element.identifier == "citiesListView")
        let element = app.tables.element.staticTexts["CellTitleLabel-7"]
        XCTAssertTrue(element.label == "A dos Cunhados, PT")
    }
    
    func testCitiesListDetail() {
        // Use recording to get started writing UI tests.
        
        app.tables.element.cells["Cell-7"].swipeUp()
        app.tables.element.staticTexts["CellTitleLabel-7"].tap()
        
        XCTAssertTrue(app.tables.element.identifier == "citiesListView")
        XCTAssertTrue(app.navigationBars.buttons["Responsive Search"].label == "Responsive Search")
        XCTAssertTrue(app.navigationBars.element.identifier == "A dos Cunhados, PT")
    }
    
    func testCitiesSearch() {
        // Use recording to get started writing UI tests.
        
        app/*@START_MENU_TOKEN@*/.searchFields["Search"]/*[[".otherElements[\"searchBar\"].searchFields[\"Search\"]",".searchFields[\"Search\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.typeText("t")
        app.typeText("e")
        app.typeText("s")
        app.typeText("t")
        
        XCTAssertTrue(((app.searchFields.element.value as? String) != nil))
        XCTAssertTrue(((app.searchFields.element.value as? String) == "test"))
        let element = app.tables.element.staticTexts["CellTitleLabel-6"]
        if element.waitForExistence(timeout: 2.0) {
            XCTAssertTrue(element.label == "Testorf-Steinfort, DE")
        } else {
            XCTFail("Element CellTitleLabel-6 either needs more time to exist or doesn't exist at all")
        }
    }
    
    func testCitiesSearchCancel() {
        // Use recording to get started writing UI tests.
        
        app/*@START_MENU_TOKEN@*/.searchFields["Search"]/*[[".otherElements[\"searchBar\"].searchFields[\"Search\"]",".searchFields[\"Search\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.typeText("t")
        app.typeText("e")
        app.typeText("s")
        app.typeText("t")
        app/*@START_MENU_TOKEN@*/.buttons["Cancel"]/*[[".otherElements[\"searchBar\"].buttons[\"Cancel\"]",".buttons[\"Cancel\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        XCTAssertTrue(((app.searchFields.element.value as? String) != nil))
        XCTAssertTrue(((app.searchFields.element.value as? String) == "Search"))
        let element = app.tables.element.staticTexts["CellTitleLabel-7"]
        if element.waitForExistence(timeout: 2.0) {
            XCTAssertTrue(element.label == "A dos Cunhados, PT")
        } else {
            XCTFail("Element CellTitleLabel-7 either needs more time to exist or doesn't exist at all")
        }
    }
    
    func testCitiesSearchDetail() {
        // Use recording to get started writing UI tests.
        
        app/*@START_MENU_TOKEN@*/.searchFields["Search"]/*[[".otherElements[\"searchBar\"].searchFields[\"Search\"]",".searchFields[\"Search\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.typeText("t")
        app.typeText("e")
        app.typeText("s")
        app.typeText("t")
        app.tables.element.staticTexts["CellDetailLabel-4"].tap()
        
        XCTAssertTrue(app.navigationBars.buttons["Responsive Search"].label == "Responsive Search")
        XCTAssertTrue(app.navigationBars.element.identifier == "Testorf, DE")
    }
}
