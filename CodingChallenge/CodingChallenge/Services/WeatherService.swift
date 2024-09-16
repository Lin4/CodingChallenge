//
//  WeatherService.swift
//  CodingChallenge
//
//  Created by Lingeswaran Kandasamy on 9/13/24.
//

import Foundation

let apiKey = "64536a376b20b4bd42cf94c88328fa14"

/// Define WeatherDataService as a protocol to enable easier mocking/testing
protocol WeatherServiceProtocol {
    func fetchLocationsWeather(locations: [Location]) async throws -> [CurrentWeather]
    func fetchCurrentWeather(location: Location) async throws -> CurrentWeather
    func fetchHourlyForecast(location: Location) async throws -> HourlyForecast
    func fetchSearchLocations(location: Location) async throws -> [SearchLocation]
}


class WeatherService: WeatherServiceProtocol {
    private let baseUrl: String
    private let apiKey: String
    private let units: String
    private let language: String
    
    // Dependency Injection via Initializer
    init(baseUrl: String = "https://api.openweathermap.org",
         apiKey: String,
         units: String = "metric",
         language: String = "en") {
        self.baseUrl = baseUrl
        self.apiKey = apiKey
        self.units = units
        self.language = language
    }
    
    public func fetchLocationsWeather(locations: [Location]) async throws -> [CurrentWeather] {
        return try await withThrowingTaskGroup(of: CurrentWeather?.self) { group in
            var weathers: [CurrentWeather] = []
            weathers.reserveCapacity(locations.count)
            
            for location in locations {
                group.addTask {
                    try? await self.fetchCurrentWeather(location: location)
                }
            }
            
            for try await weather in group {
                if let weather {
                    weathers.append(weather)
                }
            }
            
            return weathers.sorted { $0.name < $1.name }
        }
    }
    
    public func fetchCurrentWeather(location: Location) async throws -> CurrentWeather {
        guard let url = URL(string: "\(baseUrl)/data/2.5/weather?lat=\(location.lat)&lon=\(location.lon)&appid=\(apiKey)&units=\(units)&lang=\(language)") else {
            throw URLError(.badURL)
        }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let (data, _) = try await URLSession.shared.data(from: url)
        return try decoder.decode(CurrentWeather.self, from: data)
    }
    
    public func fetchHourlyForecast(location: Location) async throws -> HourlyForecast {
        guard let url = URL(string: "\(baseUrl)/data/2.5/forecast?lat=\(location.lat)&lon=\(location.lon)&appid=\(apiKey)&units=\(units)&lang=\(language)") else {
            throw URLError(.badURL)
        }
        
        let decoder = JSONDecoder()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss" // 2023-02-22 03:00:00
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        
        let (data, _) = try await URLSession.shared.data(from: url)
        return try decoder.decode(HourlyForecast.self, from: data)
    }
    
    public func fetchSearchLocations(location: Location) async throws -> [SearchLocation] {
        guard let url = URL(string: "\(baseUrl)/geo/1.0/direct?q=\(location.cityName)&limit=5&appid=\(apiKey)") else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode([SearchLocation].self, from: data)
    }
}
