//
//  WeatherViewModel.swift
//  Weather
//
//  Created by Vsevolod R on 17.07.2022.
//

import Foundation

class WeatherViewModel: ObservableObject {
    @Published var weather = WeatherModel()
    
    private let apiKey = "cdf1746567429f1cdb8341ecce81eaf3"
    
    enum FetchError: Error {
        case badRequest
        case badJSON
    }
    
    func fetchData(lat: Double, lon: Double) async throws  {
        let urlString = "http://api.openweathermap.org/data/2.5/forecast?lat=\(lat)&lon=\(lon)&units=metric&appid=\(apiKey)"
        
        let url = URL(string: urlString)!

        let (data, response) = try await URLSession.shared.data(for: URLRequest(url: url))
    
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { throw FetchError.badRequest }
        
        Task { @MainActor in
            weather = try JSONDecoder().decode(WeatherModel.self, from: data)
        }
    }
}
