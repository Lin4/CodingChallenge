//
//  LocationManager.swift
//  CodingChallenge
//
//  Created by Lingeswaran Kandasamy on 9/13/24.
//

import Foundation
import CoreLocation


protocol LocationServiceProtocol {
    func requestPermission()
    func requestLocation()
}

@Observable
class LocationManager: NSObject, ObservableObject, LocationServiceProtocol {
    var authorizationStatus: CLAuthorizationStatus
    var location: Location? = nil
    var isLoading: Bool = true
    var errorMessage: String? = nil
    
    private let locationManager: CLLocationManager
    
    override init() {
        locationManager = CLLocationManager()
        authorizationStatus = locationManager.authorizationStatus
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyReduced
    }
    
    func requestLocation() {
        isLoading = true
        locationManager.requestLocation()
    }
    
    func requestPermission() {
        isLoading = true
        locationManager.requestWhenInUseAuthorization()
    }
}

extension LocationManager: CLLocationManagerDelegate {
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        authorizationStatus = manager.authorizationStatus
        handleAuthorization(manager)
    }
    
    private func handleAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            manager.requestLocation()
        case .restricted:
            errorMessage = "Location is restricted, likely due to parental controls."
        case .denied:
            errorMessage = "Location permission denied. Please enable it in settings."
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
        @unknown default:
            errorMessage = "Unexpected authorization status."
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let newLocation = locations.first?.coordinate else {
            errorMessage = "Failed to get location data."
            return
        }
        location = Location(lat: newLocation.latitude, lon: newLocation.longitude)
        isLoading = false
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        errorMessage = "Error fetching location: \(error.localizedDescription)"
        isLoading = false
    }
}
