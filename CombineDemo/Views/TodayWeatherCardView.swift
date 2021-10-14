//
//  TodayWeatherCardView.swift
//  CombineDemo
//
//  Created by Anjali Aggarwal on 05/10/21.
//

import SwiftUI

struct TodayWeatherCardView: View {
    //    var date: String?
    //    var time: String?
    //    var temperature: String
    
    var weatherDataModel: WeatherDataModel?
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .fill(Color.white.opacity(0.1))
            
            VStack(spacing: 20) {
                Text("Today \(weatherDataModel?.minTemp?.toCelsius ?? "") - \(weatherDataModel?.maxTemp?.toCelsius ?? "")")
                    .foregroundColor(.white)
                HStack {
                    VStack(alignment: .leading) {
                        Text("Real Feel")
                            .foregroundColor(.white)
                            .font(.subheadline)
                        Text("\(weatherDataModel?.feelsTemp?.toCelsius ?? "200")")
                            .foregroundColor(.white)
                            .font(.title)
                    }
                    Spacer.init(minLength: 20)
                        .frame(width: 100.0)
                    VStack(alignment: .leading) {
                        Text("Wind Speed")
                            .foregroundColor(.white)
                            .font(.subheadline)
                            .multilineTextAlignment(.leading)
                        Text("\(Int(weatherDataModel?.windSpeed ?? 0.0))km/h")
                            .foregroundColor(.white)
                            .font(.title)
                            .multilineTextAlignment(.leading)
                    }
                    Spacer()
                }
                
                HStack {
                    VStack(alignment: .leading) {
                        Text("Humidity")
                            .foregroundColor(.white)
                            .font(.subheadline)
                        Text("\(weatherDataModel?.humidity ?? 0)%")
                            .foregroundColor(.white)
                            .font(.title)
                    }
                    Spacer.init(minLength: 20)
                        .frame(width: 100.0)
                    VStack(alignment: .leading) {
                        Text("Pressure")
                            .foregroundColor(.white)
                            .font(.subheadline)
                            .font(.title)
                        Text("\(weatherDataModel?.pressure ?? 1000)mbar")
                            .foregroundColor(.white)
                            .font(.title)
                    }
                    Spacer()
                }
              
            }
            .padding(20)
//            .multilineTextAlignment(.center)
        }
        .frame(width: 350, height: 150.0)
        .padding(.top, 30)
        .padding(.bottom, 20)
        
    }
}

struct TodayWeatherCardView_Previews: PreviewProvider {
    static var previews: some View {
        TodayWeatherCardView.init(weatherDataModel: WeatherDataModel.init())
            .background(Color.red)
    }
}
