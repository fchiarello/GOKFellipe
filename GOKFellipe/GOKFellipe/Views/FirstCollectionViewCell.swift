//
//  FirstCollectionViewCell.swift
//  GOKFellipe
//
//  Created by Fellipe Ricciardi Chiarello on 11/4/20.
//

import UIKit

class FirstCollectionViewCell: UICollectionViewCell {
    
    lazy var imageView: UIImageView = {
        let iv = UIImageView(frame: contentView.frame)
        iv.layer.cornerRadius = 10
        iv.translatesAutoresizingMaskIntoConstraints = true
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFill
        return iv
    } ()
    
    lazy var mainView: UIView = {
        return UIView()
    }()
    
    static let cellid = "FirstCollectionViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        viewCodeSetup()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCell(imageUrl: Spotlight) {
        if let imageString = imageUrl.bannerUrl {
            do {
                let path = try Data(contentsOf: URL(string: imageString)!)
                self.imageView.image = UIImage(data: path)
            } catch  {
                print(error)
                self.imageView.image = UIImage(named: Constants.error)
                self.imageView.alpha = 0.5            }
        }
    }
}

extension FirstCollectionViewCell: ViewCodeProtocol {
    func viewCodeHierarchySetup() {
        contentView.addSubview(mainView)
        mainView.addSubview(imageView)
    }

    func viewCodeConstraintSetup() {
        mainView.snp.makeConstraints { (mkr) in
            mkr.height.equalTo(160)
            mkr.width.equalTo(300)
            mkr.leading.equalTo(20)
            mkr.trailing.equalTo(contentView).offset(23)
            mkr.center.equalTo(contentView)
        }
        imageView.snp.makeConstraints { (mkr) in
            mkr.height.width.equalTo(mainView)
            mkr.center.equalTo(mainView)
        }
    }

    func viewCodeAditionalSetup() {
        self.mainView.setupShadow()
    }
}
