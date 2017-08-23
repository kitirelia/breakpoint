//
//  RoundImage.swift
//  breakpoint
//
//  Created by kitiwat chanluthin on 8/23/17.
//  Copyright © 2017 kitiwat chanluthin. All rights reserved.
//

import UIKit

class RoundImage: UIImageView {

    override func awakeFromNib() {
        setupView()
    }
    
    func setupView(){
        self.layer.cornerRadius = self.frame.width/2
        self.clipsToBounds = true
    }
}
