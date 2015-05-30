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
    
    init() {
        
    }
    
    init(facebookUser: AnyObject) {
        self.id = (facebookUser.valueForKey("id") ?? "") as! String
        self.firstName = (facebookUser.valueForKey("first_name") ?? "") as! String
        self.lastName = (facebookUser.valueForKey("last_name") ?? "") as! String
        self.name = (facebookUser.valueForKey("name") ?? "") as! String
        self.gender = (facebookUser.valueForKey("gender") ?? "") as! String
        self.link = (facebookUser.valueForKey("link") ?? "") as! String
    }
}