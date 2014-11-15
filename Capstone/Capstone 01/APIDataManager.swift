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
    func APIGetAllDataCallBack(senderClass: AnyObject, success: Bool, response: [JordanAudioObject])
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
        client.login(u, p: p,
            {
                (response :AnyObject) in
                self.parseLogin(response)
            },
            failure:
            {
                (error :NSError) in
                println("error - \(error)")
            }
        )
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
        var parsedResponse: AnyObject = false // default
        
        if let token = response.valueForKeyPath("data.token") as? String
        {
            parsedResponse = token
        }
        else if let error = response.valueForKeyPath("error.message") as? String
        {
            println("error: \(error)")
        }
        
        
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
        var success:Bool = true
        
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
        else if let errorData: AnyObject = response.valueForKey("error") as AnyObject!
        {
            //var errorCode = errorData.valueForKey("code") as String
            //var errorMessage = errorData.valueForKey("message") as String
            success = false // API returned error..
        }
        else
        {
            println("unknown response...")
        }
        
        if let d = self.audioDelegate?
        {
            d.APIGetAllDataCallBack(self,success: success, response: parsedResponse)
        }
        else
        {
            println("No delegate set: APIGetAllDataCallBack()")
        }
    }
}
