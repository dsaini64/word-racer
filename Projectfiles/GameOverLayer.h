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
-(id) initWithScore:(NSInteger)score; 

@end
