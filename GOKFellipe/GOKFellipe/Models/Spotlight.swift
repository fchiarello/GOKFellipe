//
//  Spotlight.swift
//  GOKFellipe
//
//  Created by Fellipe Ricciardi Chiarello on 11/6/20.
//

import Foundation

struct Spotlight: Codable {
    var name: String?
    var bannerUrl: String?
    var description: String?
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case bannerUrl = "bannerURL"
        case description = "description"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        bannerUrl = try values.decodeIfPresent(String.self, forKey: .bannerUrl)
        description = try values.decodeIfPresent(String.self, forKey: .description)
    }
}
