//
//  FRUmpiringSystem.h
//  Ting
//
//  Created by Fred Clamp-Gray on 10/08/2014.
//  Copyright (c) 2014 Fred Clamp-Gray. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FRAppDelegate.h"


@interface FRUmpiringSystem : NSObject 


@property (strong,nonatomic) NSNumber *buttonKey;

@property (assign, nonatomic) NSInteger gameScore;
@property (strong, nonatomic) NSNumber *gameScoreWrap;

@property (retain, nonatomic) NSNumber *highScore;

@property (strong, nonatomic) NSString *dataPath;

- (void) startGame;
- (void) endGame;


- (void) buttonsToGameplay;
- (void) buttonsToControl;
- (void) buttonsToIntraGameControl;





- (NSNumber *) increaseScoreFullMatch;
- (NSNumber *) increaseScoreLetterMatch;




- (NSNumber *) resetScore;
- (void) highScoreCheck;
- (NSNumber *) scoreFetcher;




@end
