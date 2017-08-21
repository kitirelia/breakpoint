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

    }

    
    @IBAction func closeBtnPressed(_ sender: Any) {
    }
    
    @IBAction func doneBtnPressed(_ sender: Any) {
    }
}
