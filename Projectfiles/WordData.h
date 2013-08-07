//
//  WordData.h
//  PortraitTemplate
//
//  Created by Divakar on 8/5/13.
//
//

#import <Foundation/Foundation.h>

//an NSObject is the most basic Objective-C object
//We subclass it since our singleton is nothing more than a wrapper around several properties
@interface WordData : NSObject

//the keyword "nonatomic" is a property declaration
//nonatomic properties have better performance than atomic properties (so use them!)
@property (nonatomic) NSMutableArray* arrayOfDataToBeStored;
@property (nonatomic) int missionCriticalNumber;
@property (nonatomic) bool somethingToBeToggled;

//Static (class) method:
+(WordData*) sharedData;

@end
