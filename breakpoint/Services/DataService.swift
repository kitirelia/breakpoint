//
//  DataService.swift
//  breakpoint
//
//  Created by kitiwat chanluthin on 8/21/17.
//  Copyright © 2017 kitiwat chanluthin. All rights reserved.
//

import Foundation
import Firebase
import Alamofire
import AlamofireImage

let DB_BASE = Database.database().reference()

class DataService{
    static let instance = DataService()
    
    private var _REF_BASE = DB_BASE
    private var _REF_USERS = DB_BASE.child("users")
    private var _REF_GROUPS = DB_BASE.child("groups")
    private var _REF_FEED = DB_BASE.child("feed")
    public private(set) var otherUserList = [OtherUser]()
    
    var REF_BASE:DatabaseReference{
        return _REF_BASE
    }
    var REF_USERS:DatabaseReference{
        return _REF_USERS
    }
    var REF_GROUPS:DatabaseReference{
        return _REF_GROUPS
    }
    var REF_FEED:DatabaseReference{
        return _REF_FEED
    }
    
    func createDBUser(uid:String,userData:Dictionary<String,Any>){
        REF_USERS.child(uid).updateChildValues(userData)
    }
    
    func getUsername(forUID uid:String,handler:@escaping (_ username:String)->()){
        REF_USERS.observeSingleEvent(of: .value) { (userSnanpshot) in
            guard let userSnapshot = userSnanpshot.children.allObjects as? [DataSnapshot] else{return }
            for user in userSnapshot {
                if user.key == uid{
                    handler(user.childSnapshot(forPath: "email").value as! String) 
                }
            }
        }
    }
    
    func uploadPost(withMessage message:String,forUID uid:String,withGroupKey groupKey:String?,sendComplete:@escaping (_ status:Bool)->()){
        if groupKey != nil{
            REF_GROUPS.child(groupKey!).child("messages").childByAutoId().updateChildValues(["content":message,"senderId":uid])
            sendComplete(true)
        }else{// feed
            REF_FEED.childByAutoId().updateChildValues(["content":message,"senderId":uid])
            sendComplete(true)
        }
    }
    
    func getAllFeedMessages(handler:@escaping (_ messages:[Message])->()){
        var messageArray = [Message]()
        REF_FEED.observeSingleEvent(of: .value) { (feedMessageSnapshot) in
            guard let feedMessageSnapshot = feedMessageSnapshot.children.allObjects as? [DataSnapshot] else {return}
            
            for message in feedMessageSnapshot{
                let content = message.childSnapshot(forPath: "content").value as! String
                let senderId = message.childSnapshot(forPath: "senderId").value as! String
                let message = Message(content: content, senderId: senderId)
                messageArray.append(message)
            }
            handler(messageArray)
        }
    }
    
    func getAllMessagesFor(desiredGroup:Group,handler:@escaping (_ messagesArray:[Message])->()){
        var groupMessagesArray = [Message]()
        REF_GROUPS.child(desiredGroup.key).child("messages").observeSingleEvent(of: .value) { (groupMessagesSnapshot) in
            guard let groupMessagesSnapshot = groupMessagesSnapshot.children.allObjects as? [DataSnapshot] else {return}
            for groupMessage in groupMessagesSnapshot{
                let content =  groupMessage.childSnapshot(forPath: "content").value as! String
                let senderId = groupMessage.childSnapshot(forPath: "senderId").value as! String
                let groupMessage = Message(content: content, senderId: senderId)
                groupMessagesArray.append(groupMessage)
            }
            handler(groupMessagesArray)
        }
    }
    
    
    func getEmailList(query:String,handler:@escaping (_ emailListArray:[OtherUser])->()){
        var otherUserList = [OtherUser]()
        var imageUrl = [String]()
        REF_USERS.observe(.value) { (userSnapshot) in
            guard let userSnapshot = userSnapshot.children.allObjects as? [DataSnapshot] else {return}
            for user in userSnapshot{
                let profile_picture = user.childSnapshot(forPath: "profile_picture").value as! String
                let email = user.childSnapshot(forPath: "email").value as! String
                
                if email.contains(query) == true && email != Auth.auth().currentUser?.email{
                    imageUrl.append(profile_picture)
                    
                    let otherUser = OtherUser(email: email, id: user.key, path: profile_picture,image:UIImage())
                    otherUserList.append(otherUser)
                }
            }
            self.loadProfileImage(userList: otherUserList, handler: { (success) in
                if success{
                    handler(otherUserList)
                }
            })
        }
    }
    
    func loadProfileImage(userList:[OtherUser],handler:@escaping (_ sucess:Bool)->()){
        var imageLoaded:Int = 0
        for var item in userList{
            Alamofire.request(item.imagePath).responseImage(completionHandler: { (response) in
                if let image = response.result.value {
                    item.updateImage(image: image)
                    print("\(imageLoaded),\(userList.count)")
                    
                }else{
                    let image2 = UIImage(named:"defaultProfileImage")
                    item.updateImage(image: image2!)
                    print("fail at \(imageLoaded)")
                }
                imageLoaded += 1
                if imageLoaded == userList.count{
                    handler(true)
                }
                
            })
        }
    }
    
    func getEmail(forSeachQuery query:String, handler: @escaping (_ emailArray:[String])->()){
        var emailArray = [String]()
        REF_USERS.observe(.value) { (userSnapshot) in
            guard let userSnapshot = userSnapshot.children.allObjects as? [DataSnapshot] else{return}
            for user in userSnapshot{
                let email = user.childSnapshot(forPath:"email").value as! String
                
                if email.contains(query) == true && email != Auth.auth().currentUser?.email{
                    emailArray.append(email)
                }
            }
            handler(emailArray)
        }
    }
    
    func getIds(forUsername usernameArray:[String],handler:@escaping(_ uidArray:[String])->()){
        REF_USERS.observeSingleEvent(of: .value) { (userSnapshot) in
            var idArray = [String]()
            guard let userSnapshot = userSnapshot.children.allObjects as? [DataSnapshot] else {return}
            for user in userSnapshot{
                let email = user.childSnapshot(forPath:"email").value as! String
                if usernameArray.contains(email){
                    idArray.append(user.key)
                }
            }
            handler(idArray)
        }
    }
    
    func createGroup(title:String,description:String,ids:[String],handler:@escaping (_ group:Bool)->()){
        REF_GROUPS.childByAutoId().updateChildValues(["title":title,"description":description,"members": ids]) { (error, ref) in
            if error != nil {
                handler(false)
            }else{
                handler(true)
            }
        }
    }
    
    func getEmailsFor(group:Group,handler:@escaping (_ emailArray:[String])->()){
        var emailArray = [String]()
        
        REF_USERS.observeSingleEvent(of: .value) { (userSnapshot) in
            guard let userSnapshot = userSnapshot.children.allObjects as? [DataSnapshot] else{return}
            
            for user in userSnapshot{
                if group.member.contains(user.key){
                    let email = user.childSnapshot(forPath: "email").value as! String
                    emailArray.append(email)
                }
            }
            handler(emailArray)
        }
    }
    
    func getAllGroups(handler:@escaping (_ groupArray:[Group])->()){
        var groupArray = [Group]()
        REF_GROUPS.observeSingleEvent(of: .value) { (groupSnapshot) in
            guard let groupSnapshot = groupSnapshot.children.allObjects as? [DataSnapshot] else {return}
            
            for group in groupSnapshot{
                let memberArray = group.childSnapshot(forPath: "members").value as! [String]
                if memberArray.contains((Auth.auth().currentUser?.uid)!){
                    let title = group.childSnapshot(forPath: "title").value as! String
                    let description = group.childSnapshot(forPath: "description").value as! String
                    let key = group.key
                    let group = Group(groupTitle: title, groupDescription: description, key: key, memberCount: memberArray.count, member: memberArray)
                    groupArray.append(group)
                }
            }
            return handler(groupArray)
        }
    }
    
    
}












