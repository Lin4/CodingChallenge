//
//  HourlyForecastRow.swift
//  CodingChallenge
//
//  Created by Lingeswaran Kandasamy on 9/15/24.
//

import SwiftUI

struct HourlyForecastRow: View {
    var items: HourlyForecast
    
    var body: some View {
        VStack {
            Text("Weather condition for the day")
                .font(.headline)
                .foregroundColor(.theme.accent)
            
            Divider()
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 15) {
                    ForEach(items.list) { item in
                        HourlyForecastColumn(item: item)
                            .frame(width: 70, height: 165)
                    }
                }
                .padding(.leading)
                .padding(.top, 20)
                .padding(.trailing, 50)
            }
        }
        .foregroundColor(.theme.accent)
        .padding(.vertical)
        .background(Color.theme.hourlyBackground)
        .cornerRadius(12) // Update corner radius to match the design
    }
}


#Preview {
    HourlyForecastRow(items: HourlyForecast.mock)
        .preferredColorScheme(.dark)
}

