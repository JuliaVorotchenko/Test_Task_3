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

protocol APIInteractionService {
    func loadWeather(coordinates: Coordinates, completion: ((Result<WeatherModel, WeatherError>) -> Void)?)
}

class ApiInteractionServiceImpl: APIInteractionService {
    
    // MARK: - Private properties
    
    private let networkService: NetworkServiceProtocol
    private let queue: DispatchQueue
    private var dataTask: URLSessionDataTask?
    
    // MARK: - Initialization
    
    init(networkService: NetworkServiceProtocol = NetworkService(),
         queue: DispatchQueue = .main) {
        self.networkService = networkService
        self.queue = queue
    }
    
    // MARK: - Public methods
    
    func loadWeather(coordinates: Coordinates, completion: ((Result<WeatherModel, WeatherError>) -> Void)?) {
        let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(coordinates.latitude)&lon=\(coordinates.longitude)&appid=\(Constants.apiKey)")
        self.dataTask = self.networkService.perform(request: URLRequest(url: url!), completion: { [weak self] result in
            guard let `self` = self else { return }
            self.queue.async {
                switch result {
                case .success(let data, _):
                    guard let data = data else { return }
                    switch self.decodeData(from: data) {
                    case .success(let model):
                        completion?(.success(model))
                    case .failure(let error):
                        completion?(.failure(error))
                    }
                case .failure:
                    completion?(.failure(.unableTorecieveWeatherData))
                }
            }
        })
        
    }
    
    private func decodeData(from data: Data) -> Result<WeatherModel, WeatherError> {
        let decoder = JSONDecoder()
        do {
            let model = try decoder.decode(WeatherModel.self, from: data)
            return .success(model)
        } catch {
            print("error:\(error)")
        }
        return .failure(.unableTorecieveWeatherData)
    }
}

enum WeatherError: Error {
    case unableTorecieveWeatherData
}
