//
//  WeatherRow.swift
//  CombineDemo
//
//  Created by Anjali Aggarwal on 04/10/21.
//

import SwiftUI

struct WeatherRow: View {
    var weatherData: WeatherDataModel
    var body: some View {
        HStack {
            Text(weatherData.time ?? "")
            AsyncImage.init(url: URL.init(string: "https://openweathermap.org/img/w/\(weatherData.icon ?? "01D").png")) { image in
                image
                .resizable()
                .aspectRatio(contentMode: .fit)
            } placeholder: {
                Color.red
            }
            .frame(width: 50, height: 50, alignment: .center)
//            Text("\(weatherData.minTemp?.toCelsius ?? 0.0)")
//            Text("/")
//            Text("\(weatherData.maxTemp?.toCelsius ?? 0.0)")
        }
    }
}

struct WeatherRow_Previews: PreviewProvider {
    static var previews: some View {
        WeatherRow(weatherData: WeatherDataModel.init())
    }
}
