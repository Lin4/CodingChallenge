//
//  WeatherDetailView.swift
//  CodingChallenge
//
//  Created by Lingeswaran Kandasamy on 9/13/24.
//

import SwiftUI

struct WeatherDetailView: View {
    @ObservedObject var vm: WeatherSearchViewModel
    var item: WeatherItem
    
    @State private var isFav: Bool = false
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    var body: some View {
        ZStack {
            backgroundView
            contentView
        }
        .toolbar {
            toolbarView
        }
        .onAppear {
            updateFavoriteStatus()
        }
        .task {
            await fetchData()
        }
    }
    
    private var backgroundView: some View {
        LinearGradient(gradient: Gradient(stops: [
            .init(color: .theme.blueBackground, location: 0.30),
            .init(color: .blue.opacity(0.4), location: 0.80)
        ]), startPoint: .bottomLeading, endPoint: .top)
        .ignoresSafeArea()
    }
    
    private var contentView: some View {
        VStack {
            if vm.isLoading {
                Spacer()
                ProgressView()
                Spacer()
            } else {
                if horizontalSizeClass == .compact {
                    compactWeatherInfoView
                } else {
                    regularWeatherInfoView
                }
            }
            Spacer()
        }
    }
    
    private var compactWeatherInfoView: some View {
        VStack {
            ScrollView(showsIndicators: false){
                if let model = vm.currentWeather {
                    WeatherInfo(currentWeather: model)
                }
                if let model = vm.forecastWeather {
                    HourlyForecastRow(items: model)
                }
            }
        }
    }
    
    private var regularWeatherInfoView: some View {
        HStack {
            if let model = vm.currentWeather {
                WeatherInfo(currentWeather: model)
            }
            if let model = vm.forecastWeather {
                HourlyForecastRow(items: model)
            }
        }
    }
    private var toolbarView: some View {
        Button {
            handleFavoriteAction()
        } label: {
            Label("Add to Weather Watch", systemImage: isFav ? "bookmark.circle.fill" : "bookmark.circle")
                .labelStyle(.iconOnly)
                .font(.system(size: 45))
                .foregroundColor(isFav ? .red : .theme.accent)
                .padding(.horizontal, 20)
                .padding(.top, 20)
        }
    }
    
    private func handleFavoriteAction() {
        switch item {
        case .searchLocation(let location):
            isFav.toggle()
            let newLocation = Location(
                weatherID: vm.currentWeather?.id ?? 0,
                cityName: vm.currentWeather?.name ?? location.name,
                lat: vm.currentWeather?.coord.lat ?? location.lat,
                lon: vm.currentWeather?.coord.lon ?? location.lon
            )
            vm.addOrRemoveLocation(newLocation, isFav: isFav)
        case .currentWeather(let weather):
            isFav.toggle()
            let newLocation = Location(
                weatherID: weather.id,
                cityName: weather.name,
                lat: weather.coord.lat,
                lon: weather.coord.lon
            )
            vm.addOrRemoveLocation(newLocation, isFav: isFav)
        }
    }
    
    private func updateFavoriteStatus() {
        switch item {
        case .searchLocation(let location):
            isFav = vm.savedLocations.contains(where: { $0.cityName == location.name })
        case .currentWeather(let weather):
            isFav = vm.savedLocations.contains(where: { $0.weatherID == weather.id })
        }
    }
    
    private func fetchData() async {
        switch item {
        case .searchLocation(let location):
            await vm.fetchData(for: Location(lat: location.lat, lon: location.lon))
        case .currentWeather(let weather):
            await vm.fetchData(for: Location(
                weatherID: weather.id,
                lat: weather.coord.lat,
                lon: weather.coord.lon
            ))
        }
    }
}


