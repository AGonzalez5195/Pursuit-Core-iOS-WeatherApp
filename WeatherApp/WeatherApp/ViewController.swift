//
//  ViewController.swift
//  WeatherApp
//
//  Created by David Rifkin on 10/8/19.
//  Copyright © 2019 David Rifkin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var weatherCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 200), collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.backgroundColor = .red
        
        let scrollDirection = UICollectionView.ScrollDirection.horizontal
        if let collectionViewFlowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            collectionViewFlowLayout.scrollDirection = scrollDirection
        }
        return collectionView
    }()
    
    
    private func setConstraints() {
        setCollectionViewConstraints()
    }
    
    private func setCollectionViewConstraints(){
        NSLayoutConstraint.activate([
            weatherCollectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            weatherCollectionView.widthAnchor.constraint(equalToConstant: weatherCollectionView.frame.width),
        weatherCollectionView.heightAnchor.constraint(equalToConstant: 200),
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
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setConstraints()
        view.backgroundColor = #colorLiteral(red: 1, green: 0.9833787084, blue: 0.8849565387, alpha: 1)
    }
}



