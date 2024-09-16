//
//  Color+Ext.swift
//  CodingChallenge
//
//  Created by Lingeswaran Kandasamy on 9/15/24.
//

import SwiftUI

extension Color {
    static let theme = ColorTheme()
}

class ColorTheme {
    let accent = Color(.label)
    let secondaryText = Color(.secondaryLabel)
    let blueBackground = Color("BlueBackgroundColor")
    let hourlyBackground = Color("HourlyBackgroundColor")
    let clearBackground = Color("ClearBackgroundColor")
}
