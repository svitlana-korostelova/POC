//
//  TechShopsViewController.swift
//  mvvm+rxSwift_sample
//
//  Created by Svitlana Korostelova on 14/05/2022.
//

import Combine
import UIKit

class TechShopsViewController: UIViewController {

    @IBOutlet private var tableView: UITableView!
    var viewModel: TechShopsViewModelProtocol!
    var observers = [AnyCancellable]()
    let action = PassthroughSubject<String, Never>()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.fetchShops()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("finished")
                case .failure(let error):
                    print(error)
                }
            }, receiveValue: { [weak self] shops in
                self?.viewModel.setShopsList(with: shops)
                self?.tableView.reloadData()
            }).store(in: &observers)
        
        action.sink { string in
            print(string)
        }.store(in: &observers)
    }

}

extension TechShopsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.getShopsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "shopsCell")!
        var texts = [String]()
        viewModel.getShopsList.forEach({ shop in
            texts.append(shop.fullDescription)
        })
        var content = cell.defaultContentConfiguration()
        content.text = texts[indexPath.row]
        cell.contentConfiguration = content
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        action.send("cell" + "\(indexPath.row)" + "tapped")
    }
    
}
