//
//  CommentModel.swift
//  Codable
//
//  Created by Алексей Макаров on 07.02.2020.
//  Copyright © 2020 Алексей Макаров. All rights reserved.
//

import Foundation

// структура для "https://jsonplaceholder.typicode.com/users"

struct CommentModel: Decodable {
    let id: Int
    let name: String
    let username: String
    let email: String
    let address: Address
    let phone: String
    let website: String
    let company: Company
}

struct Company: Decodable {
    let name: String
    let catchPhrase: String
    let bs: String
    
    enum CodingKeys: String, CodingKey { // меняем ключи если не совпадают имена
        case name
        case catchPhrase
        case bs
        // case name = "NaMe"
        // case catchPhrase = "caTchPhrase"
    }
    
}

struct Address: Decodable {
    let street:  String
    let suite:  String
    let city:  String
    let zipcode:  String
    let geo: Geo
}

struct Geo: Decodable {
    let lat:  String
    let lng:  String
}
