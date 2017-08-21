//
//  MessageCell.swift
//  breakpoint
//
//  Created by kitiwat chanluthin on 8/21/17.
//  Copyright © 2017 kitiwat chanluthin. All rights reserved.
//

import UIKit

class FeedCell: UITableViewCell {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var contentLbl: UILabel!

    func configureCell(content:String,senderId:String,image:UIImage){
        self.contentLbl.text = content
        self.emailLbl.text = senderId
        self.profileImage.image = image
    }
    
  

}
