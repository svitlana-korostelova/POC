//
//  ShopsService.swift
//  mvvm+rxSwift_sample
//
//  Created by Svitlana Korostelova on 06/05/2022.
//

import Foundation
import RxSwift

protocol ShopsServiceProtocol {
    func fetchShops() -> Observable<[Shop]>
}

class ShopsService: ShopsServiceProtocol {
    func fetchShops() -> Observable<[Shop]> {
        return Observable.create { observer in
            guard let path = Bundle.main.path(forResource: "shops", ofType: "json") else {
                observer.onError(NSError(domain: "", code: -1))
                return Disposables.create {}
        }
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let shops = try JSONDecoder().decode([Shop].self, from: data)
                observer.onNext(shops)
            } catch {
                observer.onError(error)
            }
            return Disposables.create {}
        }
                
    }
}
