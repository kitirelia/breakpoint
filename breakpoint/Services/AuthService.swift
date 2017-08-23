//
//  AuthService.swift
//  breakpoint
//
//  Created by kitiwat chanluthin on 8/21/17.
//  Copyright © 2017 kitiwat chanluthin. All rights reserved.
//

import Foundation
import Firebase


class AuthService {
    static let instance = AuthService()
    
    func registerUser(withEmail email:String,andPassword password:String,imageProfile:String ,userCreationComplete:@escaping (_ status:Bool,_ error:Error?)->()){
        let lowEmail = email.lowercased()
        Auth.auth().createUser(withEmail: lowEmail, password: password) { (user, error) in
            guard let user = user else {
                userCreationComplete(false, error)
                return
            }
            let userData = ["provider":user.providerID,"email":user.email,"profile_picture":imageProfile]
            
            DataService.instance.createDBUser(uid: user.uid, userData: userData)
            userCreationComplete(true, nil)
        }
    }
    
    func loginUser(withEmail email:String,andPassword password:String ,loginComplete:@escaping (_ status:Bool,_ error:Error?)->()){
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            guard let user = user else{
                loginComplete(false, error)
                return
            }
            loginComplete(true, nil)
        }
    }
    
}
