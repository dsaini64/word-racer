//
//  Tutorial.m
//  PortraitTemplate
//
//  Created by Divakar on 8/13/13.
//
//

#import "Tutorial.h"
#import "GenericMenuLayer.h"
#import "Lexicontext.h" 
#import "GameLayer.h"

@implementation Tutorial

-(id) init {
    if ((self = [super init])) {
        
        self.startText = @"A";
        self.partOfSpeech = @"Noun"; 
        
        UIView *myView = (UIView*) [[CCDirector sharedDirector] openGLView];
        self.textBox = [[UITextField alloc] initWithFrame:CGRectMake(100, 100, 220, 20)];
        [self.textBox setTextColor: [UIColor colorWithRed:255 green:0 blue:0 alpha:1.0]];
        [self.textBox setBackgroundColor:[UIColor colorWithRed:255 green:100 blue:43 alpha:1.0]];
        self.textBox.autocorrectionType = UITextAutocorrectionTypeNo;
        self.textBox.autocapitalizationType = UITextAutocapitalizationTypeNone;
        [myView addSubview:self.textBox];
        [self.textBox becomeFirstResponder];
        [self.textBox setDelegate:self];
        
        [self drawStartingLetterAndPOS]; 
        
                
        [self drawStartingLetterInstruction];
        
        
    

      
        

        
     
        
    }
    
    return self; 
}

-(void) drawStartingLetterAndPOS {
    
    [self.startTextLabel removeFromParent];
    [self.POSLabel removeFromParent];
    [self startTimer];
    
    self.startTextLabel = [CCLabelTTF labelWithString: [NSString stringWithFormat:@"%@",self.startText] dimensions: CGSizeMake(200,200) alignment:kCCTextAlignmentLeft fontName:@"arial" fontSize:100];
    
    self.startTextLabel.position = ccp(110, 350);
    [self addChild: self.startTextLabel];
    
    self.POSLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%@",self.partOfSpeech] dimensions: CGSizeMake(200,200) alignment:kCCTextAlignmentLeft fontName:@"arial" fontSize:20];
    
    self.POSLabel.position = ccp(205, 320);
    [self addChild: self.POSLabel];
    

}

-(void) drawStartingLetterInstruction {
    [self.letterInfoLabel removeFromParent];
    self.letterInfoLabel =  [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Come up \n with a word that starts \n with '%@'",self.startText]  fontName:@"arial" fontSize:12];
    self.letterInfoLabel.position = ccp(100, 320);
    [self addChild:self.letterInfoLabel];
    [self.letterInfoLabel runAction:
     [CCSequence actions:
      [CCFadeIn actionWithDuration:0.2],
      [CCDelayTime actionWithDuration:1.5],
      nil
      ]];
    
    self.POSInfoLabel =  [CCLabelTTF labelWithString:[NSString stringWithFormat:@"and is a %@",self.partOfSpeech]  fontName:@"arial" fontSize:12];
    self.POSInfoLabel.position = ccp(250, 415);
    [self addChild:self.POSInfoLabel];
    [self.POSInfoLabel runAction:
     [CCSequence actions:
      [CCFadeIn actionWithDuration:0.2],
      [CCDelayTime actionWithDuration:1.5],
      nil
      ]
     ];
    
}

- (void) removeGoodJob{
    self.goodJobLabel.removeFromParent;
}

-(void) removeIncorrect {
    self.incorrectLabel.removeFromParent; 
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if ([self checkWord:textField]) {
        [self wordCorrect];
        
        
        // Maybe give user feedback like "Good job!"
    } else {
        
        [self drawIncorrect];
    }
    
    return textField.text = @"";
}

-(BOOL) checkWord: (UITextField *)textField {
    
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

-(void) wordCorrect{
    
    if (![self.startText isEqual: @"S"] ) {
        
    
    //[self.goodJobLabel removeFromParent];
        
        [self.POSInfoLabel removeFromParent];
        [self.letterInfoLabel removeFromParent];
        self.startText = @"S";
        self.partOfSpeech = @"Adjective";

    

    self.goodJobLabel =  [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Good Job!"]  fontName:@"arial" fontSize:50];
    self.goodJobLabel.position = ccp(160, 250);
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
    
  

        [self drawStartingLetterAndPOS];
        [self drawStartingLetterInstruction];
    }
    
    else {
        
        [self.POSInfoLabel removeFromParent];
        [self.letterInfoLabel removeFromParent];
        [self.POSLabel removeFromParent];
        [self.startTextLabel removeFromParent];
        [self drawGoodJobOnly];
        [self drawTime];
    }
    
    
}

-(void) drawGoodJobOnly{
    self.goodJobLabel =  [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Good Job!"]  fontName:@"arial" fontSize:50];
    self.goodJobLabel.position = ccp(160, 250);
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
-(void) drawTime {
    self.timer = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"0:90"] dimensions: CGSizeMake(200,200) alignment:kCCTextAlignmentLeft fontName:@"arial" fontSize:15];
    self.timer.position = ccp(100, 375);
    [self addChild:self.timer];
    self.timerInfoLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Your mission is to come up with as many words as you can in 90 seconds!"] dimensions: CGSizeMake(200,200) alignment:kCCTextAlignmentLeft fontName:@"arial" fontSize:15];
    self.timerInfoLabel.position = ccp(150, 375);
    [self addChild:self.timerInfoLabel];
    [self.timerInfoLabel runAction:
     [CCSequence actions:
      [CCFadeIn actionWithDuration:0.7],
      [CCDelayTime actionWithDuration:4],
      [CCFadeOut actionWithDuration:0.2],
      [CCCallFunc actionWithTarget:self selector:@selector(startGame)],
      nil
      ]
     ];
}

    -(void) introduceQMark {
        
        [self.timerInfoLabel removeFromParent];
          self.qMarkLabel = [CCLabelTTF labelWithString:@"?" dimensions: CGSizeMake(200,200) alignment:kCCTextAlignmentLeft fontName:@"arial" fontSize:15];
        self.qMarkLabel.position = ccp(300,275);
        [self addChild:self.qMarkLabel];
        self.timerInfoLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Need help recalling the part of speeches? You'll want to tap this button!"] dimensions: CGSizeMake(200,200) alignment:kCCTextAlignmentLeft fontName:@"arial" fontSize:15];
        self.timerInfoLabel.position = ccp(200, 180);
        [self addChild:self.timerInfoLabel];
        [self.timerInfoLabel runAction:
         [CCSequence actions:
          [CCFadeIn actionWithDuration:0.7],
          [CCDelayTime actionWithDuration:3],
          [CCFadeOut actionWithDuration:0.2],
          [CCCallFunc actionWithTarget:self selector:@selector(startGame)],
          nil
          ]
         ];
}

-(void) startGame {
    
    CCLabelTTF *label = [CCLabelTTF labelWithString: @"Start Game!" fontName:@"Arial" fontSize:40.0f];
    
    
    
    CCMenuItemLabel *item = [CCMenuItemLabel itemWithLabel:label target:self selector:@selector(doSomething)];
    
    
    CCMenu *menu = [CCMenu menuWithItems:item, nil];
    
    [self addChild:menu];
    
}


- (void) drawIncorrect {
    [self.goodJobLabel removeFromParent];
    [self.incorrectLabel removeFromParent];
    self.incorrectLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Try Again!"] fontName:@"arial" fontSize:50];
    self.incorrectLabel.position = ccp(160,250);
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

-(void) startTimer {


    self.timer=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(doNothing) userInfo:nil repeats:YES];
}

-(void) doNothing {
    
    
}
-(void) doSomething {
    
    
    [self.textBox removeFromSuperview]; 
    [[CCDirector sharedDirector] replaceScene: [[GameLayer alloc] init]];
    
}



@end
