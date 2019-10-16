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
    
    lazy var favoriteButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.8013431079)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(button)
        button.setTitle("Save", for: .normal)
        button.setTitleColor(.purple, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.showsTouchWhenHighlighted = true
        button.addTarget(self, action: #selector(favoriteButtonPressed(sender:)), for: .touchUpInside)
        return button
    }()
    
    var buttonFunction: (()->())?
    
    @objc func favoriteButtonPressed(sender: UIButton) {
        if let closure = buttonFunction {
            closure()
        }
    }
    
    private func setConstraints(){
        NSLayoutConstraint.activate([
            locationImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            locationImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            locationImageView.widthAnchor.constraint(equalTo: self.widthAnchor),
            locationImageView.heightAnchor.constraint(equalTo: self.heightAnchor),
            
            favoriteButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -30),
            favoriteButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            favoriteButton.widthAnchor.constraint(equalToConstant: 60),
            favoriteButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    
    
    func configureCell(from photo: PixabayPhoto) {
        ImageHelper.shared.getImage(urlStr: photo.largeImageURL) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    self.locationImageView.image = #imageLiteral(resourceName: "sunny")
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
