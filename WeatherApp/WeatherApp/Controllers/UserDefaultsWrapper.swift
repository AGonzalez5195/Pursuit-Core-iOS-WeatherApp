//
//  UserDefaultsWrapper.swift
//  WeatherApp
//
//  Created by Anthony Gonzalez on 10/16/19.
//  Copyright © 2019 David Rifkin. All rights reserved.
//

import Foundation

class UserDefaultsWrapper {
    
    static let shared = UserDefaultsWrapper()
    
    private let zipCodeKey = "zipCodeKey"
    
    func store(zipCode: String) { UserDefaults.standard.set(zipCode, forKey: zipCodeKey) }
    

    func getZipCode() -> String? { return UserDefaults.standard.value(forKey: zipCodeKey) as? String }
    
}
