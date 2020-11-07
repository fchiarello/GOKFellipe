//
//  UIView+Extension.swift
//  GOKFellipe
//
//  Created by Fellipe Ricciardi Chiarello on 11/7/20.
//

import UIKit

extension UIView {
    func setupShadow() {
        layer.cornerRadius = 10
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowRadius = 10
        layer.shadowOpacity = 0.1
    }
}
