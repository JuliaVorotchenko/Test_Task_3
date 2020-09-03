//
//  UITableView + Extension.swift
//  Test_Task_3
//
//  Created by Юлия Воротченко on 01.09.2020.
//  Copyright © 2020 Юлия Воротченко. All rights reserved.
//

import UIKit

extension UITableView {
    
    func register(_ anyClass: AnyClass) {
        let nib = UINib(nibName: F.toString(anyClass), bundle: nil)
        self.register(nib, forCellReuseIdentifier: F.toString(anyClass))
    }
    
    func dequeueReusableCell<T: UITableViewCell>(_ anyClass: AnyClass, for indexPath: IndexPath) -> T {
        let cell = self.dequeueReusableCell(withIdentifier: F.toString(anyClass), for: indexPath)
        guard let cast = cell as? T else { fatalError("Dont find cell") }
        return cast
    }
}
