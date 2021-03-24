//
//  SourcesModel.swift
//  News App
//
//  Created by Recep Bayraktar on 22.03.2021.
//

import Foundation

// MARK: - Sources
struct Origins: Codable {
    let status: String?
    var sources: [Origin]
}

// MARK: - Source
struct Origin: Codable {
    let id: String?
    let name: String?
    let description: String?
    let url: String?
    let category: String?
    let language: String?
    let country: String?
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String?.self, forKey: .id)
        name = try container.decode(String?.self, forKey: .name)
        description = try container.decode(String?.self, forKey: .description)
        url = try container.decode(String?.self, forKey: .url)
        category = try container.decode(String?.self, forKey: .category)
        language = try container.decode(String?.self, forKey: .language)
        country = try container.decode(String?.self, forKey: .country)
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case url
        case category
        case language
        case country
    }
}
