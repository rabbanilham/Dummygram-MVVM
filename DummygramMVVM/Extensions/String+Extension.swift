//
//  String+Extension.swift
//  DummygramMVVM
//
//  Created by Bagas Ilham on 05/08/22.
//

import Foundation

extension String {
    
    func isValidPassword(_ text: String) -> Bool {
        if text.count >= 8 {
            return true
        } else {
            return false
        }
    }
    
    var isValidEmail: Bool {
        let regularExpressionForEmail = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let testEmail = NSPredicate(format:"SELF MATCHES %@", regularExpressionForEmail)
        return testEmail.evaluate(with: self)
    }
    
    func convertToDateInterval() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let date = dateFormatter.date(from: String(self.prefix(19)))!
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
        let finalDate = calendar.date(from: components)!
        let intervalFormatter = DateComponentsFormatter()
        intervalFormatter.maximumUnitCount = 1
        intervalFormatter.unitsStyle = .full
        intervalFormatter.zeroFormattingBehavior = .dropAll
        intervalFormatter.allowedUnits = [.day, .hour, .minute, .second]
        guard let finalString = intervalFormatter.string(from: finalDate, to: Date()) else { return self }
        return finalString
    }
    
    func convertToDate(format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let date = dateFormatter.date(from: String(self.prefix(19)))!
        let finalDateFormatter = DateFormatter()
        finalDateFormatter.dateFormat = format
        let finalString = finalDateFormatter.string(from: date)
        return finalString
    }
    
}
