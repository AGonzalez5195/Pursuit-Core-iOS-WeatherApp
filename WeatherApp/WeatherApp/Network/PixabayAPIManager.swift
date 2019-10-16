//
//  PixabayAPIManager.swift
//  WeatherApp
//
//  Created by Anthony Gonzalez on 10/16/19.
//  Copyright © 2019 David Rifkin. All rights reserved.
//

import Foundation

class PixabayAPIManager {
    private init() {}
    
    static let shared = PixabayAPIManager()
    
    func getPhotos(searchQuery: String, completionHandler: @escaping (Result<[PixabayPhoto], AppError>) -> Void) {
        let urlStr = "https://pixabay.com/api/?key=\(Secret.pixabayAPIKey)&per_page=50&q=\(searchQuery)"
        
        guard let url = URL(string: urlStr) else {
            completionHandler(.failure(.badURL))
            return
        }
        
        NetworkHelper.manager.performDataTask(withUrl: url, andMethod: .get) { (result) in
            switch result {
            case .failure(let error) :
                completionHandler(.failure(error))
            case .success(let data):
                do {
                    let pixabayPhotoData = try JSONDecoder().decode(PixabayWrapper.self, from: data)
                    completionHandler(.success(pixabayPhotoData.hits))
                } catch {
                    completionHandler(.failure(.couldNotParseJSON(rawError: error)))
                }
            }
        }
    }
}
