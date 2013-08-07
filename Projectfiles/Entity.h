/*
 * Kobold2D™ --- http://www.kobold2d.org
 *
 * Copyright (c) 2010-2011 Steffen Itterheim.
 * Released under MIT License in Germany (LICENSE-Kobold2D.txt).
 */


#import <Foundation/Foundation.h>
#import "cocos2d.h"

//#import "Component.h"
@class Component;

//By subclassing CCSprite you can add attributes like hitpoints and internal logic 
@interface Entity : CCSprite 
{
    //example extra property you can give your new entity
    int hitpoints; 
}

+(id) createEntity;
-(id) initWithEntityImage;
-(void) takeDamage;
-(int) checkHitpoints;
-(BOOL) isOutsideScreenArea;

@end
