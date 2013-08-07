/*
 * Kobold2D™ --- http://www.kobold2d.org
 *
 * Copyright (c) 2010-2011 Steffen Itterheim.
 * Released under MIT License in Germany (LICENSE-Kobold2D.txt).
 */


#import "Entity.h"
#import "GameLayer.h"

@implementation Entity

//This is the method other classes should call to create an instance of Entity
+(id) createEntity
{
	id myEntity = [[self alloc] initWithEntityImage];
    
//Don't worry about this, this is memory management stuff that will be handled for you automatically    
#ifndef KK_ARC_ENABLED
	[myEntity autorelease];
#endif // KK_ARC_ENABLED
    return myEntity;
}

-(id) initWithEntityImage
{
	// Loading the Entity's sprite using a file, is a ship for now but you can change this
	if ((self = [super initWithFile:@"ship.png"]))
	{
        hitpoints = 10;
		//do stuff
	}
	return self;
}


// You can override setPosition, a method inherited from CCSprite, to keep entitiy within screen bounds

/*
-(void) setPosition:(CGPoint)pos
{
	// If the current position is (still) outside the screen no adjustments should be made!
	// This allows entities to move into the screen from outside.
	if ([self isOutsideScreenArea])
	{
		CGSize screenSize = [[CCDirector sharedDirector] winSize];
		float halfWidth = self.contentSize.width * 0.5f;
		float halfHeight = self.contentSize.height * 0.5f;
		
		// Cap the position so the Ship's sprite stays on the screen
		if (pos.x < halfWidth)
		{
			pos.x = halfWidth;
		}
		else if (pos.x > (screenSize.width - halfWidth))
		{
			pos.x = screenSize.width - halfWidth;
		}
		
		if (pos.y < halfHeight)
		{
			pos.y = halfHeight;
		}
		else if (pos.y > (screenSize.height - halfHeight))
		{
			pos.y = screenSize.height - halfHeight;
		}
	}
	
	[super setPosition:pos];
}

*/ 
 
-(BOOL) isOutsideScreenArea
{
	return (CGRectContainsRect([GameLayer screenRect], [self boundingBox]));
}

//example methods you can add that a normal CCSprite doesn't have
-(void) takeDamage
{
    hitpoints -= 1;
}

-(int) checkHitpoints
{
    return hitpoints;
}

@end
