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
        collectionView.backgroundColor = .red
        
        let scrollDirection = UICollectionView.ScrollDirection.horizontal
        if let collectionViewFlowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            collectionViewFlowLayout.scrollDirection = scrollDirection
            
            collectionView.dataSource = self
            collectionView.delegate = self
            collectionView.register(WeatherCollectionViewCell.self, forCellWithReuseIdentifier: "weatherCell")
        }
        
        return collectionView
    }()
    
    var weatherData = [WeatherForecast]() {
        didSet {
            weatherCollectionView.reloadData()
        }
    }
    
    private func setConstraints() {
        setCollectionViewConstraints()
    }
    
    private func setCollectionViewConstraints(){
        NSLayoutConstraint.activate([
            weatherCollectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 170),
            weatherCollectionView.widthAnchor.constraint(equalToConstant: weatherCollectionView.frame.width),
            weatherCollectionView.heightAnchor.constraint(equalToConstant: 155),
            weatherCollectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    
    private func addSubviews(){
        [weatherCollectionView].forEach{$0.translatesAutoresizingMaskIntoConstraints = false}
        
        let UIElements = [weatherCollectionView]
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
