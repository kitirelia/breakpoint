//
//  UserCell.swift
//  breakpoint
//
//  Created by kitiwat chanluthin on 8/21/17.
//  Copyright © 2017 kitiwat chanluthin. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {

    @IBOutlet weak var imageProfile: UIImageView!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var checkMarkBtn: UIImageView!
    
    
    func configureCell(email:String,imageProfile:UIImage,isSelected:Bool){
        self.imageProfile.image = imageProfile
        self.emailLbl.text = email
        self.checkMarkBtn.isHidden = !isSelected
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

}
