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
    private let appErrorService: AppErrorService
    
    // MARK: - Initialization
    
    init(navigationController: UINavigationController, appErrorService: AppErrorService) {
        self.navigationController = navigationController
        self.appErrorService = appErrorService
    }
    
    // MARK: - Public Methods
    
    func start() {
        self.createCitiesListViewController()
    }
    
    // MARK: - Private Methods
    
    private func createCitiesListViewController() {
        let controller = CitiesListViewController(eventHandler: { [weak self] in self?.citiesListEvent($0) })
        self.navigationController.setViewControllers([controller], animated: true)
    }
    
    private func citiesListEvent(_ event: CitiesListEvents) {
        switch event {
        case .cityDetails(let coordinates):
            self.createCityDetailsViewController(coordinates: coordinates)
        case .error(let error):
            self.appErrorService.handleError(error)
        }
    }
    
    private func createCityDetailsViewController(coordinates: Coordinates) {
        let controller = CityDetailsViewController(coordinates: coordinates, eventHandler: { [weak self] in self?.cityDetailsEvent($0) })
        self.navigationController.pushViewController(controller, animated: true)
    }
    
    private func cityDetailsEvent(_ event: CityDetailsEvents) {
        switch event {
        case .back:
            self.navigationController.popViewController(animated: true)
        case .error(let error):
            self.appErrorService.handleError(error)
        }
    }
}


