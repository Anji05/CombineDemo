//
//  WeatherDataModel.swift
//  CombineDemo
//
//  Created by Anjali Aggarwal on 01/10/21.
//

import Foundation

struct WeatherDataModel: Hashable {
    var currentTemp: Double?
    var minTemp: Double?
    var maxTemp: Double?
    var feelsTemp: Double?
    var windSpeed: Double?
    var date: String?
    var time: String?
    var humidity: Int?
    var pressure: Int?
    var icon: String?
//    var shortDescription: String?
    var weatherDescription: String?
}

struct LocationDataModel: Hashable {
    var cityName: String?
    var latitude: Double?
    var longitude: Double?
}
