//
//  WeatherSearchView.swift
//  CodingChallenge
//
//  Created by Lingeswaran Kandasamy on 9/13/24.
//

import SwiftUI

struct WeatherSearchView: View {
    @State private var searchText: String = ""
    @EnvironmentObject var coordinator: Coordinator
    
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    private var vm: WeatherSearchViewModel {
        coordinator.viewModel
    }
    
    var body: some View {
            ZStack {
                Color.theme.clearBackground.ignoresSafeArea()
                
                // Main ScrollView for the content
                ScrollView {
                    if vm.isLoading {
                        ProgressView("Loading locations...")
                    } else if searchText.isEmpty {
                        if horizontalSizeClass == .compact {
                            compactSavedLocationsView
                        } else {
                            regularSavedLocationsView
                        }
                    } else {
                        searchedLocationsView
                    }
                }
               // .navigationTitle("Search Places")
                .searchable(text: $searchText, prompt: "Search for a city")
                .onChange(of: searchText) { oldValue, newValue in
                    Task {
                        await vm.performSearch(text: newValue)
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        EmptyView() // Removes the back button by not adding anything here
                    }
                }
            }

        .task {
            await vm.fetchSavedLocationsWeather()
        }
    }
    
    // Compact layout (iPhone portrait or small screens)
    private var compactSavedLocationsView: some View {
        ScrollView(.vertical) {
            VStack(spacing: 5) {
                ForEach(vm.savedLocationsWeather, id: \.id) { weather in
                    Button(action: {
                        coordinator.goSavedWeatherDetail(vm, weather)
                    }) {
                        SavedLocationsRow(currentWeather: weather)
                    }
                }
            }
        }
        .padding(.horizontal)
    }
    
    // Regular layout (iPad or iPhone landscape) with a grid structure
    private var regularSavedLocationsView: some View {
        ScrollView(.vertical) {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))], spacing: 16) {
                ForEach(vm.savedLocationsWeather, id: \.id) { weather in
                    Button(action: {
                        coordinator.goSavedWeatherDetail(vm, weather)
                    }) {
                        SavedLocationsRow(currentWeather: weather)
                    }
                }
            }
            .padding(.horizontal)
        }
    }
    
    // View for searched locations
    private var searchedLocationsView: some View {
        ScrollView(.vertical) {
            VStack(spacing: 1) {
                ForEach(vm.searchedLocations) { location in
                    Button(action: {
                        coordinator.goSearchWeatherDetail(vm, location)
                    }) {
                        HStack {
                            Text(location.displayFullPlaceName)
                                .foregroundColor(.theme.accent)
                            Spacer()
                        }
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .overlay(Rectangle().stroke(Color.gray.opacity(0.2), lineWidth: 1))
                    }
                }
            }
        }
        .padding(.horizontal)
    }
}
