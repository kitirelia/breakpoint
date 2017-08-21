//
//  MessageCell.swift
//  breakpoint
//
//  Created by kitiwat chanluthin on 8/21/17.
//  Copyright © 2017 kitiwat chanluthin. All rights reserved.
//

import UIKit

class FeedCell: UITableViewCell {

    var content:String!
    var senderId:String!
    var imagePath:UIImage!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCell(content:String,senderId:String,image:UIImage){
        self.content = content
        self.senderId = senderId
        self.imagePath = image
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
