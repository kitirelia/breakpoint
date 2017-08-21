//
//  CreatePostVC.swift
//  breakpoint
//
//  Created by kitiwat chanluthin on 8/21/17.
//  Copyright © 2017 kitiwat chanluthin. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class CreatePostVC: UIViewController {
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var sendBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.delegate = self
        sendBtn.bindToKeyboard()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.emailLbl.text = Auth.auth().currentUser?.email
    }
    
    @IBAction func sendBtnPressed(_ sender: Any) {
        guard textView.text != nil, textView.text != "what in your mind?",textView.text != "" else {return}
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        SVProgressHUD.show(withStatus: "Posting")
        sendBtn.isEnabled = false
        DataService.instance.uploadPost(withMessage: textView.text, forUID: uid, withGroupKey: nil) { (success) in
            if success{
                SVProgressHUD.showSuccess(withStatus: "Posted!!")
                SVProgressHUD.dismiss(withDelay: 2, completion: {
                    self.sendBtn.isEnabled = true
                    self.dismiss(animated: true, completion: nil)
                })
                
            }else{
                self.sendBtn.isEnabled = true
                SVProgressHUD.showError(withStatus: "Post Failed")
                debugPrint("Post Error")
            }
        }
    }
    
    @IBAction func closeBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

extension CreatePostVC:UITextViewDelegate{
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = ""
    }
}





