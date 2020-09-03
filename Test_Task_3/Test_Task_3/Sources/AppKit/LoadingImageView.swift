//
//  LoadingImageView.swift
//  Test_Task_3
//
//  Created by Юлия Воротченко on 28.08.2020.
//  Copyright © 2020 Юлия Воротченко. All rights reserved.
//

import UIKit

class LoadingImageView: UIImageView, ActivityViewPresenter {
    private let loadingService: ImageLoadingService = ImageLoadingServiceImpl()
    let loadingView = ActivityView()
    deinit {
        self.cancelLoading()
    }
    
    func loadImage(mainPath: Path?) {
        self.showActivity()
        guard let mainPath = mainPath else { return }
        self.loadingService.loadImage(mainPath: mainPath) { [weak self] result in
            switch result {
            case .success(let image):
                self?.hideActivity()
                self?.image = image
                
            case .failure:
                self?.hideActivity()
                self?.image = UIImage(named: "empty")
            }
        }
    }
    
    func cancelLoading() {
        self.image = UIImage(named: "empty")
        self.hideActivity()
        self.loadingService.cancelLoading()
    }
}
