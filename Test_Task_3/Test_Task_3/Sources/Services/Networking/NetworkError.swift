//
//  File.swift
//  Test_Task_3
//
//  Created by Юлия Воротченко on 02.09.2020.
//  Copyright © 2020 Юлия Воротченко. All rights reserved.
//

import Foundation

enum NetworkError: Error {
 
    case encodingFailed
    case resultError
    case badRequest
    case outdated
    case networkingResponse
    case other(URLError: Error?)
    
    var stringDescription: String {
        switch self {
        case .encodingFailed:
            return "Parameters encoding failed."
        case .resultError:
            return "Couldnt`t parse resultError"
        case .networkingResponse:
            return "Couldnt retrieve data from server"
        case .other(let error):
            return error?.localizedDescription ?? "other error"
        case .badRequest:
            return "Wrong URL"
        case .outdated:
            return "Outdated server"
        }
    }
}
