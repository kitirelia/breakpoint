//
//  Group.swift
//  breakpoint
//
//  Created by kitiwat chanluthin on 8/22/17.
//  Copyright © 2017 kitiwat chanluthin. All rights reserved.
//

import Foundation

class Group {
    private var _groupTitle:String
    private var _groupDescription:String
    private var _key:String
    private var _memberCount:Int
    private var _members:[String]
    
    var groupTitle:String{
        return _groupTitle
    }
    var groupDescription:String{
        return _groupDescription
    }
    var key:String{
        return _key
    }
    var memberCount:Int{
        return _memberCount
    }
    var member:[String]{
        return _members
    }
    
    init(groupTitle:String,groupDescription:String,key:String,memberCount:Int,member:[String]){
        self._groupTitle = groupTitle
        self._groupDescription = groupDescription
        self._key = key
        self._memberCount = memberCount
        self._members = member
    }
}
