//
//  ComputerModel.swift
//  Codable
//
//  Created by Алексей Макаров on 04.03.2020.
//  Copyright © 2020 Алексей Макаров. All rights reserved.
//

import Foundation

struct ComputerModel: Decodable {
    let items: [Computer]
    let page: Int?
    let offset: Int?
    let total: Int?
}

struct Computer: Decodable {
    let id: Int?
    let name: String?
    let company: CompanyComputer?
}

struct CompanyComputer: Decodable {
    let id: Int?
    let name: String?
}
