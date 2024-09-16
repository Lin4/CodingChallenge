//
//  Location.swift
//  CodingChallenge
//
//  Created by Lingeswaran Kandasamy on 9/15/24.
//

import Foundation

struct Location: Identifiable {
    var id = UUID().uuidString
    var weatherID: Int = 0
    var cityName: String = ""
    var lat: Double = 0.0
    var lon: Double = 0.0
}
