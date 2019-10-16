//
//  PixabayPhoto.swift
//  WeatherApp
//
//  Created by Anthony Gonzalez on 10/16/19.
//  Copyright © 2019 David Rifkin. All rights reserved.
//

import Foundation

struct PixabayWrapper: Codable {
    let hits: [PixabayPhoto]
}


// MARK: - PixabayPhoto
struct PixabayPhoto: Codable {
    let largeImageURL: String
}
