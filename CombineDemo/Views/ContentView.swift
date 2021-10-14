//
//  ContentView.swift
//  CombineDemo
//
//  Created by Anjali Aggarwal on 28/09/21.
//

import SwiftUI
import Combine
import CoreLocation

let GlobalAPIKey = "ac"

struct MyCity: Hashable {
    var name: String?
    var location: CLLocation?
    var latitude: Double?
    var longitude: Double?
}

class UserSelectedCities: ObservableObject {
    @Published var cities = [MyCity]()
    
    init() {
        
    }
    
    func add(city: MyCity) {
        cities.append(city)
    }
    
}

struct ContentView: View {
    
    @State var subscriber: AnyCancellable?
    
    @State var users = [Weather]()
    
    @State var subscribed = false
    
    @ObservedObject var viewModel = MyLocationViewModel()
    
    @ObservedObject var weatherDataViewModel = WeatherViewModel()
    
    @State var isLinkActive = false
    
    @State var isAddLocationActive = false
    
    @State var currentCity: MyCity?
    
    let userSelectedCities = UserSelectedCities()
    
    let columns = [
        GridItem(.flexible())
    ]
    
    init() {
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Image.init(uiImage: UIImage.init(named: "sky")!)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .edgesIgnoringSafeArea(.all)
                VStack(alignment: .center, spacing: 20) {
                    if let location = viewModel.location {
                        VStack(spacing: 4) {
                            VStack(spacing: 4) {
                                Text(weatherDataViewModel.todayWeather?[0].currentTemp?.toCelsius ?? "")
                                    .font(Font.system(size: 60))
                                    .foregroundColor(.white)
                                HStack {
AsyncImage.init(url: URL.init(string: "https://openweathermap.org/img/w/\(weatherDataViewModel.todayWeather?[0].icon ?? "01D").png")) { image in
                                        image
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                    } placeholder: {
                                        
                                    }
                                    .frame(width: 30, height: 30, alignment: .center)
                                    Text(weatherDataViewModel.todayWeather?[0].weatherDescription ?? "")
                                        .font(.subheadline)
                                        .foregroundColor(.white)
                                }
                            }
                            .frame(minHeight: 200)
                            
                            TodayWeatherCardView.init(weatherDataModel: weatherDataViewModel.todayWeather?[0])
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 20) {
                                    ForEach(weatherDataViewModel.todayWeather ?? [], id: \.self) { element in
                                        ShortWeatherDetailView(weatherModel: element)
                                    }
                                }
                            }
                            .padding(20)
                            .offset(x: 0)
                            .frame(width: 350, height: 150)
                            
                            Spacer()
                            
                            NavigationLink(destination: WeatherForecastView(weatherData: weatherDataViewModel.weatherData), isActive: $isLinkActive) {
                                Button.init("Next 5 days forecast") {
                                    isLinkActive = true
                                }
                                .font(.title)
                                .tint(Color.white.opacity(0.5))
                                .buttonStyle(.borderedProminent)
                                .tint(Color.red)
                            }
                            Spacer()
                        }
                        .onAppear {
                            // TO DO - get city name from coordinates
                            //                            userSelectedCities.add(city: MyCity.init(name: "My Location",
                            //                                                                     location: location,
                            //                                                                     latitude: location.coordinate.latitude,
                            //                                                                     longitude: location.coordinate.longitude))
                            if !subscribed {
                                subscribed = true
                                weatherDataViewModel.fetchWeatherData(location: location)
                            } else {
                                if let location = currentCity?.location {
                                    weatherDataViewModel.fetchWeatherData(location: location)
                                }
                            }
                            
                        }
                    } else {
                        ProgressView()
                    }
                }
            }
            .frame(maxHeight: .infinity)
            .navigationBarTitle(weatherDataViewModel.weatherResponse?.city.name ?? "", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
 NavigationLink.init(destination: ManageCitiesView(currentCity: $currentCity).environmentObject(userSelectedCities), isActive: $isAddLocationActive) {
                        Button.init {
                            isAddLocationActive = true
                        } label: {
                            Image.init(systemName: "plus")
                        }
                        .tint(Color.white)
                    }
                    
                }
            }
            
        }
        .onAppear(perform: {
            viewModel.fetchLocation()
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct ShortWeatherDetailView: View {
    var weatherModel: WeatherDataModel
    var body: some View {
        VStack(alignment: .center, spacing: 4) {
            Text("\(weatherModel.time ?? "")")
                .foregroundColor(.white)
                .font(.caption)
            Text(weatherModel.currentTemp?.toCelsius ?? "")
                .foregroundColor(.white)
            AsyncImage.init(url: URL.init(string: "https://openweathermap.org/img/w/\(weatherModel.icon ?? "01D").png"))
            
        }
    }
}
