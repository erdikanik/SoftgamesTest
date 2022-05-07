//
//  StringDateExtensionTests.swift
//  SoftgamesTestTests
//
//  Created by Erdi on 7.05.2022.
//

import Foundation

import XCTest
@testable  import SoftgamesTest

class StringDateExtensionTests: XCTestCase {

    func testFormattedDate() {

        let wrongFormattedString1 = ""
        let wrongFormattedString2 = "02/05/2022"
        let correctFormattedString = "2022-05-04"

        XCTAssertNil(wrongFormattedString1.formattedDate(), "Formatted date should be nil")
        XCTAssertNil(wrongFormattedString2.formattedDate(), "Formatted date should be nil")
        XCTAssertNotNil(correctFormattedString.formattedDate(), "Formatted date should not be nil")

        let date = correctFormattedString.formattedDate()!

        let calendarDate = Calendar.current.dateComponents([.day, .year, .month], from: date)
        
        XCTAssertEqual(2022, calendarDate.year, "Year should be 2022")
        XCTAssertEqual(5, calendarDate.month, "Month should be 5")
        XCTAssertEqual(4, calendarDate.day, "Day should be 4")
    }
}
