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
    
    var viewModel: MainViewModel?
    
    var firstCollectionView: UICollectionView?
    var productsCollectionView: UICollectionView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = MainViewModel()
        viewCodeSetup()
    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func setupCollectionView() {
        firstCollectionView?.register(FirstCollectionViewCell.self, forCellWithReuseIdentifier: FirstCollectionViewCell.cellid)
        productsCollectionView?.register(ProductsCollectionViewCell.self, forCellWithReuseIdentifier: ProductsCollectionViewCell.cellid)
        
        firstCollectionView?.delegate = self
        firstCollectionView?.dataSource = self
        productsCollectionView?.delegate = self
        productsCollectionView?.dataSource = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == firstCollectionView {
            return viewModel?.spotlightList.count ?? 0
        } else {
            return viewModel?.productsList.count ?? 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == firstCollectionView {
            let cell = firstCollectionView?.dequeueReusableCell(withReuseIdentifier: FirstCollectionViewCell.cellid, for: indexPath) as! FirstCollectionViewCell
            if let data = viewModel?.spotlightList[indexPath.item] {
                cell.setupCell(imageUrl: data)
            }
            return cell
        } else {
            let cell = productsCollectionView?.dequeueReusableCell(withReuseIdentifier: ProductsCollectionViewCell.cellid, for: indexPath) as! ProductsCollectionViewCell
            if let data = viewModel?.productsList[indexPath.item] {
                cell.setupCell(imageUrl: data)
            }
            return cell
        }

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

extension MainViewController: MainViewModelDelegate {
    func successList() {
        firstCollectionView?.reloadData()
        productsCollectionView?.reloadData()
    }
    
    func errorList(error: String) {
        firstCollectionView?.reloadData()
        productsCollectionView?.reloadData()
    }
    
    
}
