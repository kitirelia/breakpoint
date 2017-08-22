//
//  GroupFeedCell.swift
//  breakpoint
//
//  Created by kitiwat chanluthin on 8/22/17.
//  Copyright © 2017 kitiwat chanluthin. All rights reserved.
//

import UIKit

class GroupFeedCell: UITableViewCell {

    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var messageLbl: UILabel!
    @IBOutlet weak var imageProfile: UIImageView!
    
    func configureCell(profileImage:UIImage,email:String,content:String){
        self.userNameLbl.text = email
        self.messageLbl.text = content
        self.imageProfile.image = profileImage
    }
    
}
