//
//  Name.h
//  MonkeyGame
//
//  Created by Tzu-Yang Ni on 3/25/12.
//  Copyright (c) 2012 yoseka. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Score;

@interface Name : NSManagedObject

@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * note;
@property (nonatomic, retain) NSSet *score;
@end

@interface Name (CoreDataGeneratedAccessors)

- (void)addScoreObject:(Score *)value;
- (void)removeScoreObject:(Score *)value;
- (void)addScore:(NSSet *)values;
- (void)removeScore:(NSSet *)values;

@end
