//
//  LocationsRowView.swift
//  CodingChallenge
//
//  Created by Lingeswaran Kandasamy on 9/15/24.
//

import SwiftUI

struct SavedLocationDetail: View {
    @EnvironmentObject var coordinator: Coordinator
    var location: CurrentWeather
    
    var body: some View {
        guard let currentWeather = coordinator.cWeather else {
            return AnyView(Text("No weather data available"))
        }
        return AnyView(
            WeatherDetailView(vm: coordinator.viewModel, item: .currentWeather(currentWeather))
        )
    }
}




enum WeatherItem {
    case searchLocation(SearchLocation)
    case currentWeather(CurrentWeather)
}
