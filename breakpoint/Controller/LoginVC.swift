//
//  LoginVC.swift
//  breakpoint
//
//  Created by kitiwat chanluthin on 8/21/17.
//  Copyright © 2017 kitiwat chanluthin. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    @IBOutlet weak var emailTxt: insetTextField!
    @IBOutlet weak var passwordTxt: insetTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTxt.delegate = self
        passwordTxt.delegate = self
        
    }
    
    @IBAction func signInBtnPressed(_ sender: Any) {
        guard  emailTxt.text != "",emailTxt.text != nil else{return}
        guard  passwordTxt.text != "",passwordTxt.text != nil else{return}
        
        AuthService.instance.loginUser(withEmail: emailTxt.text!, andPassword: passwordTxt.text!) { (success, error) in
            if success{
                print("login success")
                self.dismiss(animated: true, completion: nil)
            }else{
                print("login Error!")
                debugPrint(error as Any)
            }
            
            AuthService.instance.registerUser(withEmail: self.emailTxt.text!, andPassword: self.passwordTxt.text!, userCreationComplete: { (success, error) in
                if success{
                    AuthService.instance.loginUser(withEmail: self.emailTxt.text!, andPassword: self.passwordTxt.text!, loginComplete: { (loginSuccess, error) in
                        if loginSuccess{
                            print("REGISTER AND LOGIN SUCCESS")
                            self.dismiss(animated: true, completion: nil)
                        }else{
                            debugPrint(error as Any)
                        }
                    })
                }else{
                    print("register Error!")
                    debugPrint(error as Any)
                }
            })
        }
        
    }
    
    @IBAction func closeBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}


extension LoginVC:UITextFieldDelegate{
    
}



