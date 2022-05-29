//
//  LoginViewModel.swift
//  mvvm+rxSwift_sample
//
//  Created by Svitlana Korostelova on 10/05/2022.
//

import Foundation
import RxSwift
import RxCocoa

protocol LoginViewModelProtocol {
    func isValid() -> Observable<Bool>
    var nameSubject: BehaviorSubject<String> { get set }
    var passwordSubject: BehaviorSubject<String> { get set }
    var coordinator: Coordinator? { get set }
}

class LoginViewModel: LoginViewModelProtocol {
    var nameSubject = BehaviorSubject<String>(value: "")
    var passwordSubject = BehaviorSubject<String>(value: "")
    var coordinator: Coordinator?
    
    func isValid() -> Observable<Bool> {
        return Observable.combineLatest(nameSubject.asObservable(), passwordSubject.asObservable()).map { (name, password) in
            ValidationService.validatePassword(password: password) && name.count > 3
            
        }
    }

}
