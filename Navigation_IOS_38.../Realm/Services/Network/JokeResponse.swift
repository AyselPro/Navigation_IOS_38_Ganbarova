//
//  JokeResponse.swift
//  Navigation_IOS_38...
//
//  Created by Aysel on 30.12.2023.
//

import Foundation

struct JokeResponse: Decodable {
    let id: String
    let value: String
    let createdAt: String
    let categories: [String]
    
    enum CodingKeys: String, CodingKey {
        case id
        case value
        case categories
        case createdAt = "created_at"
    }
}
