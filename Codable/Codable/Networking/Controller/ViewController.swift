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
    let githubURL = "https://api.github.com/repositories"
    let githubSearchURL = "https://api.github.com/search/repositories?q=page&s=updated"
    
    private var data = [GithubModel]()
    private var nextLink: String?
    private var prevLink: String?
    
    // MARK: - Outlets
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backButton.isEnabled = false
        
        /*
        // get jsonplaceholder
        Network.getData(url: jsonURL) { (comments) in
            
        }
        
        // get car
        // Network.getCar(url: carURL)
        
        // get repository
        Network.getRepos(url: githubURL, completion: { (data) in
            
        }) { (dictionary) in
            
        }
        */
        
        // get search repository
        Network.getSearchRepos(url: githubSearchURL, completion: { (data) in
            self.data = data
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }) { (headerLinks) in
            if let nextPagePath = headerLinks["rel=\"next\""] {
                self.nextLink = nextPagePath
                DispatchQueue.main.async {
                    self.nextButton.isEnabled = true
                }
            }
            
            if let prevPage = headerLinks["rel=\"prev\""] {
                DispatchQueue.main.async {
                    self.backButton.isEnabled = true
                }
                self.prevLink = prevPage
            }
        }
        
    }
    
    // MARK: - Actions
    
    @IBAction func nextButtonPress(_ sender: Any) {
        guard let next = nextLink else { return }
        Network.getSearchRepos(url: next, completion: { (data) in
            self.data = data
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }) { (headerLinks) in
            if let nextPagePath = headerLinks["rel=\"next\""] {
                DispatchQueue.main.async {
                    self.nextButton.isEnabled = true
                }
                self.nextLink = nextPagePath
            } else {
                DispatchQueue.main.async {
                    self.nextButton.isEnabled = false
                }
            }
            
            if let prevPage = headerLinks["rel=\"prev\""] {
                DispatchQueue.main.async {
                    self.backButton.isEnabled = true
                }
                self.prevLink = prevPage
            } else {
                DispatchQueue.main.async {
                    self.backButton.isEnabled = false
                }
            }
        }
    }
    
    @IBAction func backButtonPress(_ sender: Any) {
        guard let prev = prevLink else { return }
        Network.getSearchRepos(url: prev, completion: { (data) in
            self.data = data
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }) { (headerLinks) in
            if let nextPagePath = headerLinks["rel=\"next\""] {
                DispatchQueue.main.async {
                    self.nextButton.isEnabled = true
                }
                self.nextLink = nextPagePath
            } else {
                DispatchQueue.main.async {
                    self.nextButton.isEnabled = false
                }
            }
            
            if let prevPage = headerLinks["rel=\"prev\""] {
                DispatchQueue.main.async {
                    self.backButton.isEnabled = true
                }
                self.prevLink = prevPage
            } else {
                DispatchQueue.main.async {
                    self.backButton.isEnabled = false
                }
            }
        }
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
