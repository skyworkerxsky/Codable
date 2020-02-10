//
//  ViewController.swift
//  Codable
//
//  Created by Алексей Макаров on 07.02.2020.
//  Copyright © 2020 Алексей Макаров. All rights reserved.
//

import UIKit

class ViewController: UIViewController  {
    
    // MARK: - Outlets
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    
    let carURL = "https://b2btest.ma.ru/MASP/MSV2/SIOKeyHst/KeyReadByCurrentUser"
    let jsonURL = "https://jsonplaceholder.typicode.com/users"
    let githubUrl = "https://api.github.com/repositories"
    
    private var data = [GithubModel]()
    private var nextLink: String?
    private var backLink: String?
    
    // MARK: - Outlets
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // get jsonplaceholder
        Network.getData(url: jsonURL) { (comments) in
            
        }
        
        // get car
        Network.getCar(url: carURL)
        
        // get repository
        Network.getRepos(url: githubUrl, completion: { (data) in
            self.data = data
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }) { (dictionary) in
            if let nextPagePath = dictionary["rel=\"next\""] {
                self.nextLink = nextPagePath
            }
        }
        
    }
    
    // MARK: - Actions
    
    @IBAction func nextButtonPress(_ sender: Any) {
        guard let next = nextLink else { return }
        Network.getRepos(url: next, completion: { (data) in
            self.data = data
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }) { (dictionary) in
            if let nextPagePath = dictionary["rel=\"next\""] {
                self.nextLink = nextPagePath
            }
        }
    }
    
    @IBAction func backButtonPress(_ sender: Any) {
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Table view data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = data[indexPath.row].name
        return cell
    }
}

