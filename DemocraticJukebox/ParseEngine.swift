//
//  ParseEngine.swift
//  DemocraticJukebox
//
//  Created by Thahir Maheen on 29/05/15.
//  Copyright (c) 2015 Jukebox. All rights reserved.
//

import Foundation

class ParseEngine {
    
    class var sharedEngine: ParseEngine {
        struct Singleton {
            static let sharedEngine = ParseEngine()
        }
        return Singleton.sharedEngine
    }
    
    func fetchData(urlString: String, completionHandler: (data: NSDictionary) -> ()) {
        
        // create the url
        let url = NSURL(string: urlString)!
        
        // download data
        NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) -> Void in
            
            // handle errors
            if (error != nil) {
                println("error: \(error.localizedDescription)")
                return
            }
            
            // parse data
            var jsonError: NSError?
            if let jsonData = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &jsonError) as? NSDictionary {
                
                // handle parsing errors
                if (jsonError != nil) {
                    println("error: \(jsonError!.localizedDescription)")
                    return
                }
                
                // return the result
                completionHandler(data: jsonData)
            }
            
        }.resume()
    }
}