//
//  CityDetailsView.swift
//  Test_Task_3
//
//  Created by Юлия Воротченко on 27.08.2020.
//  Copyright © 2020 Юлия Воротченко. All rights reserved.
//

import UIKit
import MapKit

final class CityDetailsView: UIView, MKMapViewDelegate {
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var currentTemperatureLabel: UILabel!
    @IBOutlet weak var minTemperatureLabel: UILabel!
    @IBOutlet weak var maxTemperatureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    
    // MARK: - Public methods
    
    func fill(with model: WeatherModel) {
        self.mapSetup(with: model)
        self.navigationBar.topItem?.title = "Weather in \(model.name)"
        self.cityNameLabel.text = model.name
        self.currentTemperatureLabel.text = self.setTemperature(kelvins: model.main.temperature) + "°C"
        self.minTemperatureLabel.text = self.setTemperature(kelvins: model.main.minTemperature) + "°C"
        self.maxTemperatureLabel.text = self.setTemperature(kelvins: model.main.maxTemperature) + "°C"
        self.humidityLabel.text = String(describing: model.main.humidity)  + "%"
        self.windLabel.text = String(describing: model.wind.speed) + "m/s"
    }
    
    private func mapSetup(with model: WeatherModel) {
        let latitude = model.coordinates.latitude
        let longitude = model.coordinates.longitude
        let mapView = self.mapView
        mapView?.delegate = self
        mapView?.setCenter(CLLocationCoordinate2D(latitude: latitude, longitude: longitude), animated: true)
        
        let delta = CLLocationDegrees(0.7)
        let theSpan = MKCoordinateSpan(latitudeDelta: delta, longitudeDelta: delta)
        let pointLocation = CLLocationCoordinate2DMake(latitude, longitude)
        let region = MKCoordinateRegion(center: pointLocation, span: theSpan)
        mapView?.setRegion(region, animated: true)
        
        let objectAnnotation = MKPointAnnotation()
        objectAnnotation.coordinate = pointLocation
        mapView?.addAnnotation(objectAnnotation)
    }

    private func setTemperature(kelvins: Double) -> String {
        let celcius = kelvins - 273
        return String(celcius.round(to: 0))
    }
}
