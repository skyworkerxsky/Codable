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
                    print("comments success")
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
                            // print(carArray)
                            // completion(carArray)
                        }
                    }
                    print("carArray success")
                } catch {
                    print(error)
                }
            }
            
        }.resume()
    }
    
    static func getRepos(url: String, completion: @escaping (_ repos: [GithubModel]) -> (), completion2: @escaping (([String: String]) -> ())) {
        guard let url = URL(string: url) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("token 0f65b3276bc987728b8be4ed4f45a22127194551", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if error != nil {
                print(error!)
                return
            }
            
            if response != nil {
                let httpResponse = response as! HTTPURLResponse
                let field = httpResponse.allHeaderFields["Link"] as? String
                guard let linkHeader = field else { return }
                let links = linkHeader.components(separatedBy: ",")
                
                var dictionary: [String: String] = [:]
                
                links.forEach({
                    let components = $0.components(separatedBy: "; ")
                    let cleanPath = components[0].trimmingCharacters(in: CharacterSet(charactersIn: "< >"))
                    dictionary[components[1]] = cleanPath
                })
                print(dictionary)
                completion2(dictionary)
            }
            
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let json = try decoder.decode([GithubModel].self, from: data)
                    //                    print(json)
                    completion(json)
                } catch  {
                    print(error)
                }
            }
            
        }.resume()
    }
    
    
    
}
