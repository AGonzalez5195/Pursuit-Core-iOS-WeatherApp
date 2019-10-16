//
//  DetailViewController.swift
//  WeatherApp
//
//  Created by Anthony Gonzalez on 10/15/19.
//  Copyright © 2019 David Rifkin. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    lazy var lowTemperatureLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .center
        return label
    }()
    
    lazy var highTemperatureLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .center
        return label
    }()
    
    lazy var sunriseLabel: UILabel = {
           let label = UILabel()
           label.font = UIFont.systemFont(ofSize: 16)
           label.textAlignment = .center
           return label
       }()
    
    lazy var sunsetLabel: UILabel = {
           let label = UILabel()
           label.font = UIFont.systemFont(ofSize: 16)
           label.textAlignment = .center
           return label
       }()
    
    lazy var labelStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [sunriseLabel, sunsetLabel, lowTemperatureLabel, highTemperatureLabel])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.spacing = 2
        return stackView
    }()
    var currentForecast: WeatherForecast!
    
    private func configureUI() {
        view.backgroundColor = #colorLiteral(red: 1, green: 0.9833787084, blue: 0.8849565387, alpha: 1)
        sunriseLabel.text = "Sunrise: \(WeatherForecast.convertUNIXTimeToReadableTime(unixTime: currentForecast.sunriseTime))"
        
        sunsetLabel.text = "Sunset: \(WeatherForecast.convertUNIXTimeToReadableTime(unixTime: currentForecast.sunsetTime))"
        
        highTemperatureLabel.text = "High: \(currentForecast.temperatureHigh.roundTo(places: 1))°F"
        lowTemperatureLabel.text = "Low: \(currentForecast.temperatureLow.roundTo(places: 1))°F"
    }
    
    private func configureStackView() {
        NSLayoutConstraint.activate([
            labelStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            labelStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            labelStackView.widthAnchor.constraint(equalToConstant: 160),
            labelStackView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    private func setConstraints() {
        configureStackView()
    }
    
    private func addSubViews() {
        [labelStackView].forEach{$0.translatesAutoresizingMaskIntoConstraints = false}
        
        let UIElements = [labelStackView]
        for UIElement in UIElements {
            self.view.addSubview(UIElement)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        addSubViews()
        setConstraints()
        
        
    }
    
}
