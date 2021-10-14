//
//  SearchLocationView.swift
//  CombineDemo
//
//  Created by Anjali Aggarwal on 06/10/21.
//

import SwiftUI
import Combine
import CoreLocation

struct SearchLocationView: View {
    @State var searchText: String
    
    @ObservedObject var locationViewModel = LocationsViewModel()
    @Environment(\.presentationMode) var presentationMode
    
    @EnvironmentObject var user: UserSelectedCities
    
    var body: some View {
        NavigationView {
            List {
                ForEach(locationViewModel.locations, id: \.self) { location in
                    HStack {
                        Text("\(location.cityName ?? "")")
                            .onTapGesture {
                                presentationMode.wrappedValue.dismiss()
                            }
                        Spacer()
                        Button.init {
                            let cityLocation = CLLocation.init(
                                latitude: CLLocationDegrees.init(location.latitude ?? 0.0),
                                longitude: CLLocationDegrees.init(location.longitude ?? 0.0))
                            user.add(city: MyCity.init(name: location.cityName,
                                                       location: cityLocation,
                                                       latitude: location.latitude,
                                                       longitude: location.longitude))
                            presentationMode.wrappedValue.dismiss()
                        } label: {
                            Image.init(systemName: "plus")
                        }
                    }
                }
                .listRowSeparator(.hidden)
            }
            .listStyle(.plain)
            .navigationTitle("Manage Cities")
        }
        .searchable(text: $searchText, placement: .navigationBarDrawer)
        .onChange(of: searchText) { searchText in
            if !(searchText.isEmpty) && searchText.count >= 2 {
                locationViewModel.fetchLocation(query: searchText)
            }
        }
    }
}

struct SearchLocationView_Previews: PreviewProvider {
    static var previews: some View {
        SearchLocationView(searchText: "")
    }
}
