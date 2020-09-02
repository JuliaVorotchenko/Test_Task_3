//
//  UIViewController + Extension.swift
//  Test_Task_3
//
//  Created by Юлия Воротченко on 01.09.2020.
//  Copyright © 2020 Юлия Воротченко. All rights reserved.
//

import UIKit

// MARK: - Alert constants

struct  TextConstants {
    static let close = "Close"
}

// MARK: - Protocol extension

extension UIViewController {
    
    // MARK: - Private typealias
    
    private typealias Text = TextConstants
    
    // MARK: - Methods
    
    func showAlert(title: String?,
                   message: String? = nil,
                   preferredStyle: UIAlertController.Style = .alert,
                   actions: [UIAlertAction]? = [UIAlertAction(title: Text.close,
                                                              style: .destructive,
                                                              handler: nil)]) {
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: preferredStyle)
        actions?.forEach { alertController.addAction($0) }
        self.present(alertController, animated: true, completion: nil)
    }
    
    func showAppError(_ title: String?, error: AppError) {
        self.showAlert(title: title, message: error.stringDescription)
    }
}
