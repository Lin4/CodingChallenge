//
//  LocationsRowView.swift
//  CodingChallenge
//
//  Created by Lingeswaran Kandasamy on 9/15/24.
//

import SwiftUI

struct LocationWeatherView: View {
    @StateObject var vm: WeatherSearchViewModel
    var location: SearchLocation
    
    var body: some View {
        WeatherDetailView(vm: vm, item: .searchLocation(location))
    }
}
enum WeatherItem {
    case searchLocation(SearchLocation)
    case currentWeather(CurrentWeather)
}

