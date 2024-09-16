//
//  CodingChallengeTests.swift
//  CodingChallengeTests
//
//  Created by Lingeswaran Kandasamy on 9/13/24.
//

import XCTest
import CoreData
@testable import CodingChallenge

final class CoreDataManagerTests: XCTestCase {
    var coreDataManager: CoreDataManager!

    override func setUpWithError() throws {
        coreDataManager = CoreDataManager.shared
    }

    func testFetchLocations() throws {
        coreDataManager.fetchLocations()
        XCTAssertTrue(coreDataManager.locationsEntities.count >= 0, "Locations should be fetched.")
    }

    func testAddLocation() throws {
        let location = Location(id: "1", weatherID: 800, cityName: "Test City", lat: 37.7749, lon: -122.4194)
        coreDataManager.addLocation(location: location)

        XCTAssertTrue(coreDataManager.locationsEntities.contains { $0.cityName == "Test City" }, "Location should be added.")
    }

    func testRemoveLocation() throws {
        let location = Location(id: "1", weatherID: 800, cityName: "Test City", lat: 37.7749, lon: -122.4194)
        coreDataManager.removeLocation(location: location)

        XCTAssertFalse(coreDataManager.locationsEntities.contains { $0.cityName == "Test City" }, "Location should be removed.")
    }
}

