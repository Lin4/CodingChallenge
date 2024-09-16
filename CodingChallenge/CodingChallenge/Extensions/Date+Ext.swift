//
//  Date+Ext.swift
//  CodingChallenge
//
//  Created by Lingeswaran Kandasamy on 9/15/24.
//

import Foundation

extension Date {
    
    /// Converts a Date into string representation
    /// ```
    /// Convert Date to "5 AM"
    /// Convert Date to "5 PM"
    /// ```
    func asTimeAbrev() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h a"
        return dateFormatter.string(from: self)
    }
    
    /// Converts a Date into string representation
    /// ```
    /// Convert Date to "Tue"
    /// Convert Date to "Wed"
    /// ```
    func asDaysOfWeek() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en") // remove
        dateFormatter.dateFormat = "ccc"
        return dateFormatter.string(from: self)
    }
}
