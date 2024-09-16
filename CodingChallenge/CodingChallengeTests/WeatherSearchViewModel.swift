//
//  WeatherSearchViewModel.swift
//  CodingChallengeUITests
//
//  Created by Lingeswaran Kandasamy on 9/15/24.
//

import XCTest
@testable import CodingChallenge

class MockWeatherService: WeatherServiceProtocol {
    func fetchLocationsWeather(locations: [Location]) async throws -> [CurrentWeather] {
        return locations.map { _ in CurrentWeather.mock }
    }

    func fetchCurrentWeather(location: Location) async throws -> CurrentWeather {
        return CurrentWeather.mock
    }

    func fetchHourlyForecast(location: Location) async throws -> HourlyForecast {
        return HourlyForecast.mock
    }

    func fetchSearchLocations(location: Location) async throws -> [SearchLocation] {
        return [SearchLocation.mock]
    }
}

final class WeatherServiceTests: XCTestCase {
    var weatherService: WeatherServiceProtocol!

    override func setUpWithError() throws {
        weatherService = MockWeatherService()
    }

    func testFetchCurrentWeather() async throws {
        let location = Location(id: "1", weatherID: 800, cityName: "Test City", lat: 37.7749, lon: -122.4194)
        let weather = try await weatherService.fetchCurrentWeather(location: location)

        XCTAssertEqual(weather.name, "Test City")
    }

    func testFetchHourlyForecast() async throws {
        let location = Location(id: "1", weatherID: 800, cityName: "Test City", lat: 37.7749, lon: -122.4194)
        let forecast = try await weatherService.fetchHourlyForecast(location: location)

        XCTAssertEqual(forecast.list.count, 1)
    }
}
