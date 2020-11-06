//
//  ViewCodeProtocol.swift
//  GOKFellipe
//
//  Created by Fellipe Ricciardi Chiarello on 11/5/20.
//

import Foundation

protocol ViewCodeProtocol: class {
    func viewCodeSetup()
    func viewCodeHierarchySetup()
    func viewCodeConstraintSetup()
    func viewCodeAditionalSetup()
}

extension ViewCodeProtocol {
    func viewCodeSetup() {
        viewCodeHierarchySetup()
        viewCodeConstraintSetup()
        viewCodeAditionalSetup()
    }
    
    func viewCodeHierarchySetup() {}
    
    func viewCodeConstraintSetup() {}
    
    func viewCodeAditionalSetup() {}
}
