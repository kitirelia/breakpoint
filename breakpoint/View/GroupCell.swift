//
//  GroupCell.swift
//  breakpoint
//
//  Created by kitiwat chanluthin on 8/22/17.
//  Copyright © 2017 kitiwat chanluthin. All rights reserved.
//

import UIKit

class GroupCell: UITableViewCell {

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var memberCoutLbl: UILabel!
    
    func configureCell(title:String,description:String,memberCount:Int){
        self.titleLbl.text = title
        self.descriptionLbl.text = description
        self.memberCoutLbl.text = "\(memberCount) members"
    }

}
