//
//  FRUmpiringSystem.m
//  testA9
//
//  Created by Fred Clamp-Gray on 10/08/2014.
//  Copyright (c) 2014 Fred Clamp-Gray. All rights reserved.
//

#import "FRUmpiringSystem.h"
#import "FRAppDelegate.h"
#import <UIKit/UIKit.h>

@implementation FRUmpiringSystem

- (void) endGame{


    
    [self highScoreCheck];
    [self buttonsToControl];
    [self resetScore];

    
}




- (void) buttonsToGameplay{
    
    NSLog(@"U07A: BUTTONS SET FOR GAMEPLAY");

    
    self.buttonKey = @'0';
    
    

}



- (void) buttonsToControl{
    
    NSLog(@"U07B: BUTTONS SET FOR  CONTROL");

    
    self.buttonKey = @'1';
    
}

- (void) buttonsToIntraGameControl{
    
    self.buttonKey = @'2';
    
    NSLog(@"U07C: BUTTONS SET FOR  INTER-GAME CONTROL");


}



- (void) startGame{
    

    [self buttonsToGameplay];
   
}





- (NSNumber *) scoreFetcher{

    NSLog(@"U06: HIGH SCORE FETCHED");
    
    
    NSArray *data;
    NSString *docsDirect;
  
    data = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
   
    docsDirect = data[0];
    
    _dataPath = [[NSString alloc]initWithString:[docsDirect stringByAppendingPathComponent:@"dataArch"]];
    
    
    
       self.highScore =  [NSKeyedUnarchiver unarchiveObjectWithFile:_dataPath];
        
        return self.highScore;
        
  

    
}

- (NSNumber *) increaseScoreFullMatch{
    
    self.gameScore += 35;
    
    
    self.gameScoreWrap = [NSNumber numberWithUnsignedInteger:self.gameScore];
        NSLog(@"U02A: %@ (+35)", self.gameScoreWrap);
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"moreTime" object:nil];


    return self.gameScoreWrap;
    


}
- (NSNumber *) increaseScoreLetterMatch{
    
    self.gameScore += 5;
    self.gameScoreWrap = [NSNumber numberWithUnsignedInteger:self.gameScore];
        NSLog(@"U02B: %@ (+5)", self.gameScoreWrap);

    return self.gameScoreWrap;
    
    
    

    
}



- (NSNumber *) resetScore {
    
    self.gameScore = 0;
    
    self.gameScoreWrap = [NSNumber numberWithInteger:0];
   
    NSLog(@"U03: %@ (SCORE RESET)", self.gameScoreWrap);

    return self.gameScoreWrap;
    

    
}

    



- (void) highScoreCheck {
   
    int thisGame = [self.gameScoreWrap intValue];
    int highScore = [[self scoreFetcher] intValue];
    
    
    NSLog(@"score: %i", thisGame);
    NSLog(@"hScore: %i", highScore);


    if(thisGame >= highScore){
        
        self.highScore = self.gameScoreWrap;
        
        
        
    [NSKeyedArchiver archiveRootObject:self.highScore toFile:_dataPath];
    


        
    }else{
    
        [NSKeyedArchiver archiveRootObject:self.highScore toFile:_dataPath];
        
            
        }
    
    NSLog(@"U05: CHECKED FOR HIGH SCORE");

    
    }


@end
