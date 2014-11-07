//
//  NSNotificationCenterKeys.swift
//  Capstone 01
//
//  Created by Rick Bowen on 11/4/14.
//  Copyright (c) 2014 Rick Bowen. All rights reserved.
//

import Foundation


let playerLoadedNotification = playerLoadedNotificationKey()
let playerTimeUpdatedNotification = playerTimeUpdatedNotificationKey()

class playerLoadedNotificationKey {
    var key = "com.bowenux.playerLoadedNotificationKey"
}
class playerTimeUpdatedNotificationKey {
    var key = "com.bowenux.playerTimeUpdatedNotificationKey"
}