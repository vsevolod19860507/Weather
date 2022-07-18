//
//  WeatherModel.swift
//  Weather
//
//  Created by Vsevolod R on 18.07.2022.
//

import Foundation

struct WeatherModel: Codable {
    let list: [List]
    let city: City
    
    init(list: [List] = [], city: City = City(name: "", country: "")) {
        self.list = list
        self.city = city
    }
}

struct City: Codable {
    let name: String
    //    let coord: Coord
    let country: String
}

//struct Coord: Codable {
//    let lat, lon: Int
//}

struct List: Codable {
    let main: MainData
    let weather: [Weather]
    let wind: Wind
    let dtTxt: String
    
    enum CodingKeys: String, CodingKey {
        case main, weather, wind
        case dtTxt = "dt_txt"
    }
}

struct MainData: Codable {
    let temp, tempMin, tempMax: Double
    let humidity: Int
    
    enum CodingKeys: String, CodingKey {
        case temp
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case humidity
    }
}

struct Weather: Codable {
    let icon: String
}

struct Wind: Codable {
    let speed: Double
    let deg: Int
}
