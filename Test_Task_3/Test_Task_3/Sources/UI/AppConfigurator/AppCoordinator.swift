//
//  AppCoordinator.swift
//  Test_Task_3
//
//  Created by Юлия Воротченко on 27.08.2020.
//  Copyright © 2020 Юлия Воротченко. All rights reserved.
//

import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get }
    func start()
}

final class AppCoordinator: Coordinator {
    // MARK: - Properties
    
    let navigationController: UINavigationController
    var citiesListViewController: CitiesListViewController?
    var cityDetailsViewController: CityDetailsViewController?
    
    // MARK: - Initialization
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: - Public Methods
    
    func start() {
        self.createCitiesListViewController()
    }
    
    // MARK: - Private Methods
    
    private func createCitiesListViewController() {
        let controller = CitiesListViewController(eventHandler: self.citiesListEvent)
        self.navigationController.viewControllers = [controller]
    }
    
    private func citiesListEvent(_ event: CitiesListEvents) {
        switch event {
        case .cityDetails:
            self.createCityDetailsViewController()
            self.citiesListViewController = nil
        }
    }
    
    private func createCityDetailsViewController() {
        let controller = CityDetailsViewController(eventHandler: self.cityDetailsEvent)
        self.navigationController.pushViewController(controller, animated: true)
    }
    
    private func cityDetailsEvent(_ event: CityDetailsEvents) {
        switch event {
        case .back:
            self.navigationController.popViewController(animated: true)
        }
    }
}
