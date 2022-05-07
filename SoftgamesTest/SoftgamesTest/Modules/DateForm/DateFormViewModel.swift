//
//  DateFormViewModel.swift
//  SoftgamesTest
//
//  Created by Erdi on 7.05.2022.
//

import Foundation

protocol DateFormViewModelInterface {

    // Concatenate name and lastname
    func concatenateNames(firstName: String, lastName: String) -> String

    // Calculates customer age and returns age of customer inside of the completion block
    func calculateAgeOfCustomer(dateString: String, today: Date, completion: @escaping (String) -> Void)
}

final class DateFormViewModel: DateFormViewModelInterface {

    private enum Constant {

        static let calculatingCustomerAgeSeconds = 5.0
    }

    func concatenateNames(firstName: String, lastName: String) -> String {
        let trimmedName = firstName.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedLastName = lastName.trimmingCharacters(in: .whitespacesAndNewlines)

        let separateString = !trimmedName.isEmpty && !trimmedLastName.isEmpty ? " " : ""

        return trimmedName + separateString + trimmedLastName
    }

    func calculateAgeOfCustomer(dateString: String, today: Date, completion: @escaping (String) -> Void) {

        guard let formattedDate = dateString.formattedDate() else {
            DispatchQueue.main.asyncAfter(deadline: .now() + Constant.calculatingCustomerAgeSeconds) {
                completion("")
            }
            return
        }

        let calendarDate = Calendar.current.dateComponents([.year], from: formattedDate, to: today)

        guard let year = calendarDate.year else {
            DispatchQueue.main.asyncAfter(deadline: .now() + Constant.calculatingCustomerAgeSeconds) {
                completion("")
            }
            return
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + Constant.calculatingCustomerAgeSeconds) {
            completion(String(year))
        }
    }
}
