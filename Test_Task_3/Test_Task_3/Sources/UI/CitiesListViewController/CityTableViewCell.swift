//
//  CityTableViewCell.swift
//  Test_Task_3
//
//  Created by Юлия Воротченко on 27.08.2020.
//  Copyright © 2020 Юлия Воротченко. All rights reserved.
//

import UIKit

final class CityTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var cityImage: LoadingImageView!
    @IBOutlet weak var cityNameLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.cityNameLabel.text = ""
        self.cityImage.cancelLoading()
    }
    
    // MARK: - Public Methods
    
    func fill(with model: CityViewModel) {
        self.cityNameLabel.text = model.name
        self.cityImage.loadImage(mainPath: model.url)
    }
    
}

struct CityViewModel {
    let name: String
    let url: Path
    let coordinates: Coordinates
}
