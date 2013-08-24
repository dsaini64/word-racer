//
//  GameOverLayer.m
//  PortraitTemplate
//
//  Created by Divya on 7/26/13.
//
//

#import "GameOverLayer.h"
#import "GameLayer.h"
#import "GenericMenuLayer.h"
#import "WordData.h"

@implementation GameOverLayer
-(id) initWithScore:(NSInteger) score
{
    if ((self = [super init]))
    {
        //        CGSize winsize = [CCDirector sharedDirector].winSize;
        //        //To move the screen down
        //        self.position = CGPointMake(self.position.x, self.position.y + winsize.height);
        //        //To move the screen up
        //        self.position = CGPointMake(self.position.x, self.position.y - winsize.height);
        
        //set initial value of timesDownPressed
        self.timesDownPressed = [NSNumber numberWithInt:0];
        
        // add game over
        CCLabelTTF *gameOver = [CCLabelTTF labelWithString: @"Game Over!" fontName:@"Arial" fontSize:40.0f];
        gameOver.position = CGPointMake(160, 435);
        [self addChild:gameOver];
        
        
        //add score
        CCLabelTTF *scoreLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Score: %d", score] fontName:@"arial" fontSize:30];
        scoreLabel.position = CGPointMake(160,380);
        [self addChild:scoreLabel];
        
        //add play again "button"
        CCLabelTTF *playAgainLabel = [CCLabelTTF labelWithString: @"Play Again" fontName:@"Arial" fontSize:40.0f];
        // playAgainLabel.position = ccp(0, -100);
        
        CCMenuItemLabel *item = [CCMenuItemLabel itemWithLabel:playAgainLabel target:self selector:@selector(gameLayerTransition)];
        item.position = ccp(0,60);
        
        //add menu "button"
        
        CCLabelTTF *menuLabel = [CCLabelTTF labelWithString: @"Menu" fontName:@"Arial" fontSize:40.0f];
        // menuLabel.position = ccp(50,-150);
        
        CCMenuItemLabel *item2 = [CCMenuItemLabel itemWithLabel:menuLabel target:self selector:@selector(menuLayerTransition)];
        item2.position = ccp(0,15);
        
        //add high score
        
        NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
        int highScore = [standardUserDefaults integerForKey:@"highScore"];
        CCLabelTTF *highScoreLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Overall High Score: \n %d", highScore] fontName:@"arial" fontSize:15];
        highScoreLabel.position = CGPointMake(160,340);
        
        [self addChild:highScoreLabel];
        
        
        
        //show the buttons
        
        CCMenu *menu = [CCMenu menuWithItems:item, item2, nil];
        [self addChild:menu];
        
        
        
        
        self.wordArray = [WordData sharedData].arrayOfDataToBeStored;
        NSLog(@"%@",self.wordArray);
       // [self downBtnNeeded];
        //if([self downBtnNeeded]) {
        [self showDownBtn];
       // }
        
        float y = 0;
        for(int i = 0; i < [self.wordArray count]; i++) {
            
            NSDictionary *wordDict = [self.wordArray objectAtIndex:i];
            CCLabelTTF *POSLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%@",[wordDict objectForKey:@"POS"]] dimensions: CGSizeMake(200,200) alignment:kCCTextAlignmentLeft fontName:@"arial" fontSize:20];
            POSLabel.position = CGPointMake (160 , (100 - y));
            [self addChild:POSLabel];
            
            CCLabelTTF *startingLetterLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%@",[wordDict objectForKey:@"startingLetter"]] dimensions: CGSizeMake(200,200) alignment:kCCTextAlignmentLeft fontName:@"arial" fontSize:20];
            startingLetterLabel.position = ccp (110 ,(100 - y));
            [self addChild:startingLetterLabel];
            
            self.userInputLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%@",[wordDict objectForKey:@"userInput"]] dimensions: CGSizeMake(200,200) alignment:kCCTextAlignmentLeft fontName:@"arial" fontSize:20];
            if ([[wordDict objectForKey:@"wordValidity"] isEqual: @"YES"]) {
                [self.userInputLabel setColor:ccc3(0, 255, 0)];
            }
            else {
                [self.userInputLabel setColor:ccc3(255, 0, 0)];
            }
            self.userInputLabel.position = ccp (260, (100 - y));
            [self addChild:self.userInputLabel];
           
            y += 25;
            
            
            
        }
    }
    
    
    
    
    
    
    
    //        for (int i = 0; i < wordArray.count; i++) {
    //            self.wordLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%@", wordArray[i]] dimensions: CGSizeMake(200,200) alignment:kCCTextAlignmentRight fontName:@"arial" fontSize:50];
    //            self.wordLabel.position = ccp(0, 375);
    //
    //            [self addChild:self.wordLabel];
    //
    //        }
    
    //NSLog(@"Hello World: %f",self.userInputLabel.position.y);
   // NSLog(@"Layer size: %f", self.size.height);
    //NSLog(@"menu size: %f", menuLabel.size.height);
    
    return self;
    
    
}


-(void) menuLayerTransition
{
    [[CCDirector sharedDirector] replaceScene: [[GenericMenuLayer alloc] init]];
}
-(void) gameLayerTransition
{
    [[CCDirector sharedDirector] replaceScene: [[GameLayer alloc] init]];
    
}

-(void) moveScreenDown {
    
    
    
    self.timesDownPressed = [NSNumber numberWithInt:[self.timesDownPressed intValue] + 1];
    CGSize winsize = [CCDirector sharedDirector].winSize;
    self.position = CGPointMake(self.position.x, self.position.y + winsize.height);
    NSLog(@"%f",self.position.y);
    
    [self showUpBtn];
    
    [self showDownBtn];
    
    NSLog(@"UserInputLabel position: %f",self.userInputLabel.position.y);
    NSLog(@"Scroll position: %f",-(self.position.y));
    
    
    
    
    
}

-(void) moveScreenUp {
    CGSize winsize = [CCDirector sharedDirector].winSize;
    self.position = CGPointMake(self.position.x, self.position.y - winsize.height);
    
    
}

-(void) showUpBtn {
    // [self.upLabel removeFromParent];
    
    self.upLabel = [CCLabelTTF labelWithString: @"up" fontName:@"Arial" fontSize:20.0f];
    
    CCMenuItemLabel *item3 = [CCMenuItemLabel itemWithLabel:self.upLabel target:self selector:@selector(moveScreenUp)];
    item3.position = ccp(100,10 -([self.timesDownPressed intValue] * 480));
    CCMenu *menu = [CCMenu menuWithItems:item3, nil];
    [self addChild:menu];
    
    
    
    
}

-(void)showDownBtn{
    
    // [self.downLabel removeFromParent];
    
    
//   if([self.timesDownPressed intValue] == 0) {
//        self.downLabel = [CCLabelTTF labelWithString: @"down" fontName:@"arial" fontSize:10.0f];
//        CCMenuItemLabel *item = [CCMenuItemLabel itemWithLabel:self.downLabel target:self selector:@selector(moveScreenDown)];
//        item.position = ccp(100,-25-(480*[self.timesDownPressed intValue]));
//        CCMenu *menu = [CCMenu menuWithItems:item, nil];
//        [self addChild:menu];
//    }
    
//   if([self.timesDownPressed intValue] == 1) {
//        
//        self.wordCount = self.wordArray.count - 8;
//        
//        self.downLabel = [CCLabelTTF labelWithString: @"down" fontName:@"arial" fontSize:10.0f];
//        CCMenuItemLabel *item = [CCMenuItemLabel itemWithLabel:self.downLabel target:self selector:@selector(moveScreenDown)];
//        item.position = ccp(100,-25-(480*[self.timesDownPressed intValue]));
//        CCMenu *menu = [CCMenu menuWithItems:item, nil];
//        [self addChild:menu];
//        
//    }
    
    
    
    self.downLabel = [CCLabelTTF labelWithString: @"down" fontName:@"arial" fontSize:20.0f];
    CCMenuItemLabel *item = [CCMenuItemLabel itemWithLabel:self.downLabel target:self selector:@selector(moveScreenDown)];
    //float yValue = (400*[self.timesDownPressed intValue]);
    item.position = ccp(100,-20-(480*[self.timesDownPressed intValue]));
    CCMenu *menu = [CCMenu menuWithItems:item, nil];
    [self addChild:menu];
    if(self.wordArray.count < 8) {
        
        [item removeFromParent];
    }
    NSLog(@"SELF POSITION : %f",-self.position.y - 480);
    NSLog(@"SELF INPUTLABEL POSITION : %f",self.userInputLabel.position.y);
    if(-self.position.y < self.userInputLabel.position.y)
    {
        [item removeFromParent];
    }

    
}





@end
