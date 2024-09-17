//
//  CoordinatorView.swift
//  CodingChallenge
//
//  Created by Lingeswaran Kandasamy on 9/16/24.
//

import SwiftUI

struct CoordinatorView: View {
    @EnvironmentObject var coordinator: Coordinator
    
    var body: some View {
        NavigationStack(path: $coordinator.path) {
            WeatherSearchView()
                .navigationDestination(for: Coordinator.Screens.self) { screen in
                    screenView(for: screen)
                }
        }
    }
    
    @ViewBuilder
    private func screenView(for screen: Coordinator.Screens) -> some View {
        switch screen {
        case .searchView:
            WeatherSearchView()
        case .savedWeather:
            if let weather = coordinator.cWeather {
                SavedLocationDetail(location: weather)
            } else {
                Text("No saved weather data available.")
            }
        case .searchWeather:
            if coordinator.searchedLocation != nil {
                LocationWeatherView()
            } else {
                Text("No search location available.")
            }
        }
    }
}
