//
//  Model.swift
//  DemocraticJukebox
//
//  Created by Thahir Maheen on 29/05/15.
//  Copyright (c) 2015 Jukebox. All rights reserved.
//

import Foundation

class Model {
    
    /// currently logged in user
    var currentUser = User()
    
    class var sharedModel: Model {
        struct Singleton {
            static let sharedModel = Model()
        }
        return Singleton.sharedModel
    }
    
    struct Storyboards {
        static let Main = "Main"
        static let Login = "Login"
    }
    
    struct Api {
//        static let BaseUrl = "http://192.168.1.147:8081"
        static let BaseUrl = "http://115.112.144.186:8082"
        struct KeyPaths {
            static let Queue = "/api/v1/queue"
            static let Songs = "/api/v1/songs"
            static let History = "/api/v1/history/my"
            static let Favorites = "/api/v1/favourites"
        }
        struct Params {
            static let Search = "?search"
        }
    }
}