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
    let temperatureHigh: Double
    let temperatureLow: Double
}
