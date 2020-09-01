//
//  WeatherModel.swift
//  Test_Task_3
//
//  Created by Юлия Воротченко on 28.08.2020.
//  Copyright © 2020 Юлия Воротченко. All rights reserved.
//

import Foundation

struct WeatherModel: Decodable {
    let coordinates: Coordinates
    let weather: [Weather]
    let base: String
    let main: Main
    let wind: Wind
    let clouds: Clouds
    let date: Int
    let system: System?
    let timezone: Int
    let id: Int
    let name: String
    let cod: Int?
    
    enum CodingKeys: String, CodingKey {
        case coordinates = "coord"
        case weather = "weather"
        case base = "base"
        case main = "main"
        case wind = "wind"
        case clouds = "clouds"
        case date = "dt"
        case system = "sys"
        case timezone = "timezone"
        case id = "id"
        case name = "name"
        case cod = "cod"
    }
}

struct Weather: Decodable {
    let id: Int
    let main: String
    let description: String
    let icon: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case main = "main"
        case description = "description"
        case icon = "icon"
    }
}

struct Main: Decodable {
    let temperature: Double
    let feelsLike: Double
    let minTemperature: Double
    let maxTemperature: Double
    let pressure: Int
    let humidity: Int
    
    enum CodingKeys: String, CodingKey {
        case temperature = "temp"
        case feelsLike = "feels_like"
        case minTemperature = "temp_min"
        case maxTemperature = "temp_max"
        case pressure = "pressure"
        case humidity = "humidity"
    }
}

struct Wind: Decodable {
    let speed: Double
    let deg: Double?
}

struct Clouds: Decodable {
    let all: Int?
}

struct System: Decodable {
    let type: Int?
    let id: Int?
    let message: Double?
    let country: String?
    let sunrise: Int?
    let sunset: Int?
}
