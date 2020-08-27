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

    @IBOutlet weak var cityImage: UIImageView!
    @IBOutlet weak var cityNameLabel: UILabel!
   
    // MARK: - Initialization
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    // MARK: - Public Methods
    
    func fill(with model: CityModel) {
        self.cityNameLabel.text = model.name
    }
    
}
