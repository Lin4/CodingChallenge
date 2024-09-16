//
//  LocationsRowView.swift
//  CodingChallenge
//
//  Created by Lingeswaran Kandasamy on 9/15/24.
//

import SwiftUI

struct LocationsRowView: View {
    var item: CurrentWeather
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                Text(item.name)
                    .font(.title3)
                    .fontWeight(.medium)
                Spacer()
                Text(item.weather.first?.description?.capitalized ?? "")
                    .foregroundColor(.gray)
            }
            Spacer()
            VStack(alignment: .trailing, spacing: 8) {
                Text((item.main.temp?.asStringRounded() ?? "-") + "°")
                    .kerning(1.3)
                    .font(.system(size: 30, weight: .bold))
                Spacer()
                Text("Lat: \(item.coord.lat), Lon: \(item.coord.lon)")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
        }
        .padding()
        .background(Color.green.opacity(0.2))
        .cornerRadius(20)
        .frame(height: 110)
    }
}


