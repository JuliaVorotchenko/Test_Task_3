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
    case networkError(Error?)
}

protocol AppErrorService {
    func handleError(_ error: AppError)
}

final class AppErrorServiceeImpl: AppErrorService {
    
    private let rootViewController: UIViewController?
    
    init(rootViewController: UIViewController?) {
        self.rootViewController = rootViewController
    }
    
    func handleError(_ error: AppError) {
        self.rootViewController?.showErrorAlert("Error", error: error)
    }
}
