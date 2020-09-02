//
//  AppErrorService.swift
//  Test_Task_3
//
//  Created by Юлия Воротченко on 01.09.2020.
//  Copyright © 2020 Юлия Воротченко. All rights reserved.
//

import UIKit

enum AppError: Error {
    
    case jsonError
    case unowned(Error)
    case networkError(NetworkError)
    
    var stringDescription: String {
        
        switch self {
        case .jsonError: return "Couldn retrieve data"
        case .networkError(let error): return error.stringDescription
        case .unowned(let error): return error.localizedDescription
            
        }
    }
}

protocol AppErrorService {
    func handleError(_ error: AppError)
}

final class AppErrorServiceImpl: AppErrorService {
    
    private let rootViewController: UIViewController?
    
    init(rootViewController: UIViewController?) {
        self.rootViewController = rootViewController
    }
    
    func handleError(_ error: AppError) {
        self.rootViewController?.showAppError("Error", error: error)
    }
}
