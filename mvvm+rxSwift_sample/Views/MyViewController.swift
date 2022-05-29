//
//  MyViewController.swift
//  mvvm+rxSwift_sample
//
//  Created by Svitlana Korostelova on 06/05/2022.
//

import UIKit
import RxSwift
import RxCocoa

class MyViewController: UIViewController {
    private let disposeBag = DisposeBag()
    private var viewModel: ShopsListViewModelProtocol!
    
    @IBOutlet private var goToLogin: UIButton!
    @IBOutlet private var tableView: UITableView!
    
    static func instantiate(viewModel: ShopsListViewModel) -> MyViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let viewController = storyboard.instantiateInitialViewController() as! MyViewController
        viewController.viewModel = viewModel
        return viewController
    }

    @IBAction func goToLogin(_ sender: UIButton) {
        viewModel.coordinator?.goToLoginScreen()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
//        let instance = Some() //reference is let, we can't set it with other one, but the rules for auto
//        instance.auto = "BMW" //cant let if struct
//        print(instance.auto)
//
//
        let value = "This is a test"
//        value.filter { $0 != " "}.count
//        var count = 0
//        var newValue = value.filter { char in
//            char == " "
//        }
//        let result = value.count - newValue.count
//        value.forEach { element in
//            count += 1
//        }
////        print(count)
////        print(value.count)
//        print(result)
//

        var countOfLetters = [Character : Int]()
        value.filter { $0 != " "}.forEach { character in
            if var charCount = countOfLetters[character], charCount > 0 {
                countOfLetters[character]! += 1
            } else {
                countOfLetters[character] = 1
            }
            
        }
        print(countOfLetters)
        
        
        
        
        viewModel.fetchShopViewModels()
            .observe(on: MainScheduler.instance)
            .bind(to: tableView.rx.items(cellIdentifier: "cell")) { index, viewModel, cell in
            cell.textLabel?.text = viewModel.displayText
        }.disposed(by: disposeBag)
    }
    
    private func configureUI() {
        goToLogin.setTitleColor(.black, for: .normal)
        goToLogin.titleLabel?.textAlignment = .center
        tableView.tableFooterView = UIView()
        navigationItem.title = viewModel.title
        navigationController?.navigationBar.prefersLargeTitles = true
        tableView.contentInsetAdjustmentBehavior = .never
    }
    
}


//class Some {
//    var auto = "Kia"
//}
