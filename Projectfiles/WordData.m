//
//  WordData.m
//  PortraitTemplate
//
//  Created by Divakar on 8/5/13.
//
//

#import "WordData.h"

@implementation WordData

//@synthesize arrayOfDataToBeStored;
//@synthesize missionCriticalNumber;
//@synthesize somethingToBeToggled;

//static variable - this stores our singleton instance
static WordData *sharedData = nil;

+(WordData*) sharedData
{
    //If our singleton instance has not been created (first time it is being accessed)
    if(sharedData == nil)
    {
        //create our singleton instance
        sharedData = [[WordData alloc] init];
        
        //collections (Sets, Dictionaries, Arrays) must be initialized
        //Note: our class does not contain properties, only the instance does
        //self.arrayOfDataToBeStored is invalid
        sharedData.arrayOfDataToBeStored = [[NSMutableArray alloc] init];
    }
    
    //if the singleton instance is already created, return it
    return sharedData;
}

@end