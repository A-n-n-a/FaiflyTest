//
//  CountryAndCities.swift
//  FaiflyTest
//
//  Created by Anna on 11.07.17.
//  Copyright © 2017 Anna. All rights reserved.
//

import Foundation

struct CountryAndCities {
    
    var countryName: String
    var citiesList: [String]
    
    init(countryName: String, citiesList: [String]) {
        self.countryName = countryName
        self.citiesList = citiesList
    }
}
