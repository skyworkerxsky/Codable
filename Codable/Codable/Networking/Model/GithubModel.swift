//
//  GithubModel.swift
//  Codable
//
//  Created by Алексей Макаров on 08.02.2020.
//  Copyright © 2020 Алексей Макаров. All rights reserved.
//

import Foundation

struct GithubModel: Decodable {
    let id: Int
    let name: String
    let owner : Owner
}

struct Owner: Decodable {
    let login: String
    let htmlUrl: String
}
