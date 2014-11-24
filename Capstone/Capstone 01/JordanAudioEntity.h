//
//  JordanAudioEntity.h
//  Capstone 01
//
//  Created by Rick Bowen on 11/24/14.
//  Copyright (c) 2014 Rick Bowen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface JordanAudioEntity : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * urlSrc;
@property (nonatomic, retain) NSString * albumArtThumb;
@property (nonatomic, retain) NSString * albumArtLarge;
@property (nonatomic, retain) NSString * speaker;
@property (nonatomic, retain) NSString * locationRecorded;
@property (nonatomic, retain) NSString * dateRecorded;

@end
