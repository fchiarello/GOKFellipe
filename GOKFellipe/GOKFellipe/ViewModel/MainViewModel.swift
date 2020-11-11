//
//  MainViewModel.swift
//  GOKFellipe
//
//  Created by Fellipe Ricciardi Chiarello on 11/6/20.
//

import Foundation
import UIKit

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
        } onError: { (error) in
            self.delegate?.errorList(error: String(describing: error))
        }
    }
    
    func setupNavBar(navigationItem: UINavigationItem) {
        let logo = UIImage(named: Constants.digioLogo)
        let logoView = UIImageView(image: logo)
        
        logoView.contentMode = .scaleAspectFit
        navigationItem.titleView = logoView
    }
    
    func setupCashImage(url: Cash, cashView: UIImageView, cashLabel: UILabel) {
        if let cashImage = url.bannerUrl {
            do {
                let path = try Data(contentsOf: URL(string: cashImage)!)
                cashView.image = UIImage(data: path)
                cashView.layer.cornerRadius = 10
                cashView.layer.masksToBounds = false
                cashView.clipsToBounds = true
                cashView.contentMode = .scaleAspectFill
                
            } catch {
                print(error)
            }
            let txt = url.title
            let split = txt?.split(regex: " ")
            self.setupLabels(firstStr: split?.first ?? Constants.digio, secondStr: split?[1] ?? Constants.cash, label: cashLabel)
        }
    }
    
    func setupLabels(firstStr: String, secondStr: String, label: UILabel) {
        let string = NSMutableAttributedString()
        let attibutes1 = [NSAttributedString.Key(rawValue: NSAttributedString.Key.font.rawValue) : UIFont.boldSystemFont(ofSize: 17), NSAttributedString.Key(rawValue: NSAttributedString.Key.foregroundColor.rawValue) : UIColor(red: 44.0/255.0, green: 50.0/255.0, blue: 70.0/255.0, alpha: 1)]
        let attibutes2 = [NSAttributedString.Key(rawValue: NSAttributedString.Key.font.rawValue) : UIFont.boldSystemFont(ofSize: 17), NSAttributedString.Key(rawValue: NSAttributedString.Key.foregroundColor.rawValue) : UIColor.lightGray]
        
        string.append(NSAttributedString(string: firstStr, attributes: attibutes1))
        string.append(NSAttributedString(string: " \(secondStr)", attributes: attibutes2))
        label.attributedText = string
    }
}
