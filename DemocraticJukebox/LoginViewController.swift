//
//  LoginViewController.swift
//  DemocraticJukebox
//
//  Created by Thahir on 29/05/15.
//  Copyright (c) 2015 Jukebox. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, FBSDKLoginButtonDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // check for logged in user
        if FBSDKAccessToken.currentAccessToken() != nil {
            getCurrentUser()
            // enter app
            appDelegate.loadHome()
        }
    }
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        
        // handle errors
        if error != nil {
            println("XXX Some error occurred during facebook login \(error.localizedDescription)")
        }
        
        else if result.isCancelled {
            println("Cant access app without logging in")
        }
        
        else {
            // enter app
            appDelegate.loadHome()
        }
    }

    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        // do nothing
    }
    
    func getCurrentUser() {
        let graphRequest = FBSDKGraphRequest(graphPath: "me", parameters: nil)
        graphRequest.startWithCompletionHandler { (connection, result, error) in
            
            // handle errors
            if error != nil {
                println("error getting user data \(error.localizedDescription)")
                return
            }
            
            Model.sharedModel.currentUser = User(facebookUser: result)
            Model.sharedModel.currentUser.token = "Token " + graphRequest.tokenString
        }
    }
}
