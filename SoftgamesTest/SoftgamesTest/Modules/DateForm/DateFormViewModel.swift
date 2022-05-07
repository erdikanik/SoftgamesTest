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
}

final class DateFormViewModel: DateFormViewModelInterface {

    func concatenateNames(firstName: String, lastName: String) -> String {
        let trimmedName = firstName.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedLastName = lastName.trimmingCharacters(in: .whitespacesAndNewlines)

        let separateString = !trimmedName.isEmpty && !trimmedLastName.isEmpty ? " " : ""

        return trimmedName + separateString + trimmedLastName
    }
}
