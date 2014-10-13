//
//  APIClient.swift
//  Capstone 01
//
//  Created by Aldrich on 10/7/14.
//  Copyright (c) 2014 Rick Bowen. All rights reserved.
//

import UIKit


class APIClient {
    
    let BaseURL = "http://api.bowenux.com/v1/audio"
    let manager = AFHTTPRequestOperationManager()

    func getAudio(completion :(AnyObject) -> (), failure :(NSError) -> ()) {
       println("get audio called")
       manager.GET(BaseURL, parameters: nil, success:
            {
                (operation: AFHTTPRequestOperation!,responseObject: AnyObject!) in
                completion(responseObject)
            }, failure: {
                (operation: AFHTTPRequestOperation!,error: NSError!) in
                println("Error: " + error.localizedDescription)
                failure(error)
       })
    }
    
    func parse()
    {
        // idea here is for this method to parse all API json responses
        // against the jns().
    }
    
    func jns() // jns: "json name service"
    {
        // the idea is to store the API json definition here.
        // If the api is updated, this is where the change would occur
        // for the ios app.
        
        // perhaps this could store the locations of meta data,
        // e.g., name = {name}
        
        // this definition would be used with a parse() function
        
        // might make sense for this to be a subclass of APIClient() ?
    }
    
    
    
}