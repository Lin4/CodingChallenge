//
//  SavedLocationsRow.swift
//  CodingChallenge
//
//  Created by Lingeswaran Kandasamy on 9/15/24.
//

import SwiftUI

struct SavedLocationsRow: View {
    var currentWeather: CurrentWeather
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                Text(currentWeather.name)
                    .font(.title2)
                    .fontWeight(.medium)
                Spacer()
                HStack {
                    Image(systemName: currentWeather.weather.first?.icon?.text ?? "")
                        .font(.title2)
                        .foregroundColor(.theme.accent.opacity(0.8))
                    
                    Text(currentWeather.weather.first?.description?.capitalized ?? "")
                        .foregroundColor(.theme.secondaryText)
                }
            }
            Spacer()
            VStack(alignment: .trailing, spacing: 8) {
                Text((currentWeather.main.temp?.asStringRounded() ?? "-") + "°C")
                    .font(.system(size: 30))
                    .fontWeight(.semibold)
                Spacer()
                HStack(spacing: 6) {
                    Text((currentWeather.main.tempMin?.asStringRounded() ?? "-") + "° /")
                    Text((currentWeather.main.tempMax?.asStringRounded() ?? "-") + "°")
                }
            }
        }
        .foregroundColor(.theme.accent)
        .frame(height: 80)
        .padding()
        .background(Color.theme.blueBackground.opacity(0.8))
        .cornerRadius(20)
    }
}


#Preview {
    SavedLocationsRow(currentWeather: CurrentWeather.mock)
}
