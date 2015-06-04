//
//  User.swift
//  DemocraticJukebox
//
//  Created by Thahir Maheen on 29/05/15.
//  Copyright (c) 2015 Jukebox. All rights reserved.
//

import Foundation

class User {
    
    var id = ""
    var firstName = ""
    var lastName = ""
    var name = ""
    var gender = ""
    var link = ""
    var token: String?
    
    init() {
        
    }
    
    init(facebookUser: AnyObject) {
        id = (facebookUser.valueForKey("id") ?? "") as! String
        firstName = (facebookUser.valueForKey("first_name") ?? "") as! String
        lastName = (facebookUser.valueForKey("last_name") ?? "") as! String
        name = (facebookUser.valueForKey("name") ?? "") as! String
        gender = (facebookUser.valueForKey("gender") ?? "") as! String
        link = (facebookUser.valueForKey("link") ?? "") as! String
    }
}