//
//  CurrentWeather.swift
//  CodingChallenge
//
//  Created by Lingeswaran Kandasamy on 9/15/24.
//

import Foundation

struct CurrentWeather: Codable, Identifiable {
    let id: Int
    let cod: Int
    let name: String
    let coord: Coord
    let main: Main
    let weather: [Weather]
    static let mock = CurrentWeather(id: 3452925, cod: 200, name: "Test City",
                                     coord: Coord(lon: -51.23, lat: -30.0331),
                                     main: Main(temp: 23.74, feelsLike: 23.39, tempMin: 23.82, tempMax: 22.77, pressure: 1011, humidity: 89, seaLevel: 0, grndLevel: 0),
                                     weather: [Weather(id: 665, main: "Clouds", description: "Cloudy weather", icon: .brokenClouds)])
    
    
}

struct Coord: Codable {
    let lon, lat: Double
}

struct Weather: Codable {
    let id: Int?
    let main: String?
    let description: String?
    let icon: weatherIcon?
}

struct Main: Codable {
    let temp: Double?
    let feelsLike: Double?
    let tempMin: Double?
    let tempMax: Double?
    let pressure: Int?
    let humidity: Int?
    let seaLevel: Int?
    let grndLevel: Int?
}

