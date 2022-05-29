//
//  LogInViewController.swift
//  mvvm+rxSwift_sample
//
//  Created by Svitlana Korostelova on 10/05/2022.
//

import UIKit
import RxSwift
import RxCocoa
import LocalAuthentication

class LoginViewController: UIViewController {
    var viewModel: LoginViewModelProtocol!
    private let disposeBag = DisposeBag()
    
    @IBOutlet private var signInBtn: UIButton!
    @IBOutlet private var nameTF: UITextField!
    @IBOutlet private var passwordTF: UITextField!
    
    @IBAction private func tappedLogIn(_ sender: UIButton) {
        viewModel.coordinator?.goToTechShopsScreen()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkBiometric()
        configureUI()
        nameTF.rx.text.map { $0 ?? ""}.bind(to: viewModel.nameSubject).disposed(by: disposeBag)
        passwordTF.rx.text.map { $0 ?? ""}.bind(to: viewModel.passwordSubject).disposed(by: disposeBag)
        viewModel.isValid().bind(to: signInBtn.rx.isEnabled).disposed(by: disposeBag)
        viewModel.isValid().map({$0 ? 1 : 0.5 }).bind(to: signInBtn.rx.alpha).disposed(by: disposeBag)
    }

    private func configureUI() {
        signInBtn.setTitleColor(.black, for: .normal)
        nameTF.becomeFirstResponder()
    }
    private func checkBiometric() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Identify yourself!"
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) {
                [weak self] success, authenticationError in
                
                DispatchQueue.main.async {
                    if success {
                      self?.viewModel.coordinator?.goToTechShopsScreen()
                        
                    } else {
                        ToastMessages.shared.show(message: .loadingError("We don't indentify your person. Please try to fill username and password."))
                    }
                }
            }
        } else {
            let alertVC = UIAlertController(title: "Biometry unavailable", message: "Your device is not configured for biometric authentication. Please try to fill username and password.", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alertVC, animated: true)
        }
    }
}
