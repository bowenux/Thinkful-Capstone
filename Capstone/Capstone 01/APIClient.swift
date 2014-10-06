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

    
    
    
}