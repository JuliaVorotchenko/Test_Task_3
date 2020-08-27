//
//  ViewController.swift
//  Test_Task_3
//
//  Created by Юлия Воротченко on 27.08.2020.
//  Copyright © 2020 Юлия Воротченко. All rights reserved.
//

import UIKit

enum CityDetailsEvents {
    case back
}

final class CityDetailsViewController: UIViewController {
    
    @IBOutlet var rootView: CityDetailsView!
    
    // MARK: - Private Properties
    
    let eventHandler: ((CityDetailsEvents) -> ())?
    
    // MARK: - Initialization
    
    init(eventHandler: ((CityDetailsEvents) -> ())?) {
        self.eventHandler = eventHandler
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
    }
    
    // MARK: - Private Methods
    
    
    
    // MARK: - IBActions
    
    @IBAction func onBack(_ sender: UIBarButtonItem) {
        self.eventHandler?(.back)
    }
}

