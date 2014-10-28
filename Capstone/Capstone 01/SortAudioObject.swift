//
//  SortAudioObject
//  Capstone 01
//
//  Created by Rick Bowen on 10/28/14.
//  Copyright (c) 2014 Rick Bowen. All rights reserved.
//

import Foundation

class SortAudioObject
{
    struct sortObject
    {
        var name: String
        var rule: String
    }
    
    var sortingOptions: [sortObject] = []
    let title = "Sort By.."
    
    init()
    {
        sortingOptions.append( sortObject(name:"Most Recent", rule:"$0.dateRecorded < $1.dateRecorded") )
        sortingOptions.append( sortObject(name:"Title (a-z)", rule:"$0.name < $1.name") )
        sortingOptions.append( sortObject(name:"Title (z-a)", rule:"$0.name > $1.name") )
    }
    
    func sort(audio:[JordanAudioObject], index:String) -> [JordanAudioObject]
    {
        // THIS DOESN"T WORK...
        //var rule = sortingOptions[index].rule
        //audio.sort{ rule } // THIS DOESN"T WORK...
        
        switch index
        {
            case "Most Recent": audio.sort{ $0.dateRecorded < $1.dateRecorded }
            case "Title (A-Z)": audio.sort{ $0.name < $1.name }
            case "Title (Z-A)": audio.sort{ $0.name > $1.name }
            default:println("Index not found...")
        }
        
        return audio
    }
}