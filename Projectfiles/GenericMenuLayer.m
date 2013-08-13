//
//  GenericMenuLayer.m
//  Game Template
//
//  Created by Jeremy Rossmann on 7/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GenericMenuLayer.h"
#import "GameLayer.h"
#import "textFieldTestAppDelegate.h"
#import "cocos2d.h"


@implementation GenericMenuLayer

-(id) init
{
	if ((self = [super init]))
	{        
        CCLabelTTF *label = [CCLabelTTF labelWithString: @"Start Game!" fontName:@"Arial" fontSize:40.0f];

        
        CCMenuItemLabel *item = [CCMenuItemLabel itemWithLabel:label target:self selector:@selector(doSomething)];

                
        CCMenu *menu = [CCMenu menuWithItems:item, nil];
        
        [self addChild:menu];
        }
        
         
        
        //Add button
        /*
        UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [button addTarget:self
                   action:@selector(aMethod:)
         forControlEvents:[UIControlEventTouchUpInside]];
        [button setTitle:@"Show View" forState:UIControlStateNormal];
        button.frame = CGRectMake(80.0, 210.0, 160.0, 40.0);
        [self addview:button];
         */
        
      
    
    return self;
        
    
}


-(void) doSomething
{
        [[CCDirector sharedDirector] replaceScene: [[GameLayer alloc] init]];
}


@end
