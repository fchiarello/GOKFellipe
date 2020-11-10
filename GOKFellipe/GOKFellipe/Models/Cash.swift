//
//  Cash.swift
//  GOKFellipe
//
//  Created by Fellipe Ricciardi Chiarello on 11/6/20.
//

import Foundation

struct Cash: Codable {
    var title: String?
    var bannerUrl: String?
    var description: String?
    
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case bannerUrl = "bannerURL"
        case description = "description"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        bannerUrl = try values.decodeIfPresent(String.self, forKey: .bannerUrl)
        description = try values.decodeIfPresent(String.self, forKey: .description)
    }
}
