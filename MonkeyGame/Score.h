//
//  Score.h
//  MonkeyGame
//
//  Created by Tzu-Yang Ni on 3/25/12.
//  Copyright (c) 2012 yoseka. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Name;

@interface Score : NSManagedObject

@property (nonatomic, retain) NSNumber * banana;
@property (nonatomic, retain) NSNumber * monkey;
@property (nonatomic, retain) NSNumber * sorting;
@property (nonatomic, retain) Name *name;

@end
