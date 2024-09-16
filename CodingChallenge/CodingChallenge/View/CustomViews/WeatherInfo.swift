//
//  SwiftUIView.swift
//  CodingChallenge
//
//  Created by Lingeswaran Kandasamy on 9/15/24.
//

import SwiftUI

struct WeatherInfo: View {
    var currentWeather: CurrentWeather
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    var body: some View {
        VStack(spacing: 10) {
            if horizontalSizeClass == .compact {
                compactView
            } else {
                regularView
            }
        }
        .foregroundColor(.theme.accent)
    }
    
    /// Compact layout for portrait mode or iPhone
    private var compactView: some View {
        VStack(spacing: 10) {
            Text(currentWeather.name)
                .font(.largeTitle)
                .fontWeight(.medium)
            
            HStack(spacing: 15) {
                Image(systemName: currentWeather.weather.first?.icon?.text ?? "")
                    .font(.title)
                    .foregroundColor(.theme.accent.opacity(0.8))
                
                Text((currentWeather.main.temp?.asStringRounded() ?? "-") + "°C")
                    .font(.system(size: 50))
                    .fontWeight(.semibold)
            }
            
            Text(currentWeather.weather.first?.description?.capitalized ?? "")
                .foregroundColor(.theme.secondaryText)
            
            HStack(spacing: 6) {
                Text((currentWeather.main.tempMin?.asStringRounded() ?? "-") + "° /")
                Text((currentWeather.main.tempMax?.asStringRounded() ?? "-") + "°")
            }
        }
        .padding(.top, 35)
    }
    
    /// Regular layout for landscape mode or iPad
    private var regularView: some View {
        HStack(spacing: 15) {
            VStack(alignment: .leading, spacing: 10) {
                Text(currentWeather.name)
                    .font(.largeTitle)
                    .fontWeight(.medium)
                
                Text(currentWeather.weather.first?.description?.capitalized ?? "")
                    .foregroundColor(.theme.secondaryText)
            }
            
            Spacer()
            
            VStack(spacing: 10) {
                HStack(spacing: 15) {
                    Image(systemName: currentWeather.weather.first?.icon?.text ?? "")
                        .font(.title)
                        .foregroundColor(.theme.accent.opacity(0.8))
                    
                    Text((currentWeather.main.temp?.asStringRounded() ?? "-") + "°C")
                        .font(.system(size: 50))
                        .fontWeight(.semibold)
                }
                
                HStack(spacing: 6) {
                    Text((currentWeather.main.tempMin?.asStringRounded() ?? "-") + "° /")
                    Text((currentWeather.main.tempMax?.asStringRounded() ?? "-") + "°")
                }
            }
        }
        .padding(.horizontal)
    }
}



#Preview {
    WeatherInfo(currentWeather: CurrentWeather.mock)
}
