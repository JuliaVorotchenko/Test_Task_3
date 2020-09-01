//
//  ViewController.swift
//  Test_Task_3
//
//  Created by Юлия Воротченко on 27.08.2020.
//  Copyright © 2020 Юлия Воротченко. All rights reserved.
//

import UIKit
import MapKit

enum CityDetailsEvents {
    case back
    case error(AppError)
}

final class CityDetailsViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet var rootView: CityDetailsView!
    
    // MARK: - Private Properties
    
    let eventHandler: (CityDetailsEvents) -> ()
    let coordinaes: Coordinates
    let networking: APIInteractionService
    var weatherModel: WeatherModel?
    
    
    // MARK: - Initialization
    
    init(coordinates: Coordinates, eventHandler: @escaping (CityDetailsEvents) -> (), networking: APIInteractionService = ApiInteractionServiceImpl()) {
        self.eventHandler = eventHandler
        self.coordinaes = coordinates
        self.networking = networking
        super.init(nibName: F.nibNamefor(Self.self), bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print(Self.self)
    }
    
    // MARK: - VC Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.recieveWeatherModel()
    }
    
    // MARK: - Private Methods
    
    private func recieveWeatherModel() {
        self.networking.loadWeather(coordinates: self.coordinaes) { [weak self] result in
            switch result {
            case .success(let model):
                self?.rootView.fill(with: model)
                self?.weatherModel = model
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    // MARK: - IBActions
    
    @IBAction func onBack(_ sender: UIBarButtonItem) {
        self.eventHandler(.back)
    }
    
}

