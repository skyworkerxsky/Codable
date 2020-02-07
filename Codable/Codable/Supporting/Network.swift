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
            
            do {
                let comments = try JSONDecoder().decode([CommentModel].self, from: data!) // раскладываем в нашу модель
                print(comments)
                completion(comments)
            } catch {
                print(error)
            }
            
        }.resume()
    }
    
}
