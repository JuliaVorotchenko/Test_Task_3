//
//  Functions.swift
//  Test_Task_3
//
//  Created by Юлия Воротченко on 01.09.2020.
//  Copyright © 2020 Юлия Воротченко. All rights reserved.
//

import UIKit

enum F {
    
    static func nibNamefor(_ vcType: UIViewController.Type) -> String {
        let nibName = "\(vcType)"
            .components(separatedBy: ".")
            .first
            .map { $0.prefix { $0 != "<" } }
            .map(String.init)
        return nibName ?? Self.toString(vcType)
    }
    
    static func toString(_ anyClass: Any) -> String {
        return .init(describing: anyClass)
    }
    
    static func Log<T>(_ object: T) {
        print(object)
    }
}

