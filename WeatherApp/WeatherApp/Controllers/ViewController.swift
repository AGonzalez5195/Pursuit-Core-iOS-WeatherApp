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
        label.text = "Weather Forecast"
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
    
    private var weatherData = [WeatherForecast]() {
        didSet {
            weatherCollectionView.reloadData()
        }
    }
    
    private var zipCode: String? {
        didSet {
            loadLatLongNameFromZip()
            weatherCollectionView.isHidden = false
        }
    }
    
    private var locationName : String? {
        didSet{
            titleLabel.text = "Weekly Forecast For \(locationName ?? "BlahBlah")"
        }
    }
    
    private var latitude: Double?
    private var longitude: Double?
    
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
        DarkSkyAPIManager.shared.getForecast(lat: latitude ?? 98765, long: longitude ?? 98765, completionHandler: { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let weatherDataFromOnline):
                    self.weatherData = weatherDataFromOnline
                    
                case .failure(_): ()
                }
            }
        })
    }
    
    private func loadLatLongNameFromZip(){
        ZipCodeHelper.getLatLongAndName(fromZipCode: zipCode!, completionHandler: { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let zipData):
                    self.locationName = zipData.name
                    self.longitude = zipData.long
                    self.latitude = zipData.lat
                    self.loadData()
                    
                case .failure(_): ()
                }
            }
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 1, green: 0.9833787084, blue: 0.8849565387, alpha: 1)
        navigationController?.navigationBar.backgroundColor = #colorLiteral(red: 1, green: 0.9833787084, blue: 0.8849565387, alpha: 1)
        navigationController?.navigationBar.barStyle = .default
        
        tabBarController?.tabBar.backgroundColor = #colorLiteral(red: 1, green: 0.9833787084, blue: 0.8849565387, alpha: 1)
        tabBarController?.tabBar.barStyle = .default
        tabBarController?.tabBar.barTintColor = #colorLiteral(red: 1, green: 0.9833787084, blue: 0.8849565387, alpha: 1)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 1, green: 0.9833787084, blue: 0.8849565387, alpha: 1)
        addSubviews()
        setConstraints()
        loadData()
        
        guard let savedZipCode = UserDefaultsWrapper.shared.getZipCode() else {
            weatherCollectionView.isHidden = true
            return }
        zipCode = savedZipCode
        zipCodeTextField.text = savedZipCode
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

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let detailVC = DetailViewController()
        let selectedForecast = weatherData[indexPath.row]
        detailVC.currentForecast = selectedForecast
        detailVC.locationName = locationName!
        
        self.navigationController?
            .pushViewController(detailVC, animated: true)
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150  , height: 150)
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        zipCode = textField.text
        if let zip = zipCode {
            UserDefaultsWrapper.shared.store(zipCode: zip)
        }
        textField.resignFirstResponder()
        return true
    }
}
