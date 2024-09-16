//
//  MainCoordinator.swift
//  CodingChallenge
//
//  Created by Lingeswaran Kandasamy on 9/15/24.
//

import SwiftUI

class MainCoordinator {
    private let locationDataManager: LocationManager
    private let weatherDataService: WeatherService
    private let coreDataManager: CoreDataManager
    
    init(locationDataManager: LocationManager, weatherDataService: WeatherService, coreDataManager: CoreDataManager) {
        self.locationDataManager = locationDataManager
        self.weatherDataService = weatherDataService
        self.coreDataManager = coreDataManager
    }
    
    @MainActor func start() -> some View {
        let locationsViewModel = WeatherSearchViewModel(weatherService: weatherDataService, coreDataManager: coreDataManager)
        return NavigationStack{
            WeatherSearchView(vm: locationsViewModel)
        }
    }
}
