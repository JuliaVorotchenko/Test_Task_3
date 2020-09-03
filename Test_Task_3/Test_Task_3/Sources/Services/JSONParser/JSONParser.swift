//
//  File.swift
//  Test_Task_3
//
//  Created by Юлия Воротченко on 27.08.2020.
//  Copyright © 2020 Юлия Воротченко. All rights reserved.
//

import Foundation

protocol JSONParser {
    func parseJSON(file: String) -> Result<[CityModel], AppError>
}

final class JSONParserImpl: JSONParser {
    
    public func parseJSON(file: String) -> Result<[CityModel], AppError>  {
        if let url = Bundle.main.url(forResource: file, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode([CityModel].self, from: data)
                return .success(jsonData)
            } catch {
                return .failure(.unowned(error))
            }
        }
        return .failure(.jsonError)
    }
}
