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
        // add game over
        CCLabelTTF *gameOver = [CCLabelTTF labelWithString: @"Game Over!" fontName:@"Arial" fontSize:40.0f];
        gameOver.position = CGPointMake(160, 415);
        [self addChild:gameOver];
        
        //add score
        CCLabelTTF *scoreLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Score: %d", score] fontName:@"arial" fontSize:30];
        scoreLabel.position = CGPointMake(160,300);
        [self addChild:scoreLabel];

        //add play again "button"
        CCLabelTTF *playAgainLabel = [CCLabelTTF labelWithString: @"Play Again" fontName:@"Arial" fontSize:40.0f];
       // playAgainLabel.position = ccp(0, -100);
        
        CCMenuItemLabel *item = [CCMenuItemLabel itemWithLabel:playAgainLabel target:self selector:@selector(gameLayerTransition)];
        item.position = ccp(0,-100); 
   
        //add menu "button"
        
        CCLabelTTF *menuLabel = [CCLabelTTF labelWithString: @"Menu" fontName:@"Arial" fontSize:40.0f];
        // menuLabel.position = ccp(50,-150);
        
        CCMenuItemLabel *item2 = [CCMenuItemLabel itemWithLabel:menuLabel target:self selector:@selector(menuLayerTransition)];
        item2.position = ccp(0,-150);

        //show the buttons
        
        CCMenu *menu = [CCMenu menuWithItems:item, item2, nil];
        [self addChild:menu];
        
        //add high score
        
         NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
         int highScore = [standardUserDefaults integerForKey:@"highScore"];
        CCLabelTTF *highScoreLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Overall High Score: \n %d", highScore] fontName:@"arial" fontSize:15];
        highScoreLabel.position = CGPointMake(160,200);

         [self addChild:highScoreLabel];
        
       // WordData* data = [WordData sharedData];
        NSArray *wordArray = [WordData sharedData].arrayOfDataToBeStored;
        
        NSDictionary *wordDict = wordArray[0];
        
        self.wordLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%@", wordDict] dimensions: CGSizeMake(200,200) alignment:kCCTextAlignmentRight fontName:@"arial" fontSize:50];
                 self.wordLabel.position = ccp(0, 375);
                 [self addChild:self.wordLabel];
    
        
//        for (int i = 0; i < wordArray.count; i++) {
//            self.wordLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%@", wordArray[i]] dimensions: CGSizeMake(200,200) alignment:kCCTextAlignmentRight fontName:@"arial" fontSize:50];
//            self.wordLabel.position = ccp(0, 375);
//            
//            [self addChild:self.wordLabel];
//
//        }
       
        
        NSLog(@"Layer size: %f", self.size.height);
        NSLog(@"menu size: %f", menuLabel.size.height);
        
    }
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
    







@end
