//
//  DarkSkyWeather.swift
//  WeatherApp
//
//  Created by Anthony Gonzalez on 10/15/19.
//  Copyright © 2019 David Rifkin. All rights reserved.
//

import Foundation

struct DarkSkyWeatherModel: Codable {
    let daily: Weather
}

struct Weather: Codable {
    let data: [WeatherForecast]
}

struct WeatherForecast: Codable {
    let icon: String
    let temperatureHigh: Double
    let temperatureLow: Double
    let time: Int
    var convertedTime: String {
    get {
        return Date(timeIntervalSince1970: TimeInterval(time)).description.components(separatedBy: " ")[0]
        }
    }
}
