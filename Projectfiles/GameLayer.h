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

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Entity.h"
#import "Lexicontext.h"

@interface Singleton
@property (nonatomic, retain) NSMutableArray *bananas;
@end


//This assigns an integer value to an arbitrarily long list, where each has a value 1 greater than the last. So here TouchAvailableLabelTag = 3 and TouchEndedLabelTag = 4
typedef enum
{
	TouchStartedLabelTag = 2,
	TouchAvailableLabelTag,
	TouchEndedLabelTag,
} LabelTags;

@interface GameLayer : CCLayer
{
    UILabel *progress;
    NSTimer *timer;
    int currMinute;
    int currSeconds;

}


@property (nonatomic, strong) NSString* startText;
@property (nonatomic, strong) NSString* partOfSpeech;
@property (nonatomic, strong) NSString* completeInput;
@property (nonatomic, strong) NSArray* POSs;
@property (nonatomic, strong) NSMutableArray *POSArray; 
@property (nonatomic, assign) NSInteger score;
@property (nonatomic,retain) NSTimer* timer;
@property (nonatomic, strong) CCLabelTTF *timeLabel;
@property (nonatomic, strong) CCLabelTTF *scoreLabel;
@property (nonatomic, strong) CCLabelTTF *scoreInfoLabel;
@property (nonatomic, strong) CCLabelTTF *POSLabel;
@property (nonatomic, strong) CCLabelTTF *startTextLabel;
@property (nonatomic, strong) UITextField *textBox;
@property (nonatomic, assign) NSInteger guesses;
@property (nonatomic, strong)CCLabelTTF *goodJobLabel;
@property (nonatomic, strong)CCLabelTTF *incorrectLabel;
@property (nonatomic, assign) NSInteger *highScore;
@property (nonatomic, strong) NSString *userInput; 
@property (nonatomic, strong) NSMutableArray *arrayOfWords;

+(CGRect) screenRect;
-(void) displayLetterAndPOS;
-(void) updateLetterAndPOS;
-(BOOL) checkWord: (UITextField *)textField;
-(void) gameOverScreen;
-(BOOL)textFieldShouldReturn: (UITextField *)textField;
-(void) drawScore;
-(void) viewDidLoad;
-(void)start;
-(BOOL)timerFired;
-(void)gameOver;

@end

