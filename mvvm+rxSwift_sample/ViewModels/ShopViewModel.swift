//
//  ShopViewModel.swift
//  mvvm+rxSwift_sample
//
//  Created by Svitlana Korostelova on 07/05/2022.
//

import Foundation

struct ShopViewModel {
    private let shop: Shop
    
    var displayText: String {
        shop.fullDescription
    }
    
    init(shop: Shop) {
        self.shop = shop
    }
}
