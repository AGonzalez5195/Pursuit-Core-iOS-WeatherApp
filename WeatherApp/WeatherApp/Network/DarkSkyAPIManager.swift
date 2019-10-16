//
//  DarkSkyAPIManager.swift
//  WeatherApp
//
//  Created by Anthony Gonzalez on 10/15/19.
//  Copyright © 2019 David Rifkin. All rights reserved.
//

import Foundation


enum AppError: Error {
    case unauthenticated
    case invalidJSONResponse
    case couldNotParseJSON(rawError: Error)
    case noInternetConnection
    case badURL
    case badStatusCode
    case noDataReceived
    case notAnImage
    case other(rawError: Error)
}



class DarkSkyAPIManager {
    private init() {}
    
    static let shared = DarkSkyAPIManager()
    
    func getForecast(lat: Double, long: Double, completionHandler: @escaping (Result<[WeatherForecast], AppError>) -> Void) {
        let urlStr = "https://api.darksky.net/forecast/\(Secret.darkSkyAPIKey)/\(lat),\(long)"
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
                    let weatherInfo = try JSONDecoder().decode(DarkSkyWeatherModel.self, from: data)
                    completionHandler(.success(weatherInfo.daily.data))
                } catch {
                    completionHandler(.failure(.couldNotParseJSON(rawError: error)))
                }
            }
        }
    }
}
