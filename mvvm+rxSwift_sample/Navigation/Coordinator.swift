//
//  Coordinator.swift
//  mvvm+rxSwift_sample
//
//  Created by Svitlana Korostelova on 06/05/2022.
//

import UIKit

class Coordinator {
    let window: UIWindow?
    var navController: UINavigationController?
    
    init(window: UIWindow?) {
        self.window = window
    }
    
    func start() {
        let viewModel = ShopsListViewModel()
        viewModel.coordinator = self
        let rootVC = MyViewController.instantiate(viewModel: viewModel)
        navController = UINavigationController(rootViewController: rootVC)
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
    }
    
    func goToLoginScreen() {
        let storyboard = UIStoryboard(name: "LogInStoryboard", bundle: .main)
        let viewController = storyboard.instantiateViewController(identifier: "LoginViewController") as! LoginViewController
        viewController.viewModel = LoginViewModel()
        viewController.viewModel.coordinator = self
        
        navController?.pushViewController(viewController, animated: true)
    }
    
    func goToTechShopsScreen() {
        let storyboard = UIStoryboard(name: "TechShopsStoryboard", bundle: .main)
        let viewController = storyboard.instantiateViewController(identifier: "TechShopsViewController") as! TechShopsViewController
        viewController.viewModel = TechShopsViewModel(techShopsService: TechShopsService.shared)
//        viewController.viewModel.coordinator = self
        navController?.pushViewController(viewController, animated: true)
    }
}
