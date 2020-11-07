//
//  ProductsCollectionViewCell.swift
//  GOKFellipe
//
//  Created by Fellipe Ricciardi Chiarello on 11/4/20.
//

import UIKit

class ProductsCollectionViewCell: UICollectionViewCell {
    
    lazy var imageView: UIImageView = {
        return UIImageView()
    } ()
    
    static let cellid = "ProductsCollectionViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        viewCodeSetup()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCell(imageUrl: Products) {
        imageView.image = UIImage(named: imageUrl.imageUrl ?? String())
    }
}

extension ProductsCollectionViewCell: ViewCodeProtocol {
    func viewCodeHierarchySetup() {
        contentView.addSubview(imageView)
    }
    
    func viewCodeConstraintSetup() {
        imageView.snp.makeConstraints { (mkr) in
            mkr.center.equalToSuperview()
            mkr.bottom.top.trailing.leading.equalToSuperview()
        }
    }
    
    func viewCodeAditionalSetup() {
        self.setupShadow()
    }
}
