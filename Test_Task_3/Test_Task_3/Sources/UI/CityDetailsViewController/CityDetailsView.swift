//
//  CityDetailsView.swift
//  Test_Task_3
//
//  Created by Юлия Воротченко on 27.08.2020.
//  Copyright © 2020 Юлия Воротченко. All rights reserved.
//

import UIKit
import MapKit

final class CityDetailsView: UIView {

    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var currentTemperatureLabel: UILabel!
    @IBOutlet weak var minMaxTemperatureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    
    
    // MARK: - Public methods

    func fill(with model: WeatherModel) {
        self.navigationBar.topItem?.title = "Weather in \(model.name)"
        self.cityNameLabel.text = model.name
        self.dateLabel.text = String(model.date)
        self.currentTemperatureLabel.text = "\(model.main?.temperature)"
        self.minMaxTemperatureLabel.text = "\(model.main?.minTemperature)" + " " + "\(model.main?.maxTemperature)"
        self.humidityLabel.text = "\(model.main?.humidity)"
        self.windLabel.text = "\(model.wind.speed)"
    }
}
