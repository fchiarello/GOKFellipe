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
        case bannerUrl = "bannerUrl"
        case description = "description"
    }
}
