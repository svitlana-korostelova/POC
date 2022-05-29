//
//  ValidationService.swift
//  mvvm+rxSwift_sample
//
//  Created by Svitlana Korostelova on 15/05/2022.
//

import Foundation

enum ValidationService {
    
    static func validatePassword(password: String) -> Bool {
            let passRegEx = "(?=[^a-z]*[a-z])(?=[^0-9]*[0-9])[a-zA-Z0-9!@#$%^&*]{8,}"
            let passwordTest = NSPredicate(format: "SELF MATCHES %@", passRegEx)
            return passwordTest.evaluate(with: password)
    }
    
}
