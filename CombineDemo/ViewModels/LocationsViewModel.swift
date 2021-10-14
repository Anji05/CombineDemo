//
//  LocationsViewModel.swift
//  CombineDemo
//
//  Created by Anjali Aggarwal on 06/10/21.
//

import Foundation
import Combine
import CoreLocation

class LocationsViewModel: ObservableObject {
    private var cancellables = Set<AnyCancellable>()

    @Published private(set) var locationsResponse: Location?
    @Published private(set) var locations = [LocationDataModel]()

    func fetchLocation(query: String) {
        APIClient.shared.searchLocation(query: query).sink(
                receiveCompletion: {
                    print("Received completion: \($0)")
                },
                receiveValue: { response in
                    self.locations.removeAll()
                    self.locationsResponse = response
                    for location in response.hits {
                        if let locale = location.localeNames.first, locale.lowercased().contains(query.lowercased()) {
                            var locationModel = LocationDataModel()
                            locationModel.cityName = "\(location.localeNames.first ?? ""), \(location.administrative.first ?? "")"
                            locationModel.latitude = location.geoloc.lat
                            locationModel.longitude = location.geoloc.lng
                            self.locations.append(locationModel)
                        }
                    }
                })
            .store(in: &cancellables)
    }
}
