//
//  ImageLoadingService.swift
//  Test_Task_3
//
//  Created by Юлия Воротченко on 28.08.2020.
//  Copyright © 2020 Юлия Воротченко. All rights reserved.
//

import Foundation

import UIKit

protocol ImageLoadingService {
    
    func loadImage(mainPath: Path,
                   completion: ((Result<UIImage, ImageError>) -> Void)?)
    func cancelLoading()
}

enum Path: String {
    case oddUrl = "https://infotech.gov.ua/storage/img/Temp1.png"
    case evenUrl = "https://infotech.gov.ua/storage/img/Temp3.png"
}

enum ImageError: Error {
    case unableToCreateImage
}

class ImageLoadingServiceImpl: ImageLoadingService {
    
    // MARK: - Private properties
    
    private let cache: NSCache<NSURL, UIImage>
    private let networkService: NetworkServiceProtocol
    private let queue: DispatchQueue
    private var dataTask: URLSessionDataTask?
    
    // MARK: - Initialization
    
    init(networkService: NetworkServiceProtocol = NetworkService(),
         queue: DispatchQueue = .main) {
        self.cache = .init()
        self.networkService = networkService
        self.queue = queue
    }
    
    // MARK: - Public methods
    
    func loadImage(mainPath: Path = .evenUrl,
                   completion: ((Result<UIImage, ImageError>) -> Void)?) {
        guard let url = URL(string: mainPath.rawValue) else { fatalError("Unable create url") }
        
        if let cachedImage = self.cache.object(forKey: url as NSURL) {
            completion?(.success(cachedImage))
        } else {
            self.dataTask = self.networkService.perform(request: URLRequest(url: url)) { [weak self] result in
                guard let `self` = self else { return }
                self.queue.async {
                    switch result {
                    case .success(let data, _):
                        switch self.createImage(from: data) {
                        case .success(let image):
                            self.cache.setObject(image, forKey: url as NSURL)
                            completion?(.success(image))
                        case .failure(let error):
                            completion?(.failure(error))
                        }
                    case .failure:
                        completion?(.failure(.unableToCreateImage))
                    }
                }
            }
            self.dataTask?.resume()
        }
    }
    
    func cancelLoading() {
        self.dataTask?.cancel()
    }
    
    // MARK: - Private methods
    
    private func createImage(from data: Data?) -> Result<UIImage, ImageError> {
        return data
            .flatMap(UIImage.init)
            .flatMap(Result.success) ?? .failure(.unableToCreateImage)
    }
}

