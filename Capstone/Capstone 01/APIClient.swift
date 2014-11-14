//
//  APIClient.swift
//  Capstone 01
//
//  Created by Aldrich on 10/7/14.
//  Copyright (c) 2014 Rick Bowen. All rights reserved.
//

import UIKit


class APIClient
{    
    let BaseURL = "http://api.bowenux.com/v1/"
    let manager = AFHTTPRequestOperationManager()

    func getAudio(completion :(AnyObject) -> (), failure :(NSError) -> ())
    {
        println("APIClient.getAudio()")
        let apiMethodUrl = self.BaseURL + "audio"
        
        manager.GET(apiMethodUrl, parameters: nil, success:
            {
                (operation: AFHTTPRequestOperation!,responseObject: AnyObject!) in
                completion(responseObject)
            }, failure: {
                (operation: AFHTTPRequestOperation!,error: NSError!) in
                println("Error: " + error.localizedDescription)
                failure(error)
       })
    }
    
    func login(u:String, p:String, completion :(AnyObject) -> (), failure :(NSError) -> ())
    {
        println("APIClient.login()")
        let apiMethodUrl = self.BaseURL + "login"
        let params = ["u":u,"p":p]
        
        manager.GET(apiMethodUrl, parameters: params, success:
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