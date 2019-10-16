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
    
    lazy var windSpeedLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .center
        return label
    }()
    
    lazy var precipitationLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .center
        return label
    }()
    
    lazy var labelStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [sunriseLabel, sunsetLabel, lowTemperatureLabel, highTemperatureLabel, windSpeedLabel, precipitationLabel])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.spacing = 7
        return stackView
    }()
    
    lazy var locationImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .clear
        imageView.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.imageTapped(_:)))
        imageView.addGestureRecognizer(tapGesture)
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.textAlignment = .center
        return label
    }()
    
    lazy var saveButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(self.saveButtonPressed))
       
        
        return button
    }()
    
    
    var locationName = String() {
        didSet {
            titleLabel.text = "Weather Forecast For \(locationName) for \(currentForecast.convertedTime)"
        }
    }
    
    var currentForecast: WeatherForecast!
    
    var photos = [PixabayPhoto]()
      
    var presentedPhoto = PixabayPhoto(largeImageURL: "") {
        didSet {
            loadImage()
        }
    }
    
    
    @objc func saveButtonPressed() {
        let favoritedPhoto = PixabayPhoto(largeImageURL: presentedPhoto.largeImageURL)
        do {
            try? PixabayPhotoPersistenceHelper.manager.save(newPhoto: favoritedPhoto)
        }
        presentAlert()
    }
    
    
    @objc func imageTapped(_ sender: UITapGestureRecognizer? = nil) {
        
        let photosVC = PhotosViewController()
        photosVC.photos = photos
        
        self.navigationController?
            .pushViewController(photosVC, animated: true)
    }
    
    
    private func loadPixabayData(){
        let searchQuery = locationName.replacingOccurrences(of: " ", with: "+")
        PixabayAPIManager.shared.getPhotos(searchQuery: searchQuery, completionHandler: {
            (result) in
            switch result {
            case .success(let pixabayPhotoData):
                self.photos = pixabayPhotoData
                self.presentedPhoto = self.photos.randomElement()!
            case .failure(_): ()
            }
        })
    }
    
    private func loadImage() {
        if photos.isEmpty == true {
            locationImageView.image = UIImage(named: "\(currentForecast.icon)")
            locationImageView.isUserInteractionEnabled = false
            
        } else {
            ImageHelper.shared.getImage(urlStr: presentedPhoto.largeImageURL) { (result) in
                DispatchQueue.main.async {
                    switch result {
                    case .failure(let error):
                        print(error)
                    case .success(let imageFromOnline):
                        
                        self.locationImageView.image = imageFromOnline
                        
                    }
                }
            }
        }
    }
    
    private func presentAlert() {
          let alertVC = UIAlertController(title: nil, message: "Photo saved", preferredStyle: .alert)
          alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
          present(alertVC, animated: true, completion: nil)
      }
    
    
    private func configureUI() {
        view.backgroundColor = #colorLiteral(red: 1, green: 0.9833787084, blue: 0.8849565387, alpha: 1)
        sunriseLabel.text = "Sunrise: \(WeatherForecast.convertUNIXTimeToReadableTime(unixTime: currentForecast.sunriseTime))"
        
        sunsetLabel.text = "Sunset: \(WeatherForecast.convertUNIXTimeToReadableTime(unixTime: currentForecast.sunsetTime))"
        
        highTemperatureLabel.text = "High: \(currentForecast.temperatureHigh.roundTo(places: 1))°F"
        lowTemperatureLabel.text = "Low: \(currentForecast.temperatureLow.roundTo(places: 1))°F"
        
        windSpeedLabel.text = "Windspeed: \(currentForecast.windSpeed) MPH"
        precipitationLabel.text = "Inches of Precipitation: \(currentForecast.precipIntensityMax)"
    }
    
    private func configureStackView() {
        NSLayoutConstraint.activate([
            labelStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            labelStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            labelStackView.widthAnchor.constraint(equalToConstant: 300),
            labelStackView.heightAnchor.constraint(equalToConstant: 140)
        ])
    }
    
    private func configureImageView() {
        NSLayoutConstraint.activate([
            locationImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            locationImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            locationImageView.widthAnchor.constraint(equalTo: view.widthAnchor),
            locationImageView.heightAnchor.constraint(equalToConstant: 400)
            
        ])
    }
    
    private func configureTitleLabelConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            titleLabel.widthAnchor.constraint(equalTo: view.widthAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    private func setConstraints() {
        configureStackView()
        configureImageView()
        configureTitleLabelConstraints()
    }
    
    private func addSubViews() {
        [labelStackView, locationImageView, titleLabel].forEach{$0.translatesAutoresizingMaskIntoConstraints = false}
        
        let UIElements = [labelStackView, locationImageView, titleLabel]
        for UIElement in UIElements {
            self.view.addSubview(UIElement)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 1, green: 0.9833787084, blue: 0.8849565387, alpha: 1)
        navigationController?.navigationBar.backgroundColor = #colorLiteral(red: 1, green: 0.9833787084, blue: 0.8849565387, alpha: 1)
        navigationController?.navigationBar.barStyle = .default
        
        tabBarController?.tabBar.backgroundColor = #colorLiteral(red: 1, green: 0.9833787084, blue: 0.8849565387, alpha: 1)
        tabBarController?.tabBar.barTintColor = #colorLiteral(red: 1, green: 0.9833787084, blue: 0.8849565387, alpha: 1)
        tabBarController?.tabBar.barStyle = .default
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        addSubViews()
        setConstraints()
        loadPixabayData()
         self.navigationItem.rightBarButtonItem = saveButton
    }
}
