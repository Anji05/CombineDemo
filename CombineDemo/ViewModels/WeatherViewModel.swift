//
//  WeatherViewModel.swift
//  CombineDemo
//
//  Created by Anjali Aggarwal on 04/10/21.
//

import Foundation
import SwiftUI
import Combine
import CoreLocation

class WeatherViewModel: ObservableObject {
    private var cancellables = Set<AnyCancellable>()
    
    @Published private(set) var weatherResponse: WeatherResponse?
    @Published private(set) var weatherModelArray = [WeatherDataModel]()
    @Published private(set) var todayWeather: [WeatherDataModel]?
    @Published private(set) var weatherData: [String: [WeatherDataModel]] = [:]
    
    func fetchWeatherData(location: CLLocation) {
        APIClient.shared.fetchWeatherInfo(latitude: location.coordinate.latitude,
                                              longitude: location.coordinate.longitude).sink(
                receiveCompletion: {
                    print("Received completion: \($0)")
                },
                receiveValue: { response in
                    self.weatherResponse = response
                    self.weatherModelArray.removeAll()
                    for element in response.list {
                        let weatherModel = WeatherDataModel.init(
                            currentTemp: element.main.temp,
                            minTemp: element.main.tempMin,
                            maxTemp: element.main.tempMax,
                            feelsTemp: element.main.feelsLike,
                            windSpeed: element.wind.speed,
                            date: element.date,
                            time: element.time,
                            humidity: element.main.humidity,
                            pressure: element.main.pressure,
                            icon: element.weather[0].icon,
                            weatherDescription: element.weather[0].weatherDescription)
                        self.weatherModelArray.append(weatherModel)
                    }
                    let todayDate = Date()
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateStyle = .short
                    let todayDateStr = dateFormatter.string(from: todayDate)
                    self.todayWeather = self.weatherModelArray.filter {$0.date == todayDateStr}
                    self.getFutureDatesWeather()
                })
            .store(in: &cancellables)
    }
    
    func getFutureDatesWeather() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        let dates = self.weatherModelArray.map {$0.date}.unique()
        for date in dates {
            weatherData[date!] = weatherModelArray.filter {$0.date == date}
        }
    }
}
