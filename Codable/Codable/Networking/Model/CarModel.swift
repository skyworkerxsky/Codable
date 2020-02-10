//
//  CarModel.swift
//  Codable
//
//  Created by Алексей Макаров on 07.02.2020.
//  Copyright © 2020 Алексей Макаров. All rights reserved.
//

import Foundation

// MARK: - CarModel
struct CarModel: Decodable {
    let date: String
    let car: Car
    
    enum CodingKeys: String, CodingKey { // меняем ключи если не совпадают имена
        case date = "Date"
        case car = "Car"
    }
}

// MARK: - Car
struct Car: Decodable {
    let color: Color
    let vin: String
    let lastRegNo: String
    let model: Model
    let brand: Brand
    let oid: Int
    
    enum CodingKeys: String, CodingKey {
        case color = "Color"
        case vin = "Vin"
        case lastRegNo = "LastRegNo"
        case model = "Model"
        case brand = "Brand"
        case oid = "OID"
    }
}

// MARK: - Color
struct Color: Decodable {
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case name = "Name"
    }
}

// MARK: - Model
struct Model: Decodable {
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case name = "Name"
    }
}

// MARK: - Brand
struct Brand: Decodable {
    let name: String
    let urlLogotip: String
    
    enum CodingKeys: String, CodingKey {
        case name = "Name"
        case urlLogotip
    }
}

