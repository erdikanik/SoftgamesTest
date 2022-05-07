//
//  String+DateExtension.swift
//  SoftgamesTest
//
//  Created by Erdi on 7.05.2022.
//

import Foundation

extension String {

    func formattedDate() -> Date? {

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        return dateFormatter.date(from: self)
    }
}
