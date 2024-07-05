//
//  Date + Extensions.swift
//  M-Bank
//
//  Created by Denis Haritonenko on 3.07.24.
//

import Foundation

extension Date {
    func toString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter.string(from: self)
    }
    
    func isGreaterThanOrEqualTo(_ date: Date) -> Bool {
            return self >= date
        }
    
    init?(day: Int, month: Int, year: Int) {
        let calendar = Calendar(identifier: .gregorian)
        var dateComponents = DateComponents()
        dateComponents.day = day
        dateComponents.month = month
        dateComponents.year = year
        
        if let date = calendar.date(from: dateComponents) {
            self = date
        } else {
            return nil
        }
    }
}
