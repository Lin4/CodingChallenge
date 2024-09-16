//
//  SearchLocation.swift
//  CodingChallenge
//
//  Created by Lingeswaran Kandasamy on 9/15/24.
//

import Foundation

struct SearchLocation: Codable, Identifiable {
    // Remove default value for id
    let id: UUID
    let name: String
    let lat: Double
    let lon: Double
    let country: String
    let state: String?
    
    // Provide a custom initializer to set id and other properties
    init(name: String, lat: Double, lon: Double, country: String, state: String? = nil, id: UUID = UUID()) {
        self.id = id
        self.name = name
        self.lat = lat
        self.lon = lon
        self.country = country
        self.state = state
    }
    
    // Example instance
    static let mock = SearchLocation(name: "Test City", lat: -30.100916650000002, lon: -51.18878818689657, country: "US", state: "New Jersey")
    
    // Computed property to format display name
    var displayFullPlaceName: String {
        if let state = state {
            return "\(name), \(state), \(country)"
        } else {
            return "\(name), \(country)"
        }
    }
    
    // CodingKeys to exclude id from encoding/decoding
    enum CodingKeys: String, CodingKey {
        case name
        case lat
        case lon
        case country
        case state
    }
    
    // Custom initializer for decoding
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        lat = try container.decode(Double.self, forKey: .lat)
        lon = try container.decode(Double.self, forKey: .lon)
        country = try container.decode(String.self, forKey: .country)
        state = try container.decodeIfPresent(String.self, forKey: .state)
        id = UUID() // Initialize id locally
    }
    
    // Custom encoding to exclude id
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(lat, forKey: .lat)
        try container.encode(lon, forKey: .lon)
        try container.encode(country, forKey: .country)
        try container.encodeIfPresent(state, forKey: .state)
    }
}
