//
//  HourlyForecast.swift
//  CodingChallenge
//
//  Created by Lingeswaran Kandasamy on 9/15/24.
//

import Foundation

struct HourlyForecast: Codable {
    let list: [HourlyWeather]
    
    static let mock = HourlyForecast(list: [
        HourlyWeather(
            main: Main(temp: 23.54, feelsLike: 22.19, tempMin: 21.72, tempMax: 20.54, pressure: 1018, humidity: 47, seaLevel: 1120, grndLevel: 819),
            weather: [Weather(id: 638, main: "Clouds", description: "scattered clouds", icon: .clearSky)],
            dtTxt: Date()
        )
    ])
}

struct HourlyWeather: Codable, Identifiable {
    private(set) var id = UUID()
    let main: Main
    let weather: [Weather]
    let dtTxt: Date?
    
    enum CodingKeys: String, CodingKey {
        case main, weather, dtTxt
    }
    
    static let example = HourlyWeather(
        main: Main(temp: 23.54, feelsLike: 22.19, tempMin: 21.72, tempMax: 20.54, pressure: 1018, humidity: 47, seaLevel: 1120, grndLevel: 819),
        weather: [Weather(id: 638, main: "Clouds", description: "scattered clouds", icon: .clearSky)],
        dtTxt: Date()
    )
}


struct City: Codable {
    let id: Int?
    let name: String?
    let coord: Coord?
    let country: String?
    let population: Int?
    let timezone: Int?
    let sunrise: Int?
    let sunset: Int?
}
