//
//  PostsTableViewController.swift
//  PostFetchingApp
//
//  Created by SKC on 9/30/19.
//  Copyright © 2019 SKC-PRO. All rights reserved.
//

import UIKit

class PostsTableViewController: UITableViewController {
    
    @IBOutlet var postsTableView: UITableView!
    typealias JSONDictionary = [String: Any]
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.dateStyle = .short
        return formatter
    }()
    var hitArray = [Hit]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchData()
    }
    
    // MARK: - Table view data source
    
    func fetchData() {
        hitArray = []
        let url = URL(string: "https://hn.algolia.com/api/v1/search_by_date?tags=story&page=1")
        
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            guard let data = data else { return }
            
            do {
                let fetchedArray = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves) as! JSONDictionary
                let hitsArray = fetchedArray["hits"] as! [JSONDictionary]
                
                for hit in hitsArray {
                    let title = hit["title"] as! String
                    let createdAt = hit["created_at"] as! String
                    let endOfDate = createdAt.firstIndex(of: "T")!
                    let date = createdAt[..<endOfDate]
                    let dateString = String(date)
                    
                    self.hitArray.append(Hit(createdAt: dateString, title: title))
                }
                DispatchQueue.main.async  {
                    self.navigationItem.title = "\(self.hitArray.count) posts"
                    self.postsTableView.reloadData()
                }
            } catch {
                print("Error in pasring")
            }
            }.resume()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hitArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = postsTableView.dequeueReusableCell(withIdentifier: "Cell") as! CustomCell
        let hit = hitArray[indexPath.row]
        cell.setCell(hit: hit)
        return cell
    }
}
