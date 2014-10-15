//
//  APIDataManager.swift
//  Capstone 01
//
//  Created by Rick Bowen on 10/6/14.
//  Copyright (c) 2014 Rick Bowen. All rights reserved.
//

import Foundation

protocol GetAudioCallBack
{
    func didApiRespond(senderClass: AnyObject, response: [JordanAudioObject])
}

class APIDataManager
{
    let client = APIClient()
    var delegate: GetAudioCallBack?
    
    init() { }
    
    func getAllAudio()
    {
        client.getAudio(
        {
            (response :AnyObject) in
            println("AudioObject at getAudio.complete()")
            self.parse(response)
        },
        failure:
        {
            (error :NSError) in
            // unable to communicate with api
            println("error - \(error)")
        })

        //return parsedResponse!
    }
    
    func parse(response: AnyObject) //-> [JordanAudioObject]
    {
        var parsedResponse:[JordanAudioObject] = []
        
        println("AudioObject at parse()")
        
        if let dataArray = response.valueForKey("data") as? [AnyObject] {
            
            for var i = 0; i < dataArray.count; i++
            {
                var apiAudioItem = JordanAudioObject()
                let dataObject: AnyObject = dataArray[i]
                
                apiAudioItem.name =             dataObject.valueForKeyPath("name") as String
                apiAudioItem.albumArtThumb =    dataObject.valueForKeyPath("albumArtSmall") as String
                apiAudioItem.urlSrc =           dataObject.valueForKeyPath("audioUrl") as String
                
                parsedResponse.append(apiAudioItem)
                //println("name")
                
            }
        }
        
        if let dmDelegate = self.delegate?
        {
            
            dmDelegate.didApiRespond(self, response: parsedResponse)
            //self.delegate!.didApiRespond(self, response: parsedResponse)
            
        } else {
            
            println("No delegate set")
            
        }
        
        //return parsedResponse
    }
}
