//
//  MainViewController.swift
//  GOKFellipe
//
//  Created by Fellipe Ricciardi Chiarello on 11/4/20.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {

    lazy var helloLabel: UILabel = {
        return UILabel()
    }()
    
    lazy var cashLabel: UILabel = {
        return UILabel()
    }()
    
    lazy var cashImage: UIView = {
        return UIView()
    }()
    
    lazy var productsLabel: UILabel = {
        return UILabel()
    }()
    
    var firstCollectionView: UICollectionView?
    var productsCollectionView: UICollectionView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewCodeSetup()
    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = firstCollectionView?.dequeueReusableCell(withReuseIdentifier: FirstCollectionViewCell.cellid, for: indexPath) as! FirstCollectionViewCell
        return cell
    }
}

extension MainViewController: ViewCodeProtocol {
    func viewCodeHierarchySetup() {
        view.addSubview(helloLabel)
//        view.addSubview(firstCollectionView!)
        view.addSubview(cashLabel)
        view.addSubview(cashImage)
        view.addSubview(productsLabel)
//        view.addSubview(productsCollectionView!)
    }
    
    func viewCodeConstraintSetup() {
        helloLabel.snp.makeConstraints { (mkr) in
            mkr.top.equalTo(100)
            mkr.leading.trailing.equalTo(16)
        }
    }
    
    func viewCodeAditionalSetup() {
        view.backgroundColor = .white
        helloLabel.font = UIFont.systemFont(ofSize: 35)
        helloLabel.text = "HELLO TEXT!!!"
        helloLabel.textAlignment = .left
        
        cashLabel.font = UIFont.systemFont(ofSize: 35)
        cashLabel.text = "CASH TEXT!!!"
        
        productsLabel.font = UIFont.systemFont(ofSize: 35)
        productsLabel.text = "PRODUCTS TEXT!!!"
    }
}
