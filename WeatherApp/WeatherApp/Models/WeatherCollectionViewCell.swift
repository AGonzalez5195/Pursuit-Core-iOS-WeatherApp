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
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        
        return label
    }()
    
    lazy var lowTemperatureLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .center
        return label
    }()
    
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    lazy var weatherImage: UIImageView = {
       let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private func addSubviews(){
        
        let UIElements = [highTemperatureLabel, lowTemperatureLabel, dateLabel, weatherImage]
        
        for UIElement in UIElements {
            addSubview(UIElement)
        }
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            highTemperatureLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            highTemperatureLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            highTemperatureLabel.widthAnchor.constraint(equalToConstant: 150),
            highTemperatureLabel.heightAnchor.constraint(equalToConstant: 50),
            
            lowTemperatureLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 10 ),
            lowTemperatureLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            lowTemperatureLabel.widthAnchor.constraint(equalToConstant: 150),
            lowTemperatureLabel.heightAnchor.constraint(equalToConstant: 50),
            
            dateLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: -10),
            dateLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            dateLabel.widthAnchor.constraint(equalToConstant: 150),
            dateLabel.heightAnchor.constraint(equalToConstant: 50),
            
            weatherImage.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -10),
            weatherImage.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            weatherImage.widthAnchor.constraint(equalToConstant: 70),
            weatherImage.heightAnchor.constraint(equalToConstant: 70)
        ])
    }
    
    func configureCell(from weather: WeatherForecast) {
        backgroundColor = .clear
        highTemperatureLabel.text = "High: \(weather.temperatureHigh.roundTo(places: 1))"
        lowTemperatureLabel.text = "Low: \(weather.temperatureLow.roundTo(places: 1))"
        dateLabel.text = weather.convertedTime
        [highTemperatureLabel, lowTemperatureLabel, dateLabel].forEach{$0.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)}
        weatherImage.image = UIImage(named: "\(weather.icon)")
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


extension Double {
    func roundTo(places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
