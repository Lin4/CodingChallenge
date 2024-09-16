//
//  Double+Ext.swift
//  CodingChallenge
//
//  Created by Lingeswaran Kandasamy on 9/15/24.
//

import Foundation

extension Double {
    
    /// Converts a Double into string representation
    /// ```
    /// Convert 1.2345 to "1"
    /// ```
    func asStringRounded() -> String {
        return String(format: "%.0f", self)
    }
}
