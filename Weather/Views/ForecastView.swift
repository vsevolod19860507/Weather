//
//  ForecastView.swift
//  Weather
//
//  Created by Vsevolod R on 17.07.2022.
//

import SwiftUI

struct ForecastView: View {
    @EnvironmentObject private var locationViewModel: LocationViewModel
    @StateObject private var weatherViewModel = WeatherViewModel()
    
    var body: some View {
        VStack {
            Text(weatherViewModel.weather.city.country)
            Text(weatherViewModel.weather.city.name)
            
            ScrollView{
                ForEach(weatherViewModel.weather.list, id: \.dtTxt) { item in
                    VStack {
                        Divider()
                        
                        HStack {
                            Text(item.dtTxt)
                            AsyncImage(url: URL(string: item.weather.first!.iconUrl)!)
                            {
                                $0
                                    .resizable()
                                    .frame(width: 50, height: 50)
                            }
                        placeholder: {
                            ProgressView()
                        }
                            Text("\(Int(item.main.temp))°C")
                            
                        }
                        HStack {
                            VStack {
                                Text("min")
                                Text("\(Int(item.main.tempMin))°C")
                            }
                            VStack {
                                Text("max")
                                Text("\(Int(item.main.tempMax))°C")
                            }
                            VStack {
                                Image(systemName: "drop.fill")
                                Text("\(item.main.humidity)%")
                            }
                            HStack {
                                VStack {
                                    Image(systemName: "wind")
                                    Text("\(Int(item.wind.speed))m/s")
                                }
                                VStack {
                                    Text("N")
                                    HStack {
                                        Text("W")
                                        Image(systemName: "arrow.up")
                                            .rotationEffect(.degrees(Double(item.wind.deg)))
                                        Text("E")
                                    }
                                    Text("S")
                                }
                            }
                        }
                        
                    }
                }
            }
        }
        .task {
            try? await weatherViewModel.fetchData(lat: locationViewModel.selectedLocation.latitude, lon: locationViewModel.selectedLocation.longitude)
        }
    }
}

struct ForecastView_Previews: PreviewProvider {
    static var previews: some View {
        ForecastView()
    }
}
