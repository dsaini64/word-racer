
/*
 * Kobold2D™ --- http://www.kobold2d.org
 *
 * Copyright (c) 2010-2011 Steffen Itterheim, Andreas Loew 
 * Released under MIT License in Germany (LICENSE-Kobold2D.txt).
 */

//  Updated by Andreas Loew on 20.06.11:
//  * retina display
//  * framerate independency
//  * using TexturePacker http://www.texturepacker.com


#import "GameLayer.h"
#import "GameOverLayer.h"
#import "HintLayer.h"
#import "Entity.h"
#import "GenericMenuLayer.h"
#import "cocos2d.h"
#import "Lexicontext.h"
#import "WordData.h"




@implementation GameLayer

static CGRect screenRect;

static GameLayer* instanceOfGameLayer;

 

//These labels will be used to check if touch input is working
/**COMMENT THIS OUT WHEN YOU START WORK ON YOUR OWN GAME
CCLabelTTF* verifyTouchStart;
CCLabelTTF* verifyTouchAvailable;
CCLabelTTF* verifyTouchEnd;
*/


//this allows other classes in your project to query the GameLayer for the screenRect

/*+(id) scene {
    CCScene *scene = [CCScene node];
  GameLayer *layer = [GameLayer node];
    
    
}
+(CGRect) screenRect
{
	return screenRect;
}

//If another class wants to get a reference to this layer, they can by calling this method
+(GameLayer*) sharedGameLayer
{
	NSAssert(instanceOfGameLayer != nil, @"GameLayer instance not yet initialized!");
	return instanceOfGameLayer;
}*/

-(id) init
{
	if ((self = [super init]))
	{
        //sets up winSize so I can make object iPhone 5 compatible, needs to be in every method
        CGSize winSize = [CCDirector sharedDirector].winSize; 

        //this line initializes the instanceOfGameLayer variable such that it can be accessed by the sharedGameLayer method
		instanceOfGameLayer = self;
    
        //get the rectangle that describes the edges of the screen
		CGSize screenSize = [[CCDirector sharedDirector] winSize];
		screenRect = CGRectMake(0, 0, screenSize.width, screenSize.height);
		
        //Add text field
        UIView *myView = (UIView*) [[CCDirector sharedDirector] openGLView];
        self.textBox = [[UITextField alloc] initWithFrame:CGRectMake(100, 100, 220, 20)];
        [self.textBox setTextColor: [UIColor colorWithRed:255 green:0 blue:0 alpha:1.0]];
        [self.textBox setBackgroundColor:[UIColor colorWithRed:255 green:100 blue:43 alpha:1.0]];
        self.textBox.autocorrectionType = UITextAutocorrectionTypeNo;
        self.textBox.autocapitalizationType = UITextAutocapitalizationTypeNone;
        [myView addSubview:self.textBox];
        [self.textBox becomeFirstResponder];
        [self.textBox setDelegate:self];
        
        //Add skip button
//        CCLabelTTF *skipLabel = [CCLabelTTF labelWithString: @"Skip" fontName:@"Arial" fontSize:20.0f];
//        CCMenuItemLabel *item = [CCMenuItemLabel itemWithLabel:skipLabel target:self selector:@selector(skipWord)];
//        item.position = ccp(125,100);
//        CCMenu *menu = [CCMenu menuWithItems:item, nil];
//        [self addChild:menu]; 
        
        //Add question button
        CCLabelTTF *questionLabel = [CCLabelTTF labelWithString: @"?" fontName:@"Arial" fontSize:20.0f];
        CCMenuItemLabel *item2 = [CCMenuItemLabel itemWithLabel:questionLabel target:self selector:@selector(showHints)];
        item2.position = ccp(.10416 * winSize.width,100);
        CCMenu *menu2 = [CCMenu menuWithItems:item2, nil];
        
        
       // [self addChild:menu2];
        [self updateLetterAndPOS];
        self.score = 0;
        
        self.startTextLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%@", self.startText] dimensions: CGSizeMake(200,200) alignment:kCCTextAlignmentLeft fontName:@"arial" fontSize:100];
        
        self.startTextLabel.position = ccp(.229 * winSize.width, 350);
        [self addChild: self.startTextLabel];
        
        self.POSLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%@", self.partOfSpeech] dimensions: CGSizeMake(200,200) alignment:kCCTextAlignmentLeft fontName:@"arial" fontSize:20];
        
        self.POSLabel.position = ccp(.4271*winSize.width, 320);
        [self addChild: self.POSLabel];
        [self viewDidLoad];
        [self start];
        
        //This puts a ship on screen so you know you've switched to this layer and everything is loading right
        /**COMMENT THIS OUT WHEN YOU START WORK ON YOUR OWN GAME
        Entity* testEntity = [Entity createEntity];
        [testEntity setPosition: ccp(screenSize.width/2, screenSize.height/2)];
        [self addChild:testEntity z:1 tag:1];
     
        */
        
        //We've provided this code so you can check to see if touch input is working.
        /*COMMENT THIS OUT WHEN YOU START WORK ON YOUR OWN GAME
        verifyTouchStart = [CCLabelTTF labelWithString:@"Touch Started" fontName:@"arial" fontSize:20.0f];
        verifyTouchAvailable = [CCLabelTTF labelWithString:@"No Taps" fontName:@"arial" fontSize:16.0f];
        verifyTouchEnd = [CCLabelTTF labelWithString:@"Touch Ended" fontName:@"arial" fontSize:20.0f];

        verifyTouchStart.position = ccp(100,100);
        verifyTouchAvailable.position = ccp(160,300);
        verifyTouchEnd.position = ccp(400,100);
        
        
        verifyTouchStart.visible = false;
        verifyTouchEnd.visible = false;
        
        
        [self addChild: verifyTouchStart z:1 tag: TouchStartedLabelTag];
        [self addChild: verifyTouchAvailable z:1 tag: TouchAvailableLabelTag];
        [self addChild: verifyTouchEnd z:1 tag: TouchEndedLabelTag];
        */
        
        //This will schedule a call to the update method every frame
        [self scheduleUpdate];

    }
    
        
    
	return self;
}

-(void) update: (ccTime) dt
{
    KKInput *input = [KKInput sharedInput];
    
    //This will be true during the frame a new finger touches the screen
    if(input.anyTouchBeganThisFrame)
    {
        //This lets you see if the touch was registered
        /*COMMENT THIS OUT WHEN YOU START WORK ON YOUR OWN GAME
        [self getChildByTag:TouchStartedLabelTag].visible = true;*/
    }
    
    //This will be true as long as there is at least one finger touching the screen
    if(input.touchesAvailable)
    {
        //This lets you see where you are touching
        /*COMMENT THIS OUT WHEN YOU START WORK ON YOUR OWN GAME
        CGPoint pos = [input locationOfAnyTouchInPhase:KKTouchPhaseAny];
        [((CCLabelTTF*)[self getChildByTag:TouchAvailableLabelTag]) setString:[NSString stringWithFormat:@"You are tapping at %@", NSStringFromCGPoint(pos) ]];
        */
    }
    
    //This will be true during the frame a finger that was once touching the screen stops touching the screen
    if(input.anyTouchEndedThisFrame)
    {
        //This lets you see if the end of the touch was registered
        //**COMMENT THIS OUT WHEN YOU START WORK ON YOUR OWN GAME
        //[self getChildByTag:TouchEndedLabelTag].visible = true;
    }
    
  
}

-(void) dealloc
{
	instanceOfGameLayer = nil;
	
#ifndef KK_ARC_ENABLED
	// don't forget to call "super dealloc"
	[super dealloc];
#endif // KK_ARC_ENABLED
}

/* Decompose into more game logic. */
-(void) updateLetterAndPOS {
    
    // Set up the starting letter
    self.startText = [NSString stringWithFormat:@"%c", 'A' + arc4random_uniform(26)];
    
    
    
    // Set up the selected part of speech
    self.POSs = [[NSArray alloc] initWithObjects: @"Verb", @"Noun", @"Adjective", @"Adverb", nil] ;
    int randNum = arc4random() % 4;
    self.partOfSpeech = [self.POSs objectAtIndex:randNum];
    
    
}
-(void) displayLetterAndPOS  {
    //Display the Random Letter
    
    [self.startTextLabel setString:[NSString stringWithFormat:@"%@", self.startText] ];
    
    [self.POSLabel setString:[NSString stringWithFormat:@"%@", self.partOfSpeech]];    

}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if ([self checkWord:textField]) {
        self.score ++;
        self.wordValid = @"YES";
        [self storePOS:self.partOfSpeech andStartingLetter:self.startText andUserInput:self.userInput andValidity:self.wordValid];
        [self updateLetterAndPOS];
        [self displayLetterAndPOS];
        [self drawScore];
        [self drawGoodJob];
        
       
    // Maybe give user feedback like "Good job!"
    } else {
        self.wordValid = @"NO";
        [self storePOS:self.partOfSpeech andStartingLetter:self.startText andUserInput:self.userInput andValidity:self.wordValid];
        [self updateLetterAndPOS];
        [self displayLetterAndPOS];
        [self drawScore];
        [self drawIncorrect];
    }

    return textField.text = @"";
}


-(void)drawScore {
    
    //sets up winSize so I can make object iPhone 5 compatible, needs to be in every method
    CGSize winSize = [CCDirector sharedDirector].winSize;
    
    [self.scoreInfoLabel removeFromParent];
    [self.scoreLabel removeFromParent];
    self.scoreLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d", self.score] dimensions: CGSizeMake(200,200) alignment:kCCTextAlignmentRight fontName:@"arial" fontSize:50];
    self.scoreLabel.position = ccp(.4375 * winSize.width , 375);
    
    [self addChild:self.scoreLabel];

    
}

-(BOOL) checkWord: (UITextField *)textField {
    
    self.guesses++;
    self.userInput = textField.text;
    Lexicontext *dictionary = [Lexicontext sharedDictionary];
    NSDictionary *synomnyms = [dictionary thesaurusFor:self.userInput];
    if ([synomnyms objectForKey:self.partOfSpeech]){
        NSLog(@"%c",[self.userInput characterAtIndex:0]);
        NSLog(@"%c",[self.startText characterAtIndex:0]);
        self.userInput = [self.userInput capitalizedString];

        if ([self.userInput characterAtIndex:0] == [self.startText characterAtIndex:0]) {
            
        NSLog(@"Good Job!");
        return true;
    }
        else {
        NSLog(@"What you entered does NOT work");
        return false;
        }
    }
    

    
     else {
        NSLog(@"What you entered does NOT work");
        return false;
    }
}

-(void) drawGoodJob {
    //sets up winSize so I can make object iPhone 5 compatible, needs to be in every method
    CGSize winSize = [CCDirector sharedDirector].winSize;
    
    [self.goodJobLabel removeFromParent];
    [self.incorrectLabel removeFromParent];
    self.goodJobLabel =  [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Good Job!"]  fontName:@"arial" fontSize:50];
    self.goodJobLabel.position = ccp(.3333 * winSize.width, 250);
    [self addChild:self.goodJobLabel];
    [self.goodJobLabel runAction:
      [CCSequence actions:
      [CCFadeIn actionWithDuration:0.2],
      [CCDelayTime actionWithDuration:0.2],
      [CCFadeOut actionWithDuration:0.2],
      [CCCallFunc actionWithTarget:self selector:@selector(removeGoodJob)],
      nil
      ]
     ];

}

- (void) removeGoodJob{
    self.goodJobLabel.removeFromParent; 
}

- (void) drawIncorrect {
    
    //sets up winSize so I can make object iPhone 5 compatible, needs to be in every method
    CGSize winSize = [CCDirector sharedDirector].winSize;
    
    
    [self.goodJobLabel removeFromParent];
    [self.incorrectLabel removeFromParent];
    self.incorrectLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Wrong!"] fontName:@"arial" fontSize:50];
    self.incorrectLabel.position = ccp(.3333 * winSize.width, 250);
    [self addChild:self.incorrectLabel];
    [self.incorrectLabel runAction:
     [CCSequence actions:
      [CCFadeIn actionWithDuration:0.2],
      [CCDelayTime actionWithDuration:0.2],
      [CCFadeOut actionWithDuration:0.2],
      [CCCallFunc actionWithTarget:self selector:@selector(removeIncorrect)],
      nil
      ]
     ];
    
}

- (void) removeIncorrect {
    self.incorrectLabel.removeFromParent; 
}
-(void) updateTime
{
    [self.timeLabel setString:[NSString stringWithFormat:@"%d:%02d", currMinute, currSeconds]];

}

- (void)viewDidLoad
{
    
    //sets up winSize so I can make object iPhone 5 compatible, needs to be in every method
    CGSize winSize = [CCDirector sharedDirector].winSize;
    
    
    currMinute=0;
    currSeconds=90;

    self.timeLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d:%02d", currMinute, currSeconds] dimensions: CGSizeMake(200,200) alignment:kCCTextAlignmentLeft fontName:@"arial" fontSize:15];
     self.timeLabel.position = ccp(.0283 * winSize.width, 375);
    [self addChild:self.timeLabel];
    self.arrayOfWords = [[NSMutableArray alloc]init];
    self.POSArray = [[NSMutableArray alloc]init]; 

}

-(void)start
{
    timer=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerFired) userInfo:nil repeats:YES];
    
}

-(BOOL)timerFired
{
    if(currSeconds>=0 && currMinute>=0)
    {
        if(currSeconds==0)
        {
            currMinute-=1;
            currSeconds=59;
        }
        else if(currSeconds>0)
        {
            currSeconds-=1;
        }
        if(currMinute>-1){
            [self updateTime];
        }
    }
    else
    {
        [timer invalidate];
        [self gameOver];
        return true;
    }
}

    -(void)gameOver
    {
        [self.textBox removeFromSuperview];
        [[CCDirector sharedDirector] replaceScene: [[GameOverLayer alloc] initWithScore:self.score]];
        NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
        //if ([standardUserDefaults integerForKey:@"highScore"])
      //  {
            int oldScore = [standardUserDefaults integerForKey:@"highScore"];
            if (oldScore < self.score) {
                //Tell the player that they got the high score,//you can take care of this using UIAlertView or something similar//STEP 3 GOES HERE}}
                [standardUserDefaults setInteger:self.score forKey:@"highScore"];
            }

            [[CCDirector sharedDirector] replaceScene: [[GameOverLayer alloc] initWithScore:self.score]];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }

-(void) skipWord
{
    self.score --;
    [self updateLetterAndPOS];
    [self displayLetterAndPOS];
    [self drawScore];
    
}

-(void) storePOS:(NSString *)POS andStartingLetter:(NSString *)startingLetter andUserInput:(NSString *)userInput andValidity:(NSString *)wordValid {
 

    NSMutableDictionary *mutableDict = [NSMutableDictionary new];
    
    
    NSMutableArray *sampleArray = [[NSMutableArray alloc]init];
    sampleArray = [NSMutableArray arrayWithObjects:POS,startingLetter,userInput, wordValid ,nil];
    
    
    [mutableDict setObject: sampleArray[0] forKey: @"POS"];
    [mutableDict setObject: sampleArray[1] forKey: @"startingLetter"];
    [mutableDict setObject: sampleArray[2] forKey: @"userInput"];
    [mutableDict setObject: sampleArray[3] forKey: @"wordValidity"]; 
    
    [self.arrayOfWords addObject:mutableDict];
    
    WordData* data = [WordData sharedData];
    data.arrayOfDataToBeStored = self.arrayOfWords;
}
-(void) showHints {
    
    [self.textBox removeFromSuperview];
    [[CCDirector sharedDirector] replaceScene: [HintLayer alloc]];
}


    
@end