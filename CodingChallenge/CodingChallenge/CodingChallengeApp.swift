//
//  CodingChallengeApp.swift
//  CodingChallenge
//
//  Created by Lingeswaran Kandasamy on 9/13/24.
//

import SwiftUI

@main
struct CodingChallengeApp: App {
    
    private let locationDataManager = LocationManager()
    private let weatherDataService = WeatherService(apiKey: apiKey)
    private let coreDataManager = CoreDataManager.shared
    
    var body: some Scene {
        WindowGroup {
            let coordinator = MainCoordinator(
                locationDataManager: locationDataManager,
                weatherDataService: weatherDataService,
                coreDataManager: coreDataManager
            )
            coordinator.start()
        }
    }
}


