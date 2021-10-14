//
//  WeatherForecastView.swift
//  CombineDemo
//
//  Created by Anjali Aggarwal on 04/10/21.
//

import SwiftUI

struct WeatherForecastView: View {
    var weatherData: [String: [WeatherDataModel]] = [:]
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack(spacing: 10) {
                ForEach(weatherData.keys.sorted(), id: \.self) { key in
                    VStack(spacing: 8) {
                        Text(key)
                        Text("\(weatherData[key]?.compactMap { $0.maxTemp }.max()?.toCelsius ?? "0.0")")
                        Text("\(weatherData[key]?.compactMap { $0.minTemp }.min()?.toCelsius ?? "0.0")")
                    }
                }.padding()
            }
        }
    }
}

struct WeatherForecastView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherForecastView()
    }
}
