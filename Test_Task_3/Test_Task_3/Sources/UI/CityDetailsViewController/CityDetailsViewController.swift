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
}

final class CityDetailsViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet var rootView: CityDetailsView!
    
    // MARK: - Private Properties
    
    let eventHandler: ((CityDetailsEvents) -> ())?
    let model: CityModel
    let networking: APIInteractionService
    var weatherModel: WeatherModel?
    
    
    // MARK: - Initialization
    
    init(model: CityModel, eventHandler: ((CityDetailsEvents) -> ())?, networking: APIInteractionService = ApiInteractionServiceImpl()) {
        self.eventHandler = eventHandler
        self.model = model
        self.networking = networking
        super.init(nibName: String(describing: type(of: self)), bundle: nil)
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
        self.mapSetup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.recieveWeatherModel()
    }
    
    // MARK: - Private Methods
    
    private func recieveWeatherModel() {
        print(#function)
        self.networking.loadWeather(coordinates: model.coordinates) { [weak self] result in
            switch result {
            case .success(let model):
                self?.rootView.fill(with: model)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func mapSetup() {
        let latitude = self.model.coordinates.latitude
        let longitude = self.model.coordinates.longitude
        let mapView = self.rootView.mapView
        mapView?.delegate = self
        mapView?.setCenter(CLLocationCoordinate2D(latitude: latitude, longitude: longitude), animated: true)
        
        let latDelta: CLLocationDegrees = 0.7
        
        let longDelta: CLLocationDegrees = 0.7
        
        let theSpan = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: longDelta)
        let pointLocation = CLLocationCoordinate2DMake(latitude, longitude)
        let region = MKCoordinateRegion(center: pointLocation, span: theSpan)
        mapView?.setRegion(region, animated: true)
        
        let pinLocation : CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        let objectAnnotation = MKPointAnnotation()
        objectAnnotation.coordinate = pinLocation
        objectAnnotation.title = self.model.name
        mapView?.addAnnotation(objectAnnotation)
    }
    // MARK: - IBActions
    
    @IBAction func onBack(_ sender: UIBarButtonItem) {
        self.eventHandler?(.back)
    }
    
}

