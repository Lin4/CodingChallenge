//
//  LocationsRowView.swift
//  CodingChallenge
//
//  Created by Lingeswaran Kandasamy on 9/15/24.
//

import SwiftUI

struct SavedLocationDetail: View {
    @ObservedObject var vm: WeatherSearchViewModel
    var location: CurrentWeather
    
    var body: some View {
        WeatherDetailView(vm: vm, item: .currentWeather(location))
    }
}
