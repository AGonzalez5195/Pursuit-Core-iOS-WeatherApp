//
//  FavoritesViewController.swift
//  WeatherApp
//
//  Created by Anthony Gonzalez on 10/16/19.
//  Copyright © 2019 David Rifkin. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    lazy var photosCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 0), collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        let scrollDirection = UICollectionView.ScrollDirection.vertical
        if let collectionViewFlowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            collectionViewFlowLayout.scrollDirection = scrollDirection
            
            collectionView.dataSource = self
            collectionView.delegate = self
            collectionView.register(PixabayCollectionViewCell.self, forCellWithReuseIdentifier: "photoCell")
            self.view.addSubview(collectionView)
        }
        return collectionView
    }()
    
    private var savedPhotos = [PixabayPhoto]() {
        didSet {
            photosCollectionView.reloadData()
        }
    }
    
    private func loadData(){
        do {
            savedPhotos = try PixabayPhotoPersistenceHelper.manager.getPhoto().reversed()
        } catch {
            print(error)
        }
    }
    
    private func setCollectionViewConstraints(){
        NSLayoutConstraint.activate([
            photosCollectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            photosCollectionView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            photosCollectionView.widthAnchor.constraint(equalTo: view.widthAnchor),
            photosCollectionView.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadData()
        tabBarController?.tabBar.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        tabBarController?.tabBar.barTintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        tabBarController?.tabBar.barStyle = .default
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCollectionViewConstraints()
    }
}

extension FavoritesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return savedPhotos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let photoCell = photosCollectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as! PixabayCollectionViewCell
        
        let specificPhoto = savedPhotos[indexPath.row]
        photoCell.configureCell(from: specificPhoto)
        photoCell.favoriteButton.isHidden = true
        
        return photoCell
    }
}


extension FavoritesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 411  , height: 300)
    }
}
