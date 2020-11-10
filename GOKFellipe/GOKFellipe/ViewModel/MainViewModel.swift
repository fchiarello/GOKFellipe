//
//  MainViewModel.swift
//  GOKFellipe
//
//  Created by Fellipe Ricciardi Chiarello on 11/6/20.
//

import Foundation

protocol MainViewModelProtocol: AnyObject {
    func fetchCollection()
}

protocol MainViewModelDelegate {
    func successList()
    func errorList(error: String)
}

class MainViewModel: MainViewModelProtocol {
    var delegate: MainViewModelDelegate?
    var spotlightList: [Spotlight] = []
    var productsList: [Products] = []
    var cash: Cash?
    
    
    func fetchCollection() {
        Service.loadList(url: Constants.url) { (list) in
            self.spotlightList += list.spotlight ?? []
            self.productsList += list.products ?? []
            self.cash  = list.cash
            self.delegate?.successList()
            print(self.cash)
        } onError: { (error) in
            self.delegate?.errorList(error: String(describing: error))
        }
    }
}
