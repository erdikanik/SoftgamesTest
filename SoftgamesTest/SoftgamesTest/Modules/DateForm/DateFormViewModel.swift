//
//  DateFormViewModel.swift
//  SoftgamesTest
//
//  Created by Erdi on 7.05.2022.
//

import Foundation
import UserNotifications

protocol DateFormViewModelInterface {

    // Concatenate name and lastname
    func concatenateNames(firstName: String, lastName: String) -> String

    // Calculates customer age and returns age of customer inside of the completion block
    func calculateAgeOfCustomer(dateString: String, today: Date, completion: @escaping (String) -> Void)

    // Sends local notification after 7 seconds
    func scheduleNotification()

    func requestNotificationPermission()
}

final class DateFormViewModel: DateFormViewModelInterface {

    private enum Constant {

        static let calculatingCustomerAgeSeconds = 5.0
        static let notificationTitle = "Solitaire smash"
        static let notificationBody = "Play again to smash your top score"
        static let localNotificationIdentifier = "local_notification"
        static let localNotificationTimeInterval = 7.0
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

    func requestNotificationPermission() {
        let notificationCenter = UNUserNotificationCenter.current()

        notificationCenter.requestAuthorization(
            options: [.alert, .sound, .badge]) { success, error in
                if error != nil {
                    print("Notification permission denied")
                }
        }
    }

    func scheduleNotification() {

        let content = UNMutableNotificationContent()
        content.title = Constant.notificationTitle
        content.body = Constant.notificationBody
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: Constant.localNotificationTimeInterval, repeats: false)
        let request = UNNotificationRequest(
            identifier: Constant.localNotificationIdentifier,
            content: content, trigger: trigger
        )
        UNUserNotificationCenter.current().add(request)
    }
}
