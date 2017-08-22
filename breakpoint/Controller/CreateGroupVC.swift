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
    var emailArray = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        emailSearchTxt.delegate = self
        emailSearchTxt.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }

    @objc func textFieldDidChange(){
        if emailSearchTxt.text == ""{
            emailArray = []
            tableView.reloadData()
        }else{
            DataService.instance.getEmail(forSeachQuery: emailSearchTxt.text!, handler: { (returnemailArray) in
                self.emailArray = returnemailArray
                self.tableView.reloadData()
            })
        }
    }
    
    @IBAction func closeBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func doneBtnPressed(_ sender: Any) {
    }
}

extension CreateGroupVC:UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return emailArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "userCell",for:indexPath) as? UserCell else {
            return UITableViewCell()
        }
        
        //let user = emailArray[indexPath.row]
        let profileImage = UIImage(named:"defaultProfileImage")
        
        cell.configureCell(email:emailArray[indexPath.row], imageProfile: profileImage!, isSelected: true)
        
        return cell
    }
    
}

extension CreateGroupVC:UITableViewDelegate{
    
}

extension CreateGroupVC:UITextFieldDelegate{
//    func textFieldDidEndEditing(_ textField: UITextField) {
//        guard  emailSearchTxt.text != nil, emailSearchTxt.text != "" else {return}
//        DataService.instance.getEmail(forSeachQuery: query) { (<#[String]#>) in
//            <#code#>
//        }
//    }
}






















