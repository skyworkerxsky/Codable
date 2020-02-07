//
//  Network.swift
//  Codable
//
//  Created by Алексей Макаров on 07.02.2020.
//  Copyright © 2020 Алексей Макаров. All rights reserved.
//

import Foundation

class Network {
    
    static func getData(url: String, completion: @escaping (_ data: [CommentModel]) -> ()){
        
        guard let url = URL(string: url) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if error != nil {
                print(error!)
                return
            }
            
            if let data = data {
                do {
                    let comments = try JSONDecoder().decode([CommentModel].self, from: data) // раскладываем в нашу модель
                    //                print(comments)
                    completion(comments)
                } catch {
                    print(error)
                }
            }
            
        }.resume()
    }
    
    static func getCar(url: String) { // , completion: @escaping (_ data: [CarModel]) -> ()
        
        guard let url = URL(string: url) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer F93238439F6AD7419485C1421FDBC956", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if error != nil {
                print(error!)
                return
            }
            
            if let data = data {
                do {
                    if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any],
                    let data = json["data"] as? [[String:Any]] {
                        for item in data {
                            let jsonData = try JSONSerialization.data(withJSONObject: item)
                            let carArray = try JSONDecoder().decode(CarModel.self, from: jsonData) // раскладываем в нашу модель
                            print(carArray)
                            // completion(carArray)
                        }
                    }
                } catch {
                    print(error)
                }
            }
            
        }.resume()
    }
    
}
