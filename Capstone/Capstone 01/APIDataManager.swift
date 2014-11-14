//
//  APIDataManager.swift
//  Capstone 01
//
//  Created by Rick Bowen on 10/6/14.
//  Copyright (c) 2014 Rick Bowen. All rights reserved.
//

import Foundation

protocol APIDataManagerAudioDelegate
{
    func APIGetAllDataCallBack(senderClass: AnyObject, response: [JordanAudioObject])
}
protocol APIDataManagerLoginDelegate
{
    func APILoginCallBack(senderClass: AnyObject, response: AnyObject)
}

class APIDataManager
{
    let client = APIClient()
    var audioDelegate: APIDataManagerAudioDelegate?
    var loginDelegate: APIDataManagerLoginDelegate?
    
    init() { }
    
    func login(u:String, p:String)
    {
        /*client.login(u, p: p,
            {
                (response :AnyObject) in
                self.parseLogin(response)
            },
            failure:
            {
                (error :NSError) in
                println("error - \(error)")
            }
        )*/
        self.parseLogin("{my fake API response, to be replaced with real API call}")
    }
    
    func getAllAudio(sessionToken:String)
    {
        client.getAudio(sessionToken,
        {
            (response :AnyObject) in
            println("AudioObject at getAudio.complete()")
            self.parseAudioObjects(response)
        },
        failure:
        {
            (error :NSError) in
            println("error - \(error)")
        })
    }
    
    func parseLogin(response: AnyObject)
    {
        var parsedResponse: AnyObject = "N16Ps9ICInxXfq2gQFzTC0Loj985ztlgVengxr1NBQsiDxJI0JYrJQ9eHeco!"
        
        println(response)
        
        if let d = self.loginDelegate?
        {
            d.APILoginCallBack(self, response: parsedResponse)
        }
        else
        {
            println("No delegate set: APIDataManagerLoginDelegate")
        }
    }
    
    func parseAudioObjects(response: AnyObject)
    {
        var parsedResponse:[JordanAudioObject] = []
        
        println("AudioObject at parseAudioObjects()")
        
        if let dataArray = response.valueForKey("data") as? [AnyObject]
        {
            for var i = 0; i < dataArray.count; i++
            {
                var apiAudioItem = JordanAudioObject()
                let dataObject: AnyObject = dataArray[i]
                apiAudioItem.name =             dataObject.valueForKeyPath("name") as String
                apiAudioItem.albumArtThumb =    dataObject.valueForKeyPath("albumArtSmall") as String
                apiAudioItem.albumArtLarge =    dataObject.valueForKeyPath("albumArtLarge") as String
                apiAudioItem.urlSrc =           dataObject.valueForKeyPath("audioUrl") as String
                apiAudioItem.dateRecorded =     dataObject.valueForKeyPath("date_recorded") as String
                apiAudioItem.locationRecorded = dataObject.valueForKeyPath("location.name") as String
                parsedResponse.append(apiAudioItem)
            }
        }
        else if let errorArray = response.valueForKey("error") as? [AnyObject]
        {
            println(errorArray)
        }
        else
        {
            println("unknown response: \(response)")
        }
        
        if let d = self.audioDelegate?
        {
            d.APIGetAllDataCallBack(self, response: parsedResponse)
        }
        else
        {
            println("No delegate set")
        }
    }
}
