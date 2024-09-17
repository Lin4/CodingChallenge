//
//  Coordinator.swift
//  CodingChallenge
//
//  Created by Lingeswaran Kandasamy on 9/15/24.
//

import SwiftUI

final class Coordinator: ObservableObject {
    @Published var path = NavigationPath()
    @Published var screen: Screens = .searchView
    @Published var searchedLocation: SearchLocation?
    @Published var cWeather: CurrentWeather?

    private var locationDataManager: LocationManager
    private var weatherDataService: WeatherService
    private var coreDataManager: CoreDataManager

    var viewModel: WeatherSearchViewModel

    // Initializes the Coordinator with dependencies
    init(locationDataManager: LocationManager, weatherDataService: WeatherService, coreDataManager: CoreDataManager, viewModel: WeatherSearchViewModel, location: SearchLocation, currentWeather: CurrentWeather) {
        self.locationDataManager = locationDataManager
        self.weatherDataService = weatherDataService
        self.coreDataManager = coreDataManager
        self.viewModel = viewModel
        self.searchedLocation = location
        self.cWeather = currentWeather
    }

    // Clears the navigation path and goes to the Search screen
    func goSearch(_ vm: WeatherSearchViewModel) {
        viewModel = vm
        path.removeLast(path.count)
        screen = .searchView
    }

    // Appends Search Weather screen to the navigation stack
    func goSearchWeatherDetail(_ vm: WeatherSearchViewModel, _ location: SearchLocation) {
        viewModel = vm
        searchedLocation = location
        screen = .searchWeather
        path.append(Screens.searchWeather)
    }

    // Appends the Saved Weather screen to the stack with the selected weather
    func goSavedWeatherDetail(_ vm: WeatherSearchViewModel, _ weather: CurrentWeather) {
        viewModel = vm
        cWeather = weather
        screen = .savedWeather
        path.append(Screens.savedWeather)
    }

    // Enum for different screens with Identifiable conformance
    enum Screens: String, CaseIterable, Identifiable {
        case searchView, savedWeather, searchWeather

        var id: String { self.rawValue }
    }
}



