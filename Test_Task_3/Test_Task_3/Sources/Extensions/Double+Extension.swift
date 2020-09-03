//
//  Double+Exteension.swift
//  Test_Task_3
//
//  Created by Юлия Воротченко on 29.08.2020.
//  Copyright © 2020 Юлия Воротченко. All rights reserved.
//

import Foundation

extension Double {
    func round(to places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return Darwin.round(self * divisor) / divisor
    }
}
