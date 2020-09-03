//
//  CitiesListModel.swift
//  Test_Task_3
//
//  Created by Юлия Воротченко on 27.08.2020.
//  Copyright © 2020 Юлия Воротченко. All rights reserved.
//

import Foundation

struct CityModel: Decodable {
    let id: Int
    let name: String
    let state: String
    let country: String
    let coordinates: Coordinates
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case state
        case country
        case coordinates = "coord"
    }
    
}

struct Coordinates: Decodable {
    let longitude: Double
    let latitude: Double
    
    enum CodingKeys: String, CodingKey {
        case longitude = "lon"
        case latitude = "lat"
    }
}


