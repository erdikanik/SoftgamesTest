//
//  DateFormTests.swift
//  SoftgamesTestTests
//
//  Created by Erdi on 7.05.2022.
//

import XCTest
@testable  import SoftgamesTest

class DateFormTests: XCTestCase {

    var dateFormViewModel: DateFormViewModelInterface!

    override func setUp() {
        dateFormViewModel = DateFormViewModel()
    }

    func testConcatenateNames() {
        let nameCase1 = ""
        let nameCase2 = "Jane"
        let nameCase3 = " Jane   "
        let lastNameCase1 = ""
        let lastNameCase2 = "Doe"
        let lastNameCase3 = " Doe "

        let result1 = dateFormViewModel.concatenateNames(firstName: nameCase1, lastName: lastNameCase1)
        let result2 = dateFormViewModel.concatenateNames(firstName: nameCase1, lastName: lastNameCase2)
        let result3 = dateFormViewModel.concatenateNames(firstName: nameCase2, lastName: lastNameCase1)
        let result4 = dateFormViewModel.concatenateNames(firstName: nameCase2, lastName: lastNameCase2)
        let result5 = dateFormViewModel.concatenateNames(firstName: nameCase3, lastName: lastNameCase3)
        let result6 = dateFormViewModel.concatenateNames(firstName: nameCase3, lastName: lastNameCase1)


        XCTAssertEqual(result1, "", "Result should be empty string")
        XCTAssertEqual(result2, "Doe", "Result should be just lastname")
        XCTAssertEqual(result3, "Jane", "Result should be just name")
        XCTAssertEqual(result4, "Jane Doe", "Result should be name and lastname")
        XCTAssertEqual(result5, "Jane Doe", "Result should be name and lastname")
        XCTAssertEqual(result6, "Jane", "Result should be just name")
    }

    func testCalculateAgeOfCustomer() {

        let birthDay1 = "2022-01-04" // 0 years
        let birthDay2 = "1970-05-03" // 51 years

        let today = "2022-05-04"
        let todayDate = today.formattedDate()!

        let expectation = XCTestExpectation(description: "Wait for birthday1")
        dateFormViewModel.calculateAgeOfCustomer(
            dateString: birthDay1,
            today: todayDate) { age in
                expectation.fulfill()
                XCTAssertEqual(today, "0", "Customer age should be 0")
        }

        wait(for: [expectation], timeout: 5.1)

        let expectation2 = XCTestExpectation(description: "Wait for birthday2")
        dateFormViewModel.calculateAgeOfCustomer(
            dateString: birthDay2,
            today: todayDate) { age in
                expectation2.fulfill()
                XCTAssertEqual(today, "51", "Customer age should be 51")
        }

        wait(for: [expectation2], timeout: 5.1)
    }
}
