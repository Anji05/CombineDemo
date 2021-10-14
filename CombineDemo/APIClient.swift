//
//  APIClient.swift
//  CombineDemo
//
//  Created by Anjali Aggarwal on 01/10/21.
//

import CoreGraphics
import Foundation
import Combine
import SwiftUI

class APIClient {
    static let shared = APIClient()
    
    func fetchWeatherInfo(latitude: CGFloat, longitude: CGFloat) -> AnyPublisher<WeatherResponse, Error
    > {
        let urlString = "https://api.openweathermap.org/data/2.5/forecast?lat=\(latitude)&lon=\(longitude)&APPID=751d80f6c314139192ffcb62c107e654"
        let url = URL(string: urlString)!
        return URLSession.shared
               .dataTaskPublisher(for: url)
               .tryMap { element -> Data in
                   guard let httpResponse = element.response as? HTTPURLResponse,
                       httpResponse.statusCode == 200 else {
                           throw URLError(.badServerResponse)
                   }
                   return element.data
           }
           .receive(on: DispatchQueue.main)
           .decode(type: WeatherResponse.self, decoder: JSONDecoder())
           .eraseToAnyPublisher()

    }
    
    func searchLocation(query: String) -> AnyPublisher<Location, Error> {
        let urlQueryStr = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        let url = URL(string: "https://places-dsn.algolia.net/1/places/query?query=\(urlQueryStr!)&language=en&countries=in&type=city")!
        var urlRequest = URLRequest.init(url: url)
        urlRequest.allHTTPHeaderFields =  ["X-Algolia-Application-Id": "plNW8IW0YOIN",
                                           "X-Algolia-API-Key": "029766644cb160efa51f2a32284310eb"]
        return URLSession.shared
            .dataTaskPublisher(for: urlRequest)
            .tryMap { element -> Data in
                guard let httpResponse = element.response as? HTTPURLResponse,
                    httpResponse.statusCode == 200 else {
                        throw URLError(.badServerResponse)
                }
                return element.data
            }
            .receive(on: DispatchQueue.main)
            .decode(type: Location.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
