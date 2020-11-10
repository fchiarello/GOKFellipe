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
        setupNavBar()
        setupCollectionView()
        viewModel?.delegate = self
        viewModel?.fetchCollection()
    }
    
    func setupNavBar() {
        let logo = UIImage(named: Constants.digioLogo)
        let logoView = UIImageView(image: logo)
        
        logoView.contentMode = .scaleAspectFit
        self.navigationItem.titleView = logoView
    }
    
    func getNavBarHeight() -> CGFloat {
        let height = navigationController?.navigationBar.frame.height ?? 50.0 + 16.0
        
        return height
    }
    
    func setupCashImage(url: Cash) {
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
            self.setupCashLabel(firstStr: split?.first ?? Constants.digio, secondStr: split?[1] ?? Constants.cash)
        }
    }
    
    func setupCashLabel(firstStr: String, secondStr: String) {
        let string = NSMutableAttributedString()
        let attibutes1 = [NSAttributedString.Key(rawValue: NSAttributedString.Key.font.rawValue) : UIFont.boldSystemFont(ofSize: 17), NSAttributedString.Key(rawValue: NSAttributedString.Key.foregroundColor.rawValue) : UIColor(red: 44.0/255.0, green: 50.0/255.0, blue: 70.0/255.0, alpha: 1)]
        let attibutes2 = [NSAttributedString.Key(rawValue: NSAttributedString.Key.font.rawValue) : UIFont.boldSystemFont(ofSize: 17), NSAttributedString.Key(rawValue: NSAttributedString.Key.foregroundColor.rawValue) : UIColor.lightGray]
        
        string.append(NSAttributedString(string: firstStr, attributes: attibutes1))
        string.append(NSAttributedString(string: " \(secondStr)", attributes: attibutes2))
        self.cashLabel.attributedText = string
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
            mkr.topMargin.equalToSuperview().offset(getNavBarHeight())
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
        productsLabel.font = UIFont.systemFont(ofSize: 15)
        productsLabel.text = "PRODUCTS TEXT!!!"
    }
    
}

extension MainViewController: MainViewModelDelegate {
    func successList() {
        DispatchQueue.main.async {
            self.firstCollectionView.reloadData()
            self.productsCollectionView.reloadData()
            if let url = self.viewModel?.cash {
                self.setupCashImage(url: url)
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
