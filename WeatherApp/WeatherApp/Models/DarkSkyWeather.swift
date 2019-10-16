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
    let sunriseTime: Int
    let sunsetTime: Int
    var convertedTime: String {
    get {
        return Date(timeIntervalSince1970: TimeInterval(time)).description.components(separatedBy: " ")[0]
        }
    }
    
    static func convertUNIXTimeToReadableTime(unixTime: Int) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(unixTime))
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "EDT")
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "h:mm a"
        let convertedDateString = dateFormatter.string(from: date)
        return convertedDateString
    }
}
