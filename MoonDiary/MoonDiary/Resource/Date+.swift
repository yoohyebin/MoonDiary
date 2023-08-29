//
//  Date+.swift
//  MoonDiary
//
//  Created by hyebin on 2023/08/17.
//

import Foundation

extension Date {
    func date() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy MM dd"
        return formatter.string(from: self)
    }
    
    func dateToString() -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US")
        formatter.dateFormat = "MMMM d eeee"
        return formatter.string(from: self)
    }
    
    func dateToMonthYear() -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US")
        formatter.dateFormat = "MMMM yyyy"
        return formatter.string(from: self)
    }
    
    func dateToMonthDay() -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US")
        formatter.dateFormat = "MMMM d"
        return formatter.string(from: self)
    }
    
    func dateToDate() -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US")
        formatter.dateFormat = "eeee"
        return formatter.string(from: self)
    }
    
    func dateToYearMonth() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy MM"
        return formatter.string(from: self)
    }
    
    func dateToDay() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d"
        return formatter.string(from: self)
    }
    
    func dateToMonth() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM"
        return formatter.string(from: self)
    }
}
