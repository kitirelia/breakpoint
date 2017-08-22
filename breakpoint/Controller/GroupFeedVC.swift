//
//  GroupFeddVC.swift
//  breakpoint
//
//  Created by kitiwat chanluthin on 8/22/17.
//  Copyright © 2017 kitiwat chanluthin. All rights reserved.
//

import UIKit
import Firebase

class GroupFeedVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var groupTitleLbl: UILabel!
    @IBOutlet weak var membersLbl: UILabel!
    @IBOutlet weak var sendBtnView: UIView!
    @IBOutlet weak var messageTxt: insetTextField!
    @IBOutlet weak var sendBtn: UIButton!
    
    var groupMessages = [Message]()
    var group:Group?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        groupTitleLbl.text = group?.groupTitle
        DataService.instance.getEmailsFor(group: group!) { (returnEmailArray) in
            self.membersLbl.text = returnEmailArray.joined(separator: ",")
        }
        
        DataService.instance.REF_GROUPS.observe(.value) { (snapshot) in
            DataService.instance.getAllMessagesFor(desiredGroup: self.group!, handler: { (returnGroupMessages) in
               self.groupMessages  = returnGroupMessages
                self.tableView.reloadData()
                
                if self.groupMessages.count > 0{
                    self.tableView.scrollToRow(at: IndexPath.init(row: self.groupMessages.count - 1, section: 0), at: .none, animated: true)
                }
            })
        }
        
    }
    
    func initGroupData(group:Group){
        self.group = group
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        sendBtnView.bindToKeyboard()
    }

    @IBAction func backBtnPressed(_ sender: Any) {
       // dismiss(animated: true, completion: nil)
        dismissDetail()
    }
    @IBAction func sendBtnPressed(_ sender: Any) {
        guard  messageTxt.text != "" else {return}
        messageTxt.isEnabled = false
        sendBtn.isEnabled = false
        DataService.instance.uploadPost(withMessage: messageTxt.text!, forUID: Auth.auth().currentUser!.uid, withGroupKey: group?.key) { (success) in
            if success{
                self.messageTxt.text = ""
                self.messageTxt.isEnabled = true
                self.sendBtn.isEnabled = true
            }
        }
    }
    
}

extension GroupFeedVC:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupMessages.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "groupFeedCell", for: indexPath) as? GroupFeedCell else{return UITableViewCell()}
        let image = UIImage(named:"defaultProfileImage")
        let message = groupMessages[indexPath.row]
        DataService.instance.getUsername(forUID: message.senderId) { (email) in
                cell.configureCell(profileImage: image!, email: email, content: message.content)
        }
        return cell
    }
    
}
