//
//  CoreDataManager.swift
//  CodingChallenge
//
//  Created by Lingeswaran Kandasamy on 9/15/24.
//

import Foundation
import CoreData

class CoreDataManager: ObservableObject {
    @Published var locationsEntities: [LocationEntity] = []
    
    let container = NSPersistentContainer(name: "Locations")
    
    static let shared = CoreDataManager()
    
    private init() {
        container.loadPersistentStores { [weak self] description, error in
            if let error = error {
                self?.logError("Error loading Core Data: \(error.localizedDescription)")
            }
        }
        fetchLocations()
    }
    
    func fetchLocations() {
        let request = NSFetchRequest<LocationEntity>(entityName: "LocationEntity")
        do {
            locationsEntities = try container.viewContext.fetch(request)
        } catch {
            logError("Error fetching locations: \(error.localizedDescription)")
        }
    }
    
    func addLocation(location: Location) {
        let newLocation = LocationEntity(context: container.viewContext)
        newLocation.id = location.id
        newLocation.weatherID = Int64(location.weatherID)
        newLocation.cityName = location.cityName
        newLocation.lat = location.lat
        newLocation.lon = location.lon
        saveData()
    }
    
    func removeLocation(location: Location) {
        guard let entity = locationsEntities.first(where: { $0.weatherID == location.weatherID }) else { return }
        container.viewContext.delete(entity)
        saveData()
    }
    
    func saveData() {
        if container.viewContext.hasChanges {
            do {
                try container.viewContext.save()
                fetchLocations()
            } catch {
                logError("Error saving Core Data: \(error.localizedDescription)")
            }
        }
    }
    
    private func logError(_ message: String) {
        // Improved error handling for user feedback
        print("\(message)")
    }
}
