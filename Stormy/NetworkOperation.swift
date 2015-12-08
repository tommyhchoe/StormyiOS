//
//  NetworkOperation.swift
//  Stormy
//
//  Created by Tommy Choe on 10/25/15.
//  Copyright © 2015 Tommy Choe. All rights reserved.
//

import Foundation

class NetworkOperation{
    lazy var configuration: NSURLSessionConfiguration = NSURLSessionConfiguration.defaultSessionConfiguration()
    lazy var session: NSURLSession = NSURLSession(configuration: self.configuration)
    let queryURL: NSURL
    
    typealias JSONDictionaryCompletion = [String:AnyObject]? -> ()
    
    init(url:NSURL){
        self.queryURL = url
    }
    
    func downloadJSONFromURL(completion: JSONDictionaryCompletion){
        let request:NSURLRequest = NSURLRequest(URL: queryURL)
        let dataTask = session.dataTaskWithRequest(request) {
            (let data, let response, let error) in
            if let httpResponse = response as? NSHTTPURLResponse {
                switch(httpResponse.statusCode){
                case 200:
                    //JSON Dictionary object with data
                    do{
                        let JSONDictionary = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as? [String:AnyObject]
                        completion(JSONDictionary)
                    } catch let error{
                        print("JSON Serialization failed. Error:\(error)")
                    }
                default:print("get request not successful. HTTP Status code: \(httpResponse.statusCode)")
                }
            } else{
                print("Not a valid HTTP Response")
            }
        }
        dataTask.resume()
    }
}









