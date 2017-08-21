//
//  CreateGroupVC.swift
//  breakpoint
//
//  Created by kitiwat chanluthin on 8/21/17.
//  Copyright © 2017 kitiwat chanluthin. All rights reserved.
//

import UIKit

class CreateGroupVC: UIViewController {

    @IBOutlet weak var titleTxt: insetTextField!
    @IBOutlet weak var descriptionTxt: insetTextField!
    @IBOutlet weak var emailSearchTxt: insetTextField!
    @IBOutlet weak var doneBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var groupMemberLbl: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }

    
    @IBAction func closeBtnPressed(_ sender: Any) {
    }
    
    @IBAction func doneBtnPressed(_ sender: Any) {
    }
}

extension CreateGroupVC:UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "userCell",for:indexPath) as? UserCell else {
            return UITableViewCell()
        }
        
        let profileImage = UIImage(named:"defaultProfileImage")
        
        cell.configureCell(email: "marty@gmail.com", imageProfile: profileImage!, isSelected: true)
        
        return cell
    }
    
}
extension CreateGroupVC:UITableViewDelegate{
    
}
