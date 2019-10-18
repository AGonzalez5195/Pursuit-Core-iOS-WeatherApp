//
//  WeatherAppTests.swift
//  WeatherAppTests
//
//  Created by Anthony Gonzalez on 10/18/19.
//  Copyright © 2019 David Rifkin. All rights reserved.
//

import XCTest

class WeatherAppTests: XCTestCase {
     var weatherData = [WeatherForecast]()
    
    
    func testUnixTimeConverter() {
        
        let example = WeatherForecast(icon: String(), temperatureHigh: Double(), temperatureLow: Double(), windSpeed: Double(), precipIntensityMax: Double(), time: 1571371200, sunriseTime: 1571397093, sunsetTime: 1571436783)
        
        let testConvertedTime = example.convertedTime
        let testConvertedSunriseTime = WeatherForecast.convertUNIXTimeToReadableTime(unixTime: example.sunriseTime)
        let testConvertedSunsetTime = WeatherForecast.convertUNIXTimeToReadableTime(unixTime: example.sunsetTime)
        
        XCTAssert(testConvertedTime == "2019-10-18", "\(testConvertedTime) does not match the expected date, '2019-10-18'")
        XCTAssert(testConvertedSunriseTime == "7:11 AM", "\(testConvertedSunriseTime) does not match the expected sunriseTime, 7:11 AM")
        XCTAssert(testConvertedSunsetTime == "6:13 PM", "\(testConvertedSunriseTime) does not match the expected sunsetTime, 6:13 AM")
    }
    
    func testDataExists() {
        
        DarkSkyAPIManager.shared.getForecast(lat: 40.7365115, long: -74.0093522, completionHandler: { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let weatherDataFromOnline):
                    self.weatherData = weatherDataFromOnline
                    XCTAssert(weatherDataFromOnline.isEmpty == false, "No data found")
                case .failure(_): ()
                }
            }
        })
    }
    
}


