//
//  LocationsRowView.swift
//  CodingChallenge
//
//  Created by Lingeswaran Kandasamy on 9/15/24.
//

import SwiftUI

struct LocationWeatherView: View {
    @EnvironmentObject var coordinator: Coordinator
   
    var body: some View {
        guard let searchLocation = coordinator.searchedLocation else {
            return AnyView(Text("No location data available"))
        }
        return AnyView(
            WeatherDetailView(vm: coordinator.viewModel, item: .searchLocation(searchLocation))
        )
    }
}
