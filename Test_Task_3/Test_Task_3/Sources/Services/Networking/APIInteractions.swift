//
//  APIInteractions.swift
//  Test_Task_3
//
//  Created by Юлия Воротченко on 28.08.2020.
//  Copyright © 2020 Юлия Воротченко. All rights reserved.
//

import Foundation

struct Constants {
    static let apiKey = "990d8ed95b3d6b04b875e8efff4d0969"
    
}

enum Url {
    case coordinates(longitude: String, attitude: String)
    
    var urlByCoordinates: URL {
        switch self {
        case .coordinates(let longitude, let lattitude):
            guard let url = URL(string: "api.openweathermap.org/data/2.5/weather?lat=\(lattitude)&lon=\(longitude)&appid=\(Constants.apiKey)") else { return URL(string: "")!}
            return url
        }
        
    }
}
