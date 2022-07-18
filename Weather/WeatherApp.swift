//
//  WeatherApp.swift
//  Weather
//
//  Created by Vsevolod R on 17.07.2022.
//

import SwiftUI

@main
struct WeatherApp: App {
    @StateObject private var locationViewModel = LocationViewModel()
    
    var body: some Scene {
        WindowGroup {
            TabView {
                ForecastView()
                    .tabItem {
                        Label("Forecast", systemImage: "cloud.rain.fill")
                    }
                MapView()
                    .tabItem {
                        Label("Map", systemImage: "map.fill")
                    }
            }
            .environmentObject(locationViewModel)
        }
    }
}
