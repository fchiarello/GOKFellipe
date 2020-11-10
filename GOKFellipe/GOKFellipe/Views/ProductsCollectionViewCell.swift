//
//  ProductsCollectionViewCell.swift
//  GOKFellipe
//
//  Created by Fellipe Ricciardi Chiarello on 11/4/20.
//

import UIKit

class ProductsCollectionViewCell: UICollectionViewCell {
    
    lazy var imageView: UIImageView = {
        let iv = UIImageView(frame: contentView.frame)
        iv.layer.cornerRadius = 10
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        return iv
    } ()
    
    lazy var mainView: UIView = {
        return UIView()
    }()
    
    static let cellid = "ProductsCollectionViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        viewCodeSetup()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCell(imageUrl: Products) {
        if let imageString = imageUrl.imageUrl {
            do {
                let path = try Data(contentsOf: URL(string: imageString)!)
                self.imageView.image = UIImage(data: path)
            } catch {
                print(error)
                self.imageView.image = UIImage(named: Constants.error)
                self.imageView.alpha = 0.5
            }
        }
    }
}

extension ProductsCollectionViewCell: ViewCodeProtocol {
    func viewCodeHierarchySetup() {
        contentView.addSubview(mainView)
        mainView.addSubview(imageView)
    }
    
    func viewCodeConstraintSetup() {
        mainView.snp.makeConstraints { (mkr) in
            mkr.height.width.equalTo(100)
            mkr.center.equalTo(contentView)
        }
        imageView.snp.makeConstraints { (mkr) in
            mkr.height.width.equalTo(mainView).offset(-40)
            mkr.center.equalTo(mainView)
        }
    }
    
    func viewCodeAditionalSetup() {
        self.mainView.setupShadow()
        self.mainView.backgroundColor = .white
    }
}
