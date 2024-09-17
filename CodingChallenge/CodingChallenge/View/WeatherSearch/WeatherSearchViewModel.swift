//
//  LocationsViewModel.swift
//  CodingChallenge
//
//  Created by Lingeswaran Kandasamy on 9/15/24.
//

import Foundation
import Combine

@MainActor
class WeatherSearchViewModel: ObservableObject {
    @Published var currentWeather: CurrentWeather? = nil
    @Published var forecastWeather: HourlyForecast? = nil
    @Published var isLoading = false
    @Published var savedLocations: [Location] = []
    @Published var savedLocationsWeather: [CurrentWeather] = []
    @Published var searchedLocations: [SearchLocation] = []
    @Published var errorMessage: String? = nil // For user-friendly error messages
    
    private let weatherDataService: WeatherServiceProtocol
    private let coreDataManager: CoreDataManager
    private var cancellables = Set<AnyCancellable>()
    
    init(weatherService: WeatherServiceProtocol, coreDataManager: CoreDataManager) {
        self.weatherDataService = weatherService
        self.coreDataManager = coreDataManager
        addSubscribers()
    }
    
    // MARK: - Subscribers
    func addSubscribers() {
        // Monitor saved locations in CoreData and update savedLocations property
        coreDataManager.$locationsEntities
            .map { locationsEntities -> [Location] in
                let locations: [Location] = locationsEntities.map { entity in
                    Location(
                        id: entity.id ?? "",
                        weatherID: Int(entity.weatherID),
                        cityName: entity.cityName ?? "",
                        lat: entity.lat,
                        lon: entity.lon
                    )
                }
                return locations.sorted { $0.cityName < $1.cityName }
            }
            .sink { [weak self] locations in
                self?.savedLocations = locations
            }
            .store(in: &cancellables)
        
        // When savedLocations change, fetch weather data for saved locations
        $savedLocations
            .sink { [weak self] _ in
                Task {
                    await self?.fetchSavedLocationsWeather()
                }
            }
            .store(in: &cancellables)
    }
    
    // MARK: - Search Functionality
    func performSearch(text: String) async {
        guard !text.isEmpty, text.count > 3 else { return }
        
        let searchText = text.replacingOccurrences(of: " ", with: "-")
            .lowercased()
            .folding(options: .diacriticInsensitive, locale: Locale.current)
        
        let location = Location(cityName: searchText)
        
        do {
            searchedLocations = try await weatherDataService.fetchSearchLocations(location: location)
        } catch {
            errorMessage = "Failed to fetch search locations: \(error.localizedDescription)"
        }
    }
    
    // MARK: - Fetch Weather Data
    func fetchData(for location: Location) async {
        isLoading = true
        
        do {
            let currentWeatherTask = try await weatherDataService.fetchCurrentWeather(location: location)
            let forecastWeatherTask = try await weatherDataService.fetchHourlyForecast(location: location)
            
            // Wait for both tasks to complete simultaneously
            let (currentWeather, forecastWeather) =  (currentWeatherTask, forecastWeatherTask)
            
            self.currentWeather = currentWeather
            self.forecastWeather = forecastWeather
        } catch {
            errorMessage = "Failed to fetch weather data: \(error.localizedDescription)"
        }
        
        isLoading = false
    }
    
    func fetchSavedLocationsWeather() async {
        do {
            savedLocationsWeather = try await weatherDataService.fetchLocationsWeather(locations: savedLocations)
        } catch {
            errorMessage = "Failed to fetch saved locations weather: \(error.localizedDescription)"
        }
    }
    
    // MARK: - Manage Saved Locations
    private func addLocation(_ location: Location) {
        coreDataManager.addLocation(location: location)
    }
    
    private func removeLocation(_ location: Location) {
        coreDataManager.removeLocation(location: location)
    }
    
    func addOrRemoveLocation(_ location: Location, isFav: Bool) {
        if isFav {
            addLocation(location)
        } else {
            removeLocation(location)
        }
    }
}
