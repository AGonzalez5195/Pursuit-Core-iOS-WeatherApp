//
//  WeatherCollectionViewCell.swift
//  WeatherApp
//
//  Created by Anthony Gonzalez on 10/15/19.
//  Copyright © 2019 David Rifkin. All rights reserved.
//

import UIKit

class WeatherCollectionViewCell: UICollectionViewCell {
    
    lazy var highTemperatureLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        
        return label
    }()
    
    lazy var lowTemperatureLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    private func addSubviews(){
        backgroundColor = #colorLiteral(red: 1, green: 0.9782751203, blue: 0.9735108018, alpha: 1)
        
        let UIElements = [highTemperatureLabel, lowTemperatureLabel]
        
        for UIElement in UIElements {
            addSubview(UIElement)
        }
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            highTemperatureLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 30),
            highTemperatureLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            highTemperatureLabel.widthAnchor.constraint(equalToConstant: 150),
            highTemperatureLabel.heightAnchor.constraint(equalToConstant: 50),
            
            lowTemperatureLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -30 ),
            lowTemperatureLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            lowTemperatureLabel.widthAnchor.constraint(equalToConstant: 150),
            lowTemperatureLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func configureCell(from weather: WeatherForecast) {
        highTemperatureLabel.text = "High: \(weather.temperatureHigh)"
        lowTemperatureLabel.text = "Low: \(weather.temperatureLow)"
        [highTemperatureLabel, lowTemperatureLabel].forEach{$0.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)}
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
