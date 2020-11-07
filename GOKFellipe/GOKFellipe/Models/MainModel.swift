//
//  MainModel.swift
//  GOKFellipe
//
//  Created by Fellipe Ricciardi Chiarello on 11/6/20.
//

import Foundation

struct MainModel: Codable {
    var spotlight: [Spotlight]?
    var products: [Products]?
    var cash: Cash?
    
    enum CodingKeys: String, CodingKey {
        case spotlight = "spotlight"
        case products = "products"
        case cash = "cash"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        spotlight = try values.decodeIfPresent([Spotlight].self, forKey: .spotlight)
        products = try values.decodeIfPresent([Products].self, forKey: .products)
        cash = try values.decodeIfPresent(Cash.self, forKey: .cash)
    }
}
