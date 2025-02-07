//
//  CatListViewUITests.swift
//  SimpleCatsUITests
//
//  Created by Edson Lipa Urbina on 6/02/25.
//

import XCTest
@testable import SimpleCats

final class CatListViewUITests: XCTestCase {
    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    
    func testInitialLoadingState() throws {
        let loadingIndicator = app.activityIndicators.firstMatch
        let titleText = app.staticTexts["Cats List"]
        
        XCTAssertTrue(loadingIndicator.exists)
        XCTAssertTrue(titleText.exists)
    }
    
    func testCatListDisplay() throws {
        let list = app.collectionViews.firstMatch
        XCTAssertTrue(list.waitForExistence(timeout: 5))
        
        let cells = list.cells
        XCTAssertTrue(cells.count > 0)
        
        let firstCell = cells.firstMatch
        XCTAssertTrue(firstCell.images.firstMatch.exists)
        
        let breedText = firstCell.staticTexts.firstMatch
        XCTAssertTrue(breedText.exists)
    }
    
    func testNavigation() throws {
        let list = app.collectionViews.firstMatch
        XCTAssertTrue(list.waitForExistence(timeout: 5))
        
        // Tap on first cell
        let firstCell = list.cells.firstMatch
        firstCell.tap()
        

        let navBarTitle = app.navigationBars["Cat Details"]
        XCTAssertTrue(navBarTitle.waitForExistence(timeout: 2), "Navigation bar title 'Cat Details' not found")
    }

    func testInfiniteScroll() throws {
        let list = app.collectionViews.firstMatch
        XCTAssertTrue(list.waitForExistence(timeout: 5))

        let initialCellCount = list.cells.count

        // Scroll to bottom
        let lastCell = list.cells.element(boundBy: initialCellCount - 1)
        lastCell.swipeUp()
        
        sleep(2)
        
        XCTAssertTrue(list.cells.count > initialCellCount)
    }
}
