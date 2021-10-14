//
//  LocationViewModel.swift
//  CombineDemo
//
//  Created by Anjali Aggarwal on 01/10/21.
//

import Foundation
import Combine
import CoreLocation

class MyLocationViewModel: ObservableObject {
    private var cancellables = Set<AnyCancellable>()
    private let locationService = LocationService()

    @Published private(set) var isLoading = false
    @Published private(set) var location: CLLocation?
    @Published private(set) var locationError: LocationError?

    func fetchLocation() {
        isLoading = true
        locationService.requestWhenInUseAuthorization()
            .flatMap { self.locationService.requestLocation() }
            .sink { completion in
                if case .failure(let error) = completion {
                    self.locationError = error
                }
                self.isLoading = false
            } receiveValue: { location in
                self.location = location
            }
            .store(in: &cancellables)
    }
}
