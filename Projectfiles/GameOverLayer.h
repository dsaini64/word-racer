//
//  GameOverLayer.h
//  PortraitTemplate
//
//  Created by Divya on 7/26/13.
//
//

#import "CCLayer.h"

@interface GameOverLayer : CCLayer
@property (strong, nonatomic) NSDictionary *entryDictionary;
@property (strong, nonatomic) NSMutableArray *wordArray;
@property (strong, nonatomic) CCLabelTTF *wordLabel;
@property (nonatomic) CGFloat *xvalue;
@property (nonatomic) CGFloat *yvalue;
@property (nonatomic) NSNumber *timesDownPressed;
@property (nonatomic) NSNumber *timesUpPressed; 
@property (strong, nonatomic) CCLabelTTF *upLabel;
@property (strong, nonatomic) CCLabelTTF *downLabel;
@property (strong, nonatomic) CCLabelTTF *userInputLabel;
@property (nonatomic) NSUInteger *wordCount;
-(id) initWithScore:(NSInteger)score; 

@end
