//
//  NetworkService.swift
//  Test_Task_3
//
//  Created by Юлия Воротченко on 28.08.2020.
//  Copyright © 2020 Юлия Воротченко. All rights reserved.
//

import Foundation

protocol NetworkServiceProtocol {
    @discardableResult func perform(request: URLRequest,
                                    completion: @escaping (Result<(Data?, HTTPURLResponse), Error>) -> Void)
        -> URLSessionDataTask
}

class NetworkService: NetworkServiceProtocol {
    private let session: URLSession
    
    init() {
        let configuration = URLSessionConfiguration.default
        self.session = URLSession(configuration: configuration)
    }
    
    @discardableResult func perform(request: URLRequest,
                                    completion: @escaping (Result<(Data?, HTTPURLResponse), Error>) -> Void)
        -> URLSessionDataTask {
            let dataTask = self.session.dataTask(with: request) { data, response, error in
                guard let response = response as? HTTPURLResponse else {
                    completion(.failure(error!))
                    return
                }
                
                completion(.success((data, response)))
            }
            dataTask.resume()
            
            return dataTask
    }
}
