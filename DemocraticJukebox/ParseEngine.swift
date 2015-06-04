//
//  ParseEngine.swift
//  DemocraticJukebox
//
//  Created by Thahir Maheen on 29/05/15.
//  Copyright (c) 2015 Jukebox. All rights reserved.
//

import Foundation

class ParseEngine {
    
    enum HTTPMethod: String {
        case GET = "GET"
        case POST = "POST"
        case DELETE = "DELETE"
    }
    
    class var sharedEngine: ParseEngine {
        struct Singleton {
            static let sharedEngine = ParseEngine()
        }
        return Singleton.sharedEngine
    }
    
    func fetchData(keyPath: String, params: [String: String], completionHandler: (data: NSDictionary) -> ()) {
        
        // format params into a string to pass into url
        let paramStrings = params.keys.array.reduce("?") { $0 + "\($1)=\(params[$1]!)&" }
        
        // encode the url string
        let urlString = (Model.Api.BaseUrl + keyPath + paramStrings).stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
        
        // create the url
        let url = NSURL(string: urlString)!
        
        // download data
        NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) in
            
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
                
                // return the result in the main queue
                dispatch_async(dispatch_get_main_queue(), { () in
                    completionHandler(data: jsonData)
                })
            }
            
        }.resume()
    }
    
    func postData(keyPath: String, params: [String: String], completionHandler: (data: NSDictionary) -> ()) {
        
        // create the url string
        let urlString = (Model.Api.BaseUrl + keyPath).stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
        
        let session = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
        
        var dictionaryParams = params
        dictionaryParams["Authorization"] = Model.sharedModel.currentUser.token

        // create from data from the params dictionary
        let fromData = NSJSONSerialization.dataWithJSONObject(dictionaryParams, options: NSJSONWritingOptions.PrettyPrinted, error: nil)
        
        // configure an NSURLRequest
        let request = NSMutableURLRequest(URL: NSURL(string: urlString)!)
        request.HTTPMethod = HTTPMethod.POST.rawValue
        
        session.uploadTaskWithRequest(request, fromData: fromData) { (data, response, error) in
            
            println("params = \(dictionaryParams)")
            println("data = \(data)")
            println("response = \(response)")
            println("error = \(error)")
            
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
                
                // return the result in the main queue
                dispatch_async(dispatch_get_main_queue(), { () in
                    completionHandler(data: jsonData)
                })
            }
            
        }.resume()
    }
}