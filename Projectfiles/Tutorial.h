//
//  Tutorial.h
//  PortraitTemplate
//
//  Created by Divya on 8/13/13.
//
//

#import "CCLayer.h"

@interface Tutorial : CCLayer
@property (strong, nonatomic) UITextField *textBox;
@property (strong, nonatomic) CCLabelTTF *startTextLabel;
@property (strong, nonatomic) CCLabelTTF *POSLabel;
@property (strong, nonatomic) CCLabelTTF *POSInfoLabel; 
@property (nonatomic, strong)CCLabelTTF *goodJobLabel;
@property (strong, nonatomic) CCLabelTTF *incorrectLabel; 
@property (strong, nonatomic) CCLabelTTF *letterInfoLabel;
@property (strong, nonatomic) NSString *userInput;
@property (strong, nonatomic) NSString *completeInput;
@property (strong, nonatomic) NSString *startText;
@property (strong, nonatomic) NSString *partOfSpeech;
@property (strong, nonatomic) CCLabelTTF *timer;
@property (strong, nonatomic) CCLabelTTF *timerInfoLabel;
@property (strong, nonatomic) CCLabelTTF *qMarkLabel;
@property (strong, nonatomic) CCLabelTTF *startGameLabel;
-(id) init; 

@end
