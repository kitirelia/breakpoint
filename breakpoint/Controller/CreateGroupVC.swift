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
    var choosenUserArray = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        emailSearchTxt.delegate = self
        emailSearchTxt.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        doneBtn.isHidden = true
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
        let profileImage = UIImage(named:"defaultProfileImage")
        if choosenUserArray.contains(emailArray[indexPath.row]){
            cell.configureCell(email:emailArray[indexPath.row], imageProfile: profileImage!, isSelected: true)
        }else{
            cell.configureCell(email:emailArray[indexPath.row], imageProfile: profileImage!, isSelected: false)
        }
        
        
        return cell
    }
    
}

extension CreateGroupVC:UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard  let cell = tableView.cellForRow(at: indexPath) as? UserCell else {return}
        if !choosenUserArray.contains(cell.emailLbl.text!){
            choosenUserArray.append(cell.emailLbl.text!)
            groupMemberLbl.text = choosenUserArray.joined(separator: ",")
            doneBtn.isHidden = false
        }else{
            choosenUserArray = choosenUserArray.filter({$0 != cell.emailLbl.text!})
            if choosenUserArray.count >= 1{
                groupMemberLbl.text = choosenUserArray.joined(separator: ",")
            }else{
                groupMemberLbl.text = "add people to your group"
                doneBtn.isHidden = true
            }
        }
    }
}

extension CreateGroupVC:UITextFieldDelegate{
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
}






















