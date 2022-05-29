//
//  TechShopsViewModel.swift
//  mvvm+rxSwift_sample
//
//  Created by Svitlana Korostelova on 15/05/2022.
//

import Combine
import Foundation

protocol TechShopsViewModelProtocol {
    func setShopsList(with elements: [Shop])
    var getShopsList: [Shop] { get }
    func fetchShops() -> Future<[Shop], Error> 
}

class TechShopsViewModel: TechShopsViewModelProtocol {
    private let techShopsService: TechShopsServiceProtocol!
    private var shops = [Shop]()
    
    init(techShopsService: TechShopsServiceProtocol) {
        self.techShopsService = techShopsService
    }
    
    var getShopsList: [Shop] {
        self.shops
    }
    
    func setShopsList(with elements: [Shop]) {
        shops.append(contentsOf: elements)
    }
    
    func fetchShops() -> Future<[Shop], Error> {
        techShopsService.fetchShopsFromAPI()
    }
}
