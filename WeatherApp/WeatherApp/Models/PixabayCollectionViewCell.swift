//
//  PixabayCollectionViewCell.swift
//  WeatherApp
//
//  Created by Anthony Gonzalez on 10/16/19.
//  Copyright © 2019 David Rifkin. All rights reserved.
//

import UIKit

class PixabayCollectionViewCell: UICollectionViewCell {
    
    lazy var locationImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(imageView)
        return imageView
    }()
    
    private func setConstraints(){
        NSLayoutConstraint.activate([
            locationImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            locationImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            locationImageView.widthAnchor.constraint(equalTo: self.widthAnchor),
            locationImageView.heightAnchor.constraint(equalTo: self.heightAnchor)
        ])
    }
    
    func configureCell(from photo: PixabayPhoto) {
        ImageHelper.shared.getImage(urlStr: photo.largeImageURL) { (result) in
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
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
