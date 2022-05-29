//
//  ShopsListViewModel.swift
//  mvvm+rxSwift_sample
//
//  Created by Svitlana Korostelova on 07/05/2022.
//

import Foundation
import RxSwift

protocol ShopsListViewModelProtocol {
    var title: String { get }
    var coordinator: Coordinator? { get set }
    func fetchShopViewModels() -> Observable<[ShopViewModel]>
}

final class ShopsListViewModel: ShopsListViewModelProtocol {
    let title = "Shops"
    private let shopsService: ShopsServiceProtocol
    var coordinator: Coordinator?
    
    init(shopsService: ShopsServiceProtocol = ShopsService()) {
        self.shopsService = shopsService
    }
    
    func fetchShopViewModels() -> Observable<[ShopViewModel]> {
        shopsService.fetchShops().map{$0.map{ShopViewModel(shop: $0)}}
    }
}
