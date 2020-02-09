//
//  GithubHeadersModel.swift
//  Codable
//
//  Created by Алексей Макаров on 08.02.2020.
//  Copyright © 2020 Алексей Макаров. All rights reserved.
//

import Foundation

struct GithubHeadersModel {
    let server: String
    
    enum CodingKeys: String, CodingKey {
        case server = "Server"
    }
}
