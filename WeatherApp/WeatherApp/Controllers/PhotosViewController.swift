//
//  PhotosViewController.swift
//  WeatherApp
//
//  Created by Anthony Gonzalez on 10/16/19.
//  Copyright © 2019 David Rifkin. All rights reserved.
//

import UIKit

class PhotosViewController: UIViewController {
    
    
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
    
    var photos = [PixabayPhoto]() {
        didSet {
            photosCollectionView.reloadData()
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
    
    private func presentAlert() {
        let alertVC = UIAlertController(title: nil, message: "Photo saved", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
    
    private func savePhoto(specificPhoto: PixabayPhoto){
        let favoritedPhoto = PixabayPhoto(largeImageURL: specificPhoto.largeImageURL)
        do {
            try? PixabayPhotoPersistenceHelper.manager.save(newPhoto: favoritedPhoto)
        }
    }
    
    override var prefersStatusBarHidden: Bool {
           return true
       }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.backgroundColor = .black
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.barTintColor = .black
        
        tabBarController?.tabBar.backgroundColor = .black
        tabBarController?.tabBar.barStyle = .black
        tabBarController?.tabBar.barTintColor = .black
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        setCollectionViewConstraints()
        navigationController?.navigationBar.backgroundColor = .black
        navigationController?.navigationBar.barStyle = .black
    }
}

extension PhotosViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let photoCell = photosCollectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as! PixabayCollectionViewCell
        
        let specificPhoto = photos[indexPath.row]
        photoCell.configureCell(from: specificPhoto)
        photoCell.buttonFunction = { self.savePhoto(specificPhoto: specificPhoto); self.presentAlert() }
        photoCell.deleteButton.isHidden = true
        return photoCell
    }
}


extension PhotosViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 411  , height: 300)
    }
}
