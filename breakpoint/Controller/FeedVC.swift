//
//  FirstViewController.swift
//  breakpoint
//
//  Created by kitiwat chanluthin on 8/21/17.
//  Copyright © 2017 kitiwat chanluthin. All rights reserved.
//

import UIKit

class FeedVC: UIViewController {
    var messageArray:[Message] = [Message]()
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DataService.instance.getAllFeedMessages { (fireBaseMessages) in
            self.messageArray = fireBaseMessages
            self.tableView.reloadData()
        }
    }
    
}

// MARK: Tableview DataSource
extension FeedVC:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "feedCell", for: indexPath) as? FeedCell else{ return UITableViewCell()}
        
        let image = UIImage(named:"defaultProfileImage")
        let content = messageArray[indexPath.row].content
        let senderId = messageArray[indexPath.row].senderId
        cell.configureCell(content: content, senderId: senderId, image: image!)
        
        return cell
    }
    
}
extension FeedVC:UITableViewDelegate{
    
}

