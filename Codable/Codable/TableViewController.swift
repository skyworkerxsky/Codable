//
//  ViewController.swift
//  Codable
//
//  Created by Алексей Макаров on 07.02.2020.
//  Copyright © 2020 Алексей Макаров. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController  {

    // MARK: - Properties
    
    let carURL = "https://b2btest.ma.ru/MASP/MSV2/SIOKeyHst/KeyReadByCurrentUser"
    let jsonURL = "https://jsonplaceholder.typicode.com/users"
    let githubUrl = "https://api.github.com/repositories"
    
    private var comments = [CommentModel]()
    
    // MARK: - Outlets
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // get jsonplaceholder
        Network.getData(url: jsonURL) { (comments) in
            self.comments = comments
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        // get car
        Network.getCar(url: carURL)
        
        // get repository
        Network.getRepos(url: githubUrl)
        
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = comments[indexPath.row].name
        return cell
    }
    

}

