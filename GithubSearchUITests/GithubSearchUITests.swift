//
//  GithubSearchUITests.swift
//  GithubSearchUITests
//
//  Created by Dhanashri on 15/11/21.
//

import XCTest

class GithubSearchUITests: XCTestCase {
 
    let app = XCUIApplication()
    
    override func setUpWithError() throws {
        app.launch()
        continueAfterFailure = false
    }
    
    override func tearDownWithError() throws {}
    
   
    func testtitle() {
        let title = app.staticTexts["Github Search"]
        XCTAssertTrue(title.waitForExistence(timeout: 10))
    }

    func testTextfield() {
        let textfield = app.textFields["searchTextField"]
        XCTAssertTrue(textfield.waitForExistence(timeout: 10))
        textfield.tap()
    }
    
    func testMinSearchPhraseLenght() {
        let textfield = app.textFields["searchTextField"]
        let errorAlert = app.alerts["Error"]
        XCTAssertTrue(textfield.waitForExistence(timeout: 5))
        textfield.setText(text: "Swi", application: app)
        textfield.tap()
        app.typeText("\n")
        XCTAssertTrue(errorAlert.waitForExistence(timeout: 10))
        errorAlert.tap()
    }
    
    func testMaxSearchPhraseLenght() {
        let textfield = app.textFields["searchTextField"]
        let errorAlert = app.alerts["Error"]
        XCTAssertTrue(textfield.waitForExistence(timeout: 5))
        textfield.setText(text: "Swiwewrewrewfdsfdgfdgfhgfbhgfbfsvdffewfewfewfefwfedfcdf", application: app)
        textfield.tap()
        app.typeText("\n")
        XCTAssertTrue(errorAlert.waitForExistence(timeout: 10))
        errorAlert.tap()
    }
    
    func testInvalidSpecialCharactersPhrase() {
        let textfield = app.textFields["searchTextField"]
        let errorAlert = app.alerts["Error"]
        XCTAssertTrue(textfield.waitForExistence(timeout: 5))
        textfield.setText(text: "Swift$", application: app)
        textfield.tap()
        app.typeText("\n")
        XCTAssertTrue(errorAlert.waitForExistence(timeout: 10))
        errorAlert.tap()
    }
    
    func testValidSearchPhrase() {
        let textfield = app.textFields["searchTextField"]
        let errorAlert = app.alerts["Error"]
        XCTAssertTrue(textfield.waitForExistence(timeout: 5))
        textfield.setText(text: "Swift.", application: app)
        textfield.tap()
        app.typeText("\n")
        XCTAssertFalse(errorAlert.waitForExistence(timeout: 10))
    }

    func testTableView() {
        let searchTable = app.tables["tableView"]
        XCTAssertTrue(searchTable.waitForExistence(timeout: 10))
        searchTable.swipeUp()
    }
    
    func testTableViewHasNoData() {
        let searchTable = app.tables["tableView"]
        XCTAssertTrue(searchTable.waitForExistence(timeout: 10))
        XCTAssertFalse(searchTable.staticTexts.count > 0)
    }
    
    func testTableViewHasSomeData() {
        let searchTable = app.tables["tableView"]
        XCTAssertTrue(searchTable.waitForExistence(timeout: 10))
        self.testValidSearchPhrase()
        XCTAssertTrue(searchTable.staticTexts.count > 0)
    }
    
    func testTableViewCellTap() {
        let searchTable = app.tables["tableView"]
        XCTAssertTrue(searchTable.waitForExistence(timeout: 10))
        self.testValidSearchPhrase()
        XCTAssertTrue(searchTable.staticTexts.count > 0)
        
        let firstCell = searchTable.cells.element(boundBy: 0)
        XCTAssertTrue(firstCell.exists)
        firstCell.tap()
        
        _ = app.otherElements["URL"]
    }
    
}

extension XCUIElement {
    // The following is a workaround for inputting text in the
    //simulator. In the Simulator, make sure I/O -> Keyboard -> Connect hardware keyboard is off.
    func setText(text: String, application: XCUIApplication) {
        tap()
        UIPasteboard.general.string = text
        doubleTap()
        application.menuItems["Paste"].tap()
    }
}



