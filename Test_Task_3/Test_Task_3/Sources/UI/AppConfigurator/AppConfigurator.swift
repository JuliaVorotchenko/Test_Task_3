//
//  AppConfigurator.swift
//  Test_Task_3
//
//  Created by Юлия Воротченко on 27.08.2020.
//  Copyright © 2020 Юлия Воротченко. All rights reserved.
//

import UIKit

final class AppConfigurator {
    
    private var coordinator: Coordinator?
    
    init(window: UIWindow) {
        self.configure(window: window)
    }
    
    private func configure(window: UIWindow) {
        let navigationController = UINavigationController()
        window.rootViewController = navigationController
        let appErrorService = AppErrorServiceeImpl(rootViewController: window.rootViewController)
        navigationController.navigationBar.isHidden = true
        self.coordinator = AppCoordinator(navigationController: navigationController, appErrorService: appErrorService)
        self.coordinator?.start()
        window.makeKeyAndVisible()
    }
}
