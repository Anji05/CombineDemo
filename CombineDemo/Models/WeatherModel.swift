//
//  WeatherModel.swift
//  CombineDemo
//
//  Created by Anjali Aggarwal on 28/09/21.
//

import Foundation
// MARK: - Welcome
struct WeatherResponse: Codable {
    let cod: String
    let message, cnt: Int
    let list: [WeatherList]
    let city: City
}

// MARK: - City
struct City: Codable {
    let id: Int
    let name: String
    let coord: Coord
    let country: String
    let population, timezone, sunrise, sunset: Int
}

// MARK: - Coord
struct Coord: Codable {
    let lat, lon: Double
}

// MARK: - List
struct WeatherList: Codable, Hashable {
    let dt: Int
    let main: MainClass
    let weather: [Weather]
    let clouds: Clouds
    let wind: Wind
    let visibility: Int
    let pop: Double
    let sys: Sys
    let dtTxt: String
    let rain: Rain?
    
    var date: String {
        let dateFormatter = DateFormatter()
//        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = dateFormatter.date(from: dtTxt)!
        dateFormatter.dateStyle = .short
        let strDate = dateFormatter.string(from: date)
        return strDate
    }
    
    var time: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = dateFormatter.date(from: dtTxt)!
        dateFormatter.timeStyle = .short
        let time = dateFormatter.string(from: date)
        return time
    }

    enum CodingKeys: String, CodingKey {
        case dt, main, weather, clouds, wind, visibility, pop, sys
        case dtTxt = "dt_txt"
        case rain
    }
}

// MARK: - Clouds
struct Clouds: Codable, Hashable {
    let all: Int
}

// MARK: - MainClass
struct MainClass: Codable, Hashable {
    let temp, feelsLike, tempMin, tempMax: Double
    let pressure, seaLevel, grndLevel, humidity: Int
    let tempKf: Double

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure
        case seaLevel = "sea_level"
        case grndLevel = "grnd_level"
        case humidity
        case tempKf = "temp_kf"
    }
}

// MARK: - Rain
struct Rain: Codable, Hashable {
    let the3H: Double

    enum CodingKeys: String, CodingKey {
        case the3H = "3h"
    }
}

// MARK: - Sys
struct Sys: Codable, Hashable {
    let pod: String
}

//enum Pod: String, Codable {
//    case d = "d"
//    case n = "n"
//}

// MARK: - Weather
struct Weather: Codable, Hashable {
    let id: Int
    let main: String
    let weatherDescription: String
    let icon: String

    enum CodingKeys: String, CodingKey {
        case id, main
//        case id, main
        case weatherDescription = "description"
        case icon
    }
}

enum Icon: String, Codable {
    case the03D = "03d"
    case the04D = "04d"
    case the04N = "04n"
    case the10D = "10d"
    case the10N = "10n"
    case the03N = "03n"
}

enum MainEnum: String, Codable {
    case clouds = "Clouds"
    case rain = "Rain"
    case clear = "Clear"
}

enum Description: String, Codable {
    case brokenClouds = "broken clouds"
    case lightRain = "light rain"
    case moderateRain = "moderate rain"
    case overcastClouds = "overcast clouds"
    case scatteredClouds = "scattered clouds"
    case clearSky = "clear sky"
}

// MARK: - Wind
struct Wind: Codable, Hashable {
    let speed: Double
    let deg: Int
    let gust: Double
}
