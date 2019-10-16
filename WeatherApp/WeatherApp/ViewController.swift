//
//  ViewController.swift
//  WeatherApp
//
//  Created by David Rifkin on 10/8/19.
//  Copyright © 2019 David Rifkin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    //MARK: --Properties
    lazy var weatherCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 0), collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        let scrollDirection = UICollectionView.ScrollDirection.horizontal
        if let collectionViewFlowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            collectionViewFlowLayout.scrollDirection = scrollDirection
            
            collectionView.dataSource = self
            collectionView.delegate = self
            collectionView.register(WeatherCollectionViewCell.self, forCellWithReuseIdentifier: "weatherCell")
        }
        
        return collectionView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Weather Forecast For _____"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    lazy var zipCodeTextField: UITextField = {
       let textView = UITextField()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.placeholder = "Enter Zipcode..."
        textView.borderStyle = .line
        textView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        textView.delegate = self
        return textView
    }()
    
    var weatherData = [WeatherForecast]() {
        didSet {
            weatherCollectionView.reloadData()
        }
    }
    
    private func setConstraints() {
        setCollectionViewConstraints()
        setTitleLabelConstraints()
        setTextFieldConstraints()
        
    }
    
    private func setCollectionViewConstraints() {
        NSLayoutConstraint.activate([
            weatherCollectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 170),
               weatherCollectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            weatherCollectionView.widthAnchor.constraint(equalToConstant: weatherCollectionView.frame.width),
            weatherCollectionView.heightAnchor.constraint(equalToConstant: 155)
        ])
    }
    
    private func setTitleLabelConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 95),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.widthAnchor.constraint(equalToConstant: 300),
            titleLabel.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
    
    private func setTextFieldConstraints() {
        NSLayoutConstraint.activate([
            zipCodeTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            zipCodeTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -60),
            zipCodeTextField.widthAnchor.constraint(equalToConstant: 140),
            zipCodeTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func addSubviews(){
        let UIElements = [weatherCollectionView, titleLabel, zipCodeTextField]
        for UIElement in UIElements {
            view.addSubview(UIElement)
        }
    }
    
    private func loadData() {
        DarkSkyAPIManager.shared.getElements(completionHandler: { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let weatherDataFromOnline):
                    self.weatherData = weatherDataFromOnline
                    
                case .failure(let error):
                    print(error)
                }
            }
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setConstraints()
        loadData()
        view.backgroundColor = #colorLiteral(red: 1, green: 0.9833787084, blue: 0.8849565387, alpha: 1)
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weatherData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let specificWeatherForecast = weatherData[indexPath.row]
        let weatherCell = weatherCollectionView.dequeueReusableCell(withReuseIdentifier: "weatherCell", for: indexPath) as! WeatherCollectionViewCell
        
        weatherCell.configureCell(from: specificWeatherForecast)
        
        return weatherCell
        
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150  , height: 150)
    }
}
