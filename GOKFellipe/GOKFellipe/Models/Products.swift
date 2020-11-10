//
//  Products.swift
//  GOKFellipe
//
//  Created by Fellipe Ricciardi Chiarello on 11/6/20.
//

import Foundation

struct Products: Codable {
    var name: String?
    var imageUrl: String?
    var description: String?
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case imageUrl = "imageURL"
        case description = "description"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        imageUrl = try values.decodeIfPresent(String.self, forKey: .imageUrl)
        description = try values.decodeIfPresent(String.self, forKey: .description)
    }
}
