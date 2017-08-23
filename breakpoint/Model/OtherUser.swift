//
//  OtherUser.swift
//  breakpoint
//
//  Created by kitiwat chanluthin on 8/23/17.
//  Copyright © 2017 kitiwat chanluthin. All rights reserved.
//

import UIKit

class OtherUser {
    public private(set) var email:String
    public private(set) var id:String
    public private(set) var imagePath:String
    var profilePicture:UIImage?
    
    init(email:String,id:String,path:String,image:UIImage){
        self.email = email
        self.id = id
        self.imagePath = path
       self.profilePicture = nil
    }
    func updateImage(image:UIImage){
        profilePicture = image
    }
}
