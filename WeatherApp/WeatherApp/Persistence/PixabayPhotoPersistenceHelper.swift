//
//  PixabayPhotoPersistenceHelper.swift
//  WeatherApp
//
//  Created by Anthony Gonzalez on 10/16/19.
//  Copyright © 2019 David Rifkin. All rights reserved.
//

import Foundation

struct PixabayPhotoPersistenceHelper {
    static let manager = PixabayPhotoPersistenceHelper()
    
    func save(newPhoto: PixabayPhoto) throws {
        try persistenceHelper.save(newElement: newPhoto)
    }
    
    func getPhoto() throws -> [PixabayPhoto] {
        return try persistenceHelper.getObjects()
    }
    
    private let persistenceHelper = PersistenceHelper<PixabayPhoto>(fileName: "myPhotos.plist")
    
    private init() {}
}

