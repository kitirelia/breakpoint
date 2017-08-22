//
//  SecondViewController.swift
//  breakpoint
//
//  Created by kitiwat chanluthin on 8/21/17.
//  Copyright © 2017 kitiwat chanluthin. All rights reserved.
//

import UIKit

class GroupsVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var groupArray = [Group]()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DataService.instance.REF_GROUPS.observe(.value, with: { (snapshot) in
            DataService.instance.getAllGroups { (returnGroup) in
                self.groupArray = returnGroup
                self.tableView.reloadData()
            }
        })
    }
   
}

extension GroupsVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "groupCell", for: indexPath) as? GroupCell else {return UITableViewCell()}
        cell.configureCell(title: groupArray[indexPath.row].groupTitle, description: groupArray[indexPath.row].groupDescription, memberCount: groupArray[indexPath.row].member.count)
        return cell
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupArray.count
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let groupFeedVC = storyboard?.instantiateViewController(withIdentifier: "GroupFeedVC") as? GroupFeedVC else{return}
        groupFeedVC.initGroupData(group: groupArray[indexPath.row])
        present(groupFeedVC, animated: true, completion: nil)
       
    }
    
    
    
    
    
    
    
    
    
    
    
    
}
