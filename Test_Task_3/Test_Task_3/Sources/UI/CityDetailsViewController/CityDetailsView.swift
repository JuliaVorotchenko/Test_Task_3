//
//  CityDetailsView.swift
//  Test_Task_3
//
//  Created by Юлия Воротченко on 27.08.2020.
//  Copyright © 2020 Юлия Воротченко. All rights reserved.
//

import UIKit
import MapKit

class CityDetailsView: UIView {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var currentTemperatureLabel: UILabel!
    @IBOutlet weak var minMaxTemperatureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    
}
