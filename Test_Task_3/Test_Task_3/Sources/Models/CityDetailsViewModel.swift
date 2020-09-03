//
//  CityDetailsViewModel.swift
//  Test_Task_3
//
//  Created by Юлия Воротченко on 02.09.2020.
//  Copyright © 2020 Юлия Воротченко. All rights reserved.
//

import Foundation

struct CityDetailsViewModel {
    let cityName: String
    let currentTemperature: Double
    let minTemperature: Double
    let maxTemperature: Double
    let humidity: Int
    let windSpeed: Double
    let coordinates: Coordinates
    
    static func create(weatherModel: WeatherModel) -> Self {
        return .init(cityName: weatherModel.name,
                         currentTemperature: weatherModel.main.temperature,
                         minTemperature: weatherModel.main.minTemperature,
                         maxTemperature: weatherModel.main.maxTemperature,
                         humidity: weatherModel.main.humidity,
                         windSpeed: weatherModel.wind.speed,
                         coordinates: weatherModel.coordinates)
    }
}
