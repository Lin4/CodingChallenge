//
//  CodingChallengeApp.swift
//  CodingChallenge
//
//  Created by Lingeswaran Kandasamy on 9/13/24.
//

import SwiftUI

@main
struct CodingChallengeApp: App {
    @StateObject private var coordinator: Coordinator

    init() {
        // Initialize your dependencies here
        let locationDataManager = LocationManager()
        let weatherDataService = WeatherService(apiKey: apiKey)
        let coreDataManager = CoreDataManager.shared
        let viewModel = WeatherSearchViewModel(weatherService: weatherDataService, coreDataManager: coreDataManager)
        
        // Use mock instances for initial values
        let location = SearchLocation.mock
        let currentWeather = CurrentWeather.mock
        
        _coordinator = StateObject(wrappedValue: Coordinator(
            locationDataManager: locationDataManager,
            weatherDataService: weatherDataService,
            coreDataManager: coreDataManager,
            viewModel: viewModel,
            location: location,
            currentWeather: currentWeather
        ))
    }

    var body: some Scene {
        WindowGroup {
            CoordinatorView()
                .environmentObject(coordinator)
        }
    }
}

