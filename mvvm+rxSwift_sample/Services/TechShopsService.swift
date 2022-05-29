//
//  TechShopsService.swift
//  mvvm+rxSwift_sample
//
//  Created by Svitlana Korostelova on 15/05/2022.
//

import Combine
import Foundation

protocol TechShopsServiceProtocol {
    func fetchShopsFromAPI() -> Future<[Shop], Error>
}

class TechShopsService: TechShopsServiceProtocol {
    static let shared = TechShopsService()
    
    func fetchShopsFromAPI() -> Future<[Shop], Error> {
        return Future { promise in
            DispatchQueue.main.asyncAfter(deadline: .now()+2) {
                promise(.success([Shop(name: "Apple", country: .unitedStates), Shop(name: "Amazon", country: .unitedStates), Shop(name: "Asus", country: .taiwan)]))
            }
        }
    }
}
