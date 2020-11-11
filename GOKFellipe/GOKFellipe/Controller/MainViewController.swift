//
//  MainViewController.swift
//  GOKFellipe
//
//  Created by Fellipe Ricciardi Chiarello on 11/4/20.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {
    lazy var cashLabel: UILabel = {
        return UILabel()
    }()
    
    lazy var cashView: UIImageView = {
        let iv = UIImageView()
        return iv
    }()
    
    lazy var productsLabel: UILabel = {
        return UILabel()
    }()
    
    lazy var firstCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let spotlightView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        spotlightView.backgroundColor = .none
        spotlightView.layer.cornerRadius = 10
        spotlightView.translatesAutoresizingMaskIntoConstraints = true
       return spotlightView
    }()
    
    lazy var productsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let productsView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        productsView.backgroundColor = .none
        productsView.layer.cornerRadius = 10
        productsView.translatesAutoresizingMaskIntoConstraints = true
        return productsView
    }()
    
    var viewModel: MainViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = MainViewModel()
        viewCodeSetup()
        setupCollectionView()
        viewModel?.delegate = self
        viewModel?.fetchCollection()
    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func setupCollectionView() {
        firstCollectionView.register(FirstCollectionViewCell.self, forCellWithReuseIdentifier: FirstCollectionViewCell.cellid)
        productsCollectionView.register(ProductsCollectionViewCell.self, forCellWithReuseIdentifier: ProductsCollectionViewCell.cellid)
        
        firstCollectionView.delegate = self
        firstCollectionView.dataSource = self
        productsCollectionView.delegate = self
        productsCollectionView.dataSource = self
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
            let cell = firstCollectionView.dequeueReusableCell(withReuseIdentifier: FirstCollectionViewCell.cellid, for: indexPath) as! FirstCollectionViewCell
            if let data = viewModel?.spotlightList[indexPath.item] {
                cell.setupCell(imageUrl: data)
                firstCollectionView.showsHorizontalScrollIndicator = true
            }
            return cell
        } else {
            let cell = productsCollectionView.dequeueReusableCell(withReuseIdentifier: ProductsCollectionViewCell.cellid, for: indexPath) as! ProductsCollectionViewCell
            if let data = viewModel?.productsList[indexPath.item] {
                cell.setupCell(imageUrl: data)
            }
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == firstCollectionView {
            return CGSize(width: 300, height: collectionView.frame.size.height)
        } else {
            return CGSize(width: collectionView.frame.size.height, height: collectionView.frame.size.height)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == firstCollectionView {
            return 1
        } else {
            return 1
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == firstCollectionView {
            return 20
        } else {
            return 20
        }
    }
}

extension MainViewController: ViewCodeProtocol {
    func viewCodeHierarchySetup() {
        view.addSubview(firstCollectionView)
        view.addSubview(cashLabel)
        view.addSubview(cashView)
        view.addSubview(productsLabel)
        view.addSubview(productsCollectionView)
    }
    
    func viewCodeConstraintSetup() {
        self.firstCollectionView.snp.makeConstraints { (mkr) in
            mkr.height.equalTo(160)
            mkr.width.equalTo(300)
            mkr.topMargin.equalToSuperview().offset(50)
            mkr.trailing.leading.equalTo(16)
        }
        
        self.cashLabel.snp.makeConstraints { (mkr) in
            mkr.top.equalTo(firstCollectionView.snp.bottom).offset(40)
            mkr.leading.trailing.equalTo(16)
        }
        
        self.cashView.snp.makeConstraints { (mkr) in
            mkr.top.equalTo(cashLabel.snp.bottom).offset(10)
            mkr.height.equalTo(100)
            mkr.leading.equalTo(16)
            mkr.trailing.equalTo(-16)
        }
        
        self.productsLabel.snp.makeConstraints { (mkr) in
            mkr.top.equalTo(cashView.snp.bottom).offset(40)
            mkr.leading.trailing.equalTo(16)
        }
        
        self.productsCollectionView.snp.makeConstraints { (mkr) in
            mkr.height.width.equalTo(110)
            mkr.top.equalTo(productsLabel.snp.bottom).offset(20)
            mkr.leading.trailing.equalTo(16)
        }
    }
    
    func viewCodeAditionalSetup() {
        view.backgroundColor = .white
        self.viewModel?.setupLabels(firstStr: Constants.products, secondStr: String(), label: self.productsLabel)
        self.viewModel?.setupNavBar(navigationItem: self.navigationItem)
    }
    
}

extension MainViewController: MainViewModelDelegate {
    func successList() {
        DispatchQueue.main.async {
            self.firstCollectionView.reloadData()
            self.productsCollectionView.reloadData()
            if let url = self.viewModel?.cash {
                self.viewModel?.setupCashImage(url: url, cashView: self.cashView, cashLabel: self.cashLabel)
            }
        }
    }
    
    func errorList(error: String) {
        DispatchQueue.main.async {
            self.firstCollectionView.reloadData()
            self.productsCollectionView.reloadData()
        }
    }
}
