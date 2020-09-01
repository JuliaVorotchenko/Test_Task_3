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
    func loadWeather(coordinates: Coordinates, completion: @escaping (Result<WeatherModel, NetworkError>) -> Void)
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
    
    func loadWeather(coordinates: Coordinates, completion: @escaping (Result<WeatherModel, NetworkError>) -> Void) {
        let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(coordinates.latitude)&lon=\(coordinates.longitude)&appid=\(Constants.apiKey)")!
        self.dataTask = self.networkService.perform(request: URLRequest(url: url), completion: { [weak self] result in
            guard let `self` = self else { return }
            self.queue.async {
                switch result {
                case .success(let data, let response):
                    self.handleNetworkResponse(data, response: response, completion: completion)
                case .failure:
                    completion(.failure(.resultError))
                }
            }
        })
    }
    
    private func decode<Value: Decodable>(_ data: Data?) -> Result<Value, NetworkError> {
        do {
            guard let data = data else { return .failure(.encodingFailed) }
            let value = try JSONDecoder().decode(Value.self, from: data)
            return .success(value)
        } catch {
            return .failure(.encodingFailed)
        }
    }
    
    private func handleNetworkResponse(_ data: Data?,
                                       response: HTTPURLResponse,
                                       completion: @escaping (Result<WeatherModel, NetworkError>) -> Void) {
        switch response.statusCode {
        case 200...300:
            completion(self.decode(data))
        case 501...599:
            completion(.failure(.badRequest))
        default:
            completion(.failure(.networkingResponse))
        }
    }
}


enum WeatherError: Error {
    case unableTorecieveWeatherData
}

enum NetworkError: Error {
    case parametersNil
    case encodingFailed
    case missingURL
    case resultError
    case badRequest
    case outdated
    case networkingResponse
    
    case other(URLError: Error?)
    
    var stringDescription: String {
        switch self {
        case .parametersNil:
            return "Parameters were nil."
        case .encodingFailed:
            return "Parameters encoding failed."
        case .missingURL:
            return "URL is nil."
        case .resultError:
            return "Couldnt`t parse resultError"
        case .networkingResponse:
            return "Couldnt "
        case .other(let error): return error?.localizedDescription ?? "other error"
        case .badRequest:
            return self.localizedDescription
        case .outdated:
            return self.localizedDescription
        }
    }
}
