//
//  Shop.swift
//  mvvm+rxSwift_sample
//
//  Created by Svitlana Korostelova on 06/05/2022.
//

import Foundation

struct Shop: Decodable {
    var name: String
    var country: Country
    
    var fullDescription: String {
        name + " -> " + country.rawValue.capitalized
    }
}

enum Country: String, Decodable {
    case poland
    case italy
    case spain
    case unitedStates
    case taiwan
}

