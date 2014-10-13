//
//  APIDataManager.swift
//  Capstone 01
//
//  Created by Rick Bowen on 10/6/14.
//  Copyright (c) 2014 Rick Bowen. All rights reserved.
//

import Foundation

class APIDataManager
{
    let client = APIClient()
    
    var audioArray:[JordanAudioObject] = []
    
    
    
    //var response: [] = []
    
    func getAllAudio() -> [JordanAudioObject]
    {
        var parsedResponse:[JordanAudioObject]?
        
        client.getAudio(
        {
            (response :AnyObject) in
            println("response - \(response)")        
            parsedResponse = self.parse(response)
        },
        failure:
        {
            (error :NSError) in
            // unable to communicate with api
            println("error - \(error)")
        })

        return parsedResponse!
    }
    
    func parse(response: AnyObject) -> [JordanAudioObject]
    {
        var parsedResponse:[JordanAudioObject] = []

        for var i = 0; i < response.count; i++
        {
            var apiAudioItem = JordanAudioObject()
            let dataObject: AnyObject = response[i]
            
            apiAudioItem.name =             dataObject.valueForKeyPath("name") as String
            apiAudioItem.albumArtThumb =    dataObject.valueForKeyPath("albumArtSmall") as String
            apiAudioItem.urlSrc =           dataObject.valueForKeyPath("audioUrl") as String
            
            //println(apiAudioItem)
            
            //parsedResponse.append(nextAudio)
        }
        return parsedResponse
    }
}
