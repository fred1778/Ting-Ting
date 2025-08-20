//
//  FRViewController.m
//  Ting Ting (development name: Ting; initial name as a skills test: 'testA9')
//  A Fred 2014 project
//  Created by Fred Clamp-Gray on 09/08/2014.
//  Copyright (c) 2014 Frederick L J Clamp-Gray. All rights reserved.
//
// 2015 pre-release remodelling...


#import "FRViewController.h"
#import "FRLetterSystem.h"
#import "FRUmpiringSystem.h"
#import "FRAppDelegate.h"
#import <AudioToolbox/AudioToolbox.h>

@interface FRViewController ()

@end

@implementation FRViewController{
    
    SystemSoundID keySound1;
    SystemSoundID keySound2;
    SystemSoundID keySound3;
    SystemSoundID oneTing;
    SystemSoundID twoTing;
    
}


#pragma mark - Startup code

- (void)viewDidLoad
{

    
    // NB: New UTS time system being implentated - universal variables and only one game timer....
    
    
    
    // Initialise UTS variables...
    
    
    self.UTSbasicTime80 = 80.00;
    self.UTSplusTime15 = 15.00;
    self.UTStotalGameTime = 0.00;
    
    
    [super viewDidLoad];
    
    self.UTSelapsedTime = 0.00;

     [self helloDJ];
    
    
    self.S1A.alpha = 0;
    self.S1B.alpha = 0;
    self.S1C.alpha = 0;
    self.S2B.alpha = 0;
    self.S2A.alpha = 0;
    self.S2C.alpha = 0;
  
    self.RingA.alpha = 0;
    self.RingB.alpha = 0;
    self.RingC.alpha = 0;
    
    

    self.soundOff = [UIImage imageNamed:@"soundOff1"];
    self.soundOffV =[[UIImageView alloc]initWithImage:self.soundOff];
    
    
    
    
    [self prepareSounds];
    
    
    
    
    [self prepareNotifications];
    
    
    
#pragma mark - Startup initilaisations
    
// For some reason, the CIColour RGBA system doesn't work on actual iOS devices, but it seems you don't actually need CIColour to define an RGBA colour - you can call a method directly on UIColour that achieves the same thing...
    
    
    self.matchRed =  [[UIColor alloc]init];
    
  self.matchRed =  [UIColor colorWithRed:0.6902 green:0.1255 blue:0.0 alpha:1.0];
    
    
    
    
    self.standardBlack = [UIColor blackColor];
 
    self.umpire = [[FRUmpiringSystem alloc]init];
    
    self.umpire.buttonKey = @'1';
    
    
    self.letterSystem = [[FRLetterSystem alloc]init];
  
#pragma mark - UI design initial set up

   
    self.targetA.font = [UIFont fontWithName:@"Kingthings Trypewriter 2" size:75];
    self.targetB.font = [UIFont fontWithName:@"Kingthings Trypewriter 2" size:75];
    self.targetC.font = [UIFont fontWithName:@"Kingthings Trypewriter 2" size:75];
    self.letterA.font = [UIFont fontWithName:@"Gravity-Bold" size:52];
    self.letterB.font = [UIFont fontWithName:@"Gravity-Bold" size:52];
    self.letterC.font = [UIFont fontWithName:@"Gravity-Bold" size:52];

   
    
    
    self.afterGame_GameOver.font = [UIFont fontWithName:@"Kingthings Trypewriter 2" size:50];
    self.afterGame_score.font = [UIFont fontWithName:@"Kingthings Trypewriter 2" size:26];
    self.afterGame_highScore.font = [UIFont fontWithName:@"Kingthings Trypewriter 2" size:24];
    
    self.afterGame_GameOver.alpha = 0.0;
    self.afterGame_score.alpha = 0.0;
    self.afterGame_highScore.alpha = 0.0;

    self.gameIsPaused.alpha = 0.0;
    self.tapToResume.alpha = 0.0;
    
    self.gameIsPaused.font = [UIFont fontWithName:@"Kingthings Trypewriter 2" size:50];
    self.tapToResume.font = [UIFont fontWithName:@"Kingthings Trypewriter 2" size:30];
    [self.gameIsPaused setTextColor:self.matchRed];
    [self.tapToResume setTextColor:self.standardBlack];


    
    [self.highScore setTextColor:self.matchRed];
    
    
    self.score.font = [UIFont fontWithName:@"Kingthings Trypewriter 2" size:30];
    self.highScore.font = [UIFont fontWithName:@"Kingthings Trypewriter 2" size:25];
    
    
        self.letterA.alpha = 0.00;
        self.letterB.alpha = 0.00;
        self.letterC.alpha = 0.00;
        self.targetA.alpha = 0.00;
        self.targetB.alpha = 0.00;
        self.targetC.alpha = 0.00;
    
    
    self.buttonAOutlet.alpha = 0.0;
    self.buttonBOutlet.alpha = 0.0;
    self.buttonCOutlet.alpha = 0.0;

    self.pauseOutlet.alpha = 0.0;
    self.soundOutlet.alpha = 0.0;


    self.highScore.alpha = 0.0;
    self.score.alpha = 0.0;
    
    
    self.time.alpha = 0.0;
    self.time.font = [UIFont fontWithName:@"Kingthings Trypewriter 2" size:34];
    
    
 self.highScore.text = [[self.umpire scoreFetcher] stringValue];
    
    NSLog(@"%@", self.umpire.highScore);
    
    
    self.no_HS_messages = [NSArray arrayWithObjects:@"Not your best",@"You've done better",@"Is that your best?",@"Could do better", nil];
    
    
}

#pragma mark - Main Timer Fire method


- (void) timerFireMethod:(NSTimer *)timer{
    
    
    
    if(self.UTSextraTimeCredit == 0.00){
    
        [self endGameFinal];
        
        NSLog(@")TIMER FIRED - GAME ENDED AS NO ET CREDIT");

        
    } else {
        
        
        
        // Initialising the master timer with the UTSextraTimeCredit if it is above zero...
        
        self.UTSMasterGameTimer = [NSTimer scheduledTimerWithTimeInterval:self.UTSextraTimeCredit target:self selector:@selector(timerFireMethod:) userInfo:nil repeats:NO];
        
        NSLog(@")TIMER FIRED BUT RE-INITIALISING WITH EXTRA TIME");
        
        
                self.UTSextraTimeCredit = 0.00;

    }
    
    

    
    
        
  
}

#pragma mark - Compare words method


    - (void) compareWords{
    
        NSLog(@"V02: WORDS COMPARED");
        
        
        // Stithcing together the seprate one-charcter NSString properties to make three-character scoped NSStrings for compaprision in this method.
        
        
    NSString *labelResult = [[[NSString stringWithString:self.letterA.text] stringByAppendingString:self.letterB.text] stringByAppendingString:self.letterC.text];
  
        
        NSString *targetResult = [[[NSString stringWithString:self.targetA.text] stringByAppendingString:self.targetB.text] stringByAppendingString:self.targetC.text];

        
        
        
        if([labelResult isEqualToString:targetResult]){
            
            
   

        
            [self.letterSystem targetWordRandomSet];
            
            self.targetA.text = [self.letterSystem.targetArray objectAtIndex:0];
            self.targetB.text = [self.letterSystem.targetArray objectAtIndex:1];
            self.targetC.text = [self.letterSystem.targetArray objectAtIndex:2];
            
            
            
  
            self.score.text = [[self.umpire increaseScoreFullMatch] stringValue];
            
            [self colourCheckA];
            [self colourCheckB];
            [self colourCheckC];

            
        }
        
    }


#pragma mark - Colour Check methods

- (void) colourCheckA {

    NSLog(@"V03A: LINE A CHECKED");
    

   if([self.letterA.text isEqualToString:self.targetA.text]){
       
       
       
       if([self.soundKey isEqualToNumber:@'1']){

       AudioServicesPlaySystemSound(oneTing);
           
       }
       
       
       [self.letterA setTextColor:self.matchRed];
       [self.targetA setTextColor:self.matchRed];
       
       self.score.text = [[self.umpire increaseScoreLetterMatch]stringValue];
       
       
       
       
    } else {
        
        [self.letterA setTextColor:self.standardBlack];
        [self.targetA setTextColor:self.standardBlack];
   
    }
    
}

- (void) colourCheckB{
    
    NSLog(@"V03B: LINE B CHECKED");


    if([self.letterB.text isEqualToString:self.targetB.text]){

        
        if([self.soundKey isEqualToNumber:@'1']){

        AudioServicesPlaySystemSound(oneTing);
            
        }
        
        [self.letterB setTextColor:self.matchRed];
        [self.targetB setTextColor:self.matchRed];
        self.score.text = [[self.umpire increaseScoreLetterMatch]stringValue];


        } else {
            
            [self.letterB setTextColor:self.standardBlack];
            [self.targetB setTextColor:self.standardBlack];
        }
}

- (void) colourCheckC{
    
    NSLog(@"V03C: LINE C CHECKED");


    if([self.letterC.text isEqualToString:self.targetC.text]){
        
        if([self.soundKey isEqualToNumber:@'1']){

        
        AudioServicesPlaySystemSound(oneTing);
        }

        [self.letterC setTextColor:self.matchRed];
        [self.targetC setTextColor:self.matchRed];
        self.score.text = [[self.umpire increaseScoreLetterMatch]stringValue];

        
    } else {
        
        [self.letterC setTextColor:self.standardBlack];
        [self.targetC setTextColor:self.standardBlack];
}
    
}
    

    

#pragma mark - memoryWarningMethod



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Game start code


- (IBAction)start:(UIButton *)sender {

    
    NSLog(@"V04: GAME INITIATED BY USER");

    
    if([self.umpire.buttonKey isEqual:@'1']){

        self.UTSextraTimeCredit = 0.00;
        self.UTStotalGameTime = self.UTSbasicTime80;
        self.UTSelapsedTime = 0.00;
        self.UTStimeLeft = 0.00;
        

        
        [self.umpire scoreFetcher];
        self.highScore.text = [[self.umpire scoreFetcher] stringValue];

        if([self.umpire scoreFetcher]== NULL){
            
            self.highScore.text = @"0";
            
        }
        
        
        [self.letterA setTextColor:self.standardBlack];
        [self.targetA setTextColor:self.standardBlack];
        [self.letterB setTextColor:self.standardBlack];
        [self.targetB setTextColor:self.standardBlack];
        [self.letterC setTextColor:self.standardBlack];
        [self.targetC setTextColor:self.standardBlack];
    
    self.score.text = [[self.umpire resetScore]stringValue];

    self.time.text = @"80";
        
    [self.time setTextColor:self.standardBlack];

    [self.letterSystem targetWordRandomSet];
  
    
    self.targetA.text = [self.letterSystem.targetArray objectAtIndex:0];

    self.targetB.text = [self.letterSystem.targetArray objectAtIndex:1];
    
    self.targetC.text = [self.letterSystem.targetArray objectAtIndex:2];
    
   [UIView animateWithDuration:1.2 animations:^{

        self.afterGame_GameOver.alpha = 0.0;
        self.afterGame_score.alpha = 0.0;
        self.afterGame_highScore.alpha = 0.0;
        
       }];
        

        [UIView animateWithDuration:2.0 animations:^{
            
            self.letterA.alpha = 1.0;
            self.letterB.alpha = 1.0;
            self.letterC.alpha = 1.0;
            self.targetA.alpha = 1.0;
            self.targetB.alpha = 1.0;
            self.targetC.alpha = 1.0;
            
            self.time.alpha = 1.0;
            
            self.buttonAOutlet.alpha = 1.0;
            self.buttonBOutlet.alpha = 1.0;
            self.buttonCOutlet.alpha = 1.0;
            self.highScore.alpha = 1.0;

            self.starter.alpha = 0.0;
            self.pauseOutlet.alpha = 1.0;
            self.soundOutlet.alpha = 1.0;

            self.score.alpha = 1.0;
            
            self.S1A.alpha = 0.3;
            self.S1B.alpha = 0.3;
            self.S1C.alpha = 0.3;
            self.S2B.alpha = 0.3;
            self.S2A.alpha = 0.3;
            self.S2C.alpha = 0.3;
            
            self.RingA.alpha = 0.7;
            self.RingB.alpha = 0.7;
            self.RingC.alpha = 0.7;
            
            
        }];
        
     
    [self.umpire startGame];
        
        
        //Starting the timers...
        
        
        
    self.UTSMasterGameTimer = [NSTimer scheduledTimerWithTimeInterval:self.UTSbasicTime80 target:self selector:@selector(timerFireMethod:) userInfo:nil repeats:NO];
        
        self.spotterTimer = [NSTimer scheduledTimerWithTimeInterval:1.00 target:self selector:@selector(spotTimerFireMethod:) userInfo:nil repeats:YES];

    }
    
   
}


#pragma mark - Main game button methods



- (IBAction)pauseGame {
    if([self.umpire.buttonKey  isEqual: @'0']){

    [self pause];
    
    } else if([self.umpire.buttonKey  isEqual: @'2']){
        
       
        
        
        
        [self resume];
        
    }
    
}

- (IBAction)buttonA {

    if([self.umpire.buttonKey  isEqual: @'0']){
      
        
        
        [UIView animateWithDuration:0.5 animations:^{
        
            self.S1A.alpha = 0.7;
            self.S2A.alpha = 1.0;
            self.RingA.alpha = 1.0;
            
            
            
        }];
        
        
        
        if([self.soundKey isEqualToNumber:@'1']){

        AudioServicesPlaySystemSound(keySound1);
        }
        
    self.letterA.text = [self.letterSystem letterSet];
        
        
       
        
        
        [self colourCheckA];
        
    [self compareWords];
        
        

        [UIView animateWithDuration:0.5 animations:^{
            
            self.S1A.alpha = 0.3;
            self.S2A.alpha = 0.3;
            self.RingA.alpha = 0.7;
            
            
            
        }];
        
    


     }
    

}


- (IBAction)buttonB {
    
    if([self.umpire.buttonKey  isEqual: @'0']){
        
        
        
        [UIView animateWithDuration:0.5 animations:^{
            
            self.S1B.alpha = 0.7;
            self.S2B.alpha = 1.0;
            self.RingB.alpha = 1.0;
            
            
            
        }];
        
        if([self.soundKey isEqualToNumber:@'1']){


        AudioServicesPlaySystemSound(keySound1);
            
            
        }
    
    self.letterB.text = [self.letterSystem letterSet];
  
        [self colourCheckB];
        
    [self compareWords];

        
        [UIView animateWithDuration:0.5 animations:^{
            
            self.S1B.alpha = 0.3;
            self.S2B.alpha = 0.3;
            self.RingB.alpha = 0.7;
            
            
            
        }];
        
  
    }

}


- (IBAction)buttonC {
    
    if([self.umpire.buttonKey  isEqual: @'0']){

        
        
        [UIView animateWithDuration:0.5 animations:^{
            
            self.S1C.alpha = 0.7;
            self.S2C.alpha = 1.0;
            self.RingC.alpha = 1.0;
            
            
        }];
        
        if([self.soundKey isEqualToNumber:@'1']){
            
        
        
        AudioServicesPlaySystemSound(keySound1);
            
            
        }
    
   self.letterC.text = [self.letterSystem letterSet];
   
        
        [self colourCheckC];
        
    [self compareWords];

        
        [UIView animateWithDuration:0.5 animations:^{
            
            self.S1C.alpha = 0.3;
            self.S2C.alpha = 0.3;
            self.RingC.alpha = 0.7;
            
            
            
            
        }];
        
        
    
    }

    
    
    
    
    

}

// I'm quite proud of the timeSpotter game control system :) !!

#pragma mark - Game time control system methods

-(void) pause{
    
    if([self.umpire.buttonKey  isEqual: @'0']){

    [self.spotterTimer invalidate];

        [self.UTSMasterGameTimer invalidate];
    
        
        
    [self.umpire buttonsToIntraGameControl];
    
    [UIView animateWithDuration:1.0 animations:^{
        
        
        self.letterA.alpha = 0.0;
        self.letterB.alpha = 0.0;
        self.letterC.alpha = 0.0;
        self.targetA.alpha = 0.0;
        self.targetB.alpha = 0.0;
        self.targetC.alpha = 0.0;
        
        self.buttonAOutlet.alpha = 0.0;
        self.buttonBOutlet.alpha = 0.0;
        self.buttonCOutlet.alpha = 0.0;
        self.score.alpha = 0.0;
        self.highScore.alpha = 0.0;

        self.pauseOutlet.alpha = 0.0;

        self.S1A.alpha = 0;
        self.S1B.alpha = 0;
        self.S1C.alpha = 0;
        self.S2B.alpha = 0;
        self.S2A.alpha = 0;
        self.S2C.alpha = 0;
        
        self.RingA.alpha = 0;
        self.RingB.alpha = 0;
        self.RingC.alpha = 0;


      
        
    }];

    [UIView animateWithDuration:1.2 animations:^{
        

        
        self.gameIsPaused.alpha = 1.0;
        self.tapToResume.alpha = 1.0;
        
        
    }];
    NSLog(@"V05: GAME PAUSED");

    } }


- (void) resume{
    
    if([self.umpire.buttonKey  isEqual: @'2']){

        
        
        
        
        
        [UIView animateWithDuration:1.3 animations:^{
            
            
            self.gameIsPaused.alpha = 0.0;
            self.tapToResume.alpha = 0.0;
            
            
            
        }];
        
        [UIView animateWithDuration:1.6 animations:^{
            
            
            self.letterA.alpha = 1.0;
            self.letterB.alpha = 1.0;
            self.letterC.alpha = 1.0;
            self.targetA.alpha = 1.0;
            self.targetB.alpha = 1.0;
            self.targetC.alpha = 1.0;
            
            self.buttonAOutlet.alpha = 1.0;
            self.buttonBOutlet.alpha = 1.0;
            self.buttonCOutlet.alpha = 1.0;
            self.score.alpha = 1.0;
            self.highScore.alpha = 1.0;

            self.pauseOutlet.alpha = 1.0;
            
            
            self.S1A.alpha = 0.3;
            self.S1B.alpha = 0.3;
            self.S1C.alpha = 0.3;
            self.S2B.alpha = 0.3;
            self.S2A.alpha = 0.3;
            self.S2C.alpha = 0.3;
            
            self.RingA.alpha = 0.7;
            self.RingB.alpha = 0.7;
            self.RingC.alpha = 0.7;

            
            
            
        }];
        
        
        

        
            
            
        
            
            NSLog(@"ELAPSED: %f  TOTAL ETG: %f  RESUMING WITH  %f", self.UTSelapsedTime, self.UTStotalGameTime, self.UTStimeLeft);
            
        
        // With the resumption time figured out, the timer needs to be re-intialised...
        
        
    
   
        self.UTSMasterGameTimer = [NSTimer scheduledTimerWithTimeInterval:self.UTStimeLeft target:self selector:@selector(timerFireMethod:) userInfo:nil repeats:NO];
        
            
    
    
        
        self.spotterTimer = [NSTimer scheduledTimerWithTimeInterval:1.00 target:self selector:@selector(spotTimerFireMethod:) userInfo:nil repeats:YES];
        
        
        
        
        [self.umpire buttonsToGameplay];
        
        
        //  This reset needs to be done otherwise the main timer will add the time again when it fires, even though it was re-initalised with the extra time taken into account under the remit of the 'timeLeft' variable which is calculated in real time as part of the spotter timer fire method.
        
        self.UTSextraTimeCredit = 0.00;
        
        
    
    }
}




- (void) spotTimerFireMethod:(NSTimer *)spotTimer{
    
    // Keeping the elapsed time...
    
    self.UTSelapsedTime += 1.0;
    NSLog(@"VO7: Playtime: %f", self.UTSelapsedTime);
   
    //...and working out the other UTS time parameters...
    
    
    self.UTStimeLeft = self.UTStotalGameTime - self.UTSelapsedTime;
    
    
    
    self.timeForDisplay = [NSNumber numberWithDouble:self.UTStimeLeft];
    
    if(self.UTStimeLeft < 11){
        
        [self.time setTextColor:self.matchRed];
        
        
    } else {
        [self.time setTextColor:self.standardBlack];
    }
    
    
    self.time.text = [self.timeForDisplay stringValue];
    
    
    
}
- (void) napStateChangeMethod:(NSNotification *)notification{
    
    
    [self pause];
    
    
    
}

- (void) wakeyStateChangeMethod:(NSNotification *)notification{
    
    
    [self resume];
    
}

-(void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    
    if([self.umpire.buttonKey  isEqual: @'2']){

        

    
        [self resume];
    }
}


- (void) moreTimeMethod:(NSNotification *)notification{
    
    // Keeping the initlaistion UTS variable (timeCredit) up to date for use in timers, and keeping the EGT (Entitled Game Time) up to date...
    
    
    self.UTSextraTimeCredit += self.UTSplusTime15;
    
    self.UTStotalGameTime += 15.00;
    
    
    
    
   
    
    
    [UIView animateWithDuration:0.9 animations:^{
        
        
        self.time.alpha = 0;
        
        
    }];
    [UIView animateWithDuration:0.9 animations:^{
        
        
        self.time.alpha = 1;
        
        
     }];
    

    
    NSLog(@"ET ADDED - EGT: %f", self.UTStotalGameTime);
    
    
    
}


#pragma mark - Audio Control Systems




- (IBAction)sound {
    
    if([self.soundKey isEqualToNumber:@'1']){
        
        
        [self goHomeDJ];
        
        
        NSLog(@"SOUND OFF");
        
    } else {
        

        [self helloDJ];
        
        
        NSLog(@"SOUND ON");

        
    }
    
    
}

-(void) goHomeDJ{
    
    self.soundKey = @'0';
    

    self.soundOutlet.alpha = 0.4;
    
    
    
    
    
}
-(void) helloDJ{
    
    self.soundKey = @'1';
    
    self.soundOutlet.alpha = 1;

    
}

#pragma mark - Game End Code


- (void) endGameFinal{
    
    
    [self.spotterTimer invalidate];
    
    
    self.UTSelapsedTime = 0.00;

    self.UTStimeLeft = 80.00;
    
    NSLog(@"V01: GAME OVER");
    
    
    [self.umpire highScoreCheck];
    int messageArrayIndex = arc4random_uniform((uint32_t)self.no_HS_messages.count);

    
    NSString *score = @"Score: ";
    NSString *newHighScore = @"New High Score!";
    NSString *notHighScore = [self.no_HS_messages objectAtIndex:(messageArrayIndex)];
    
    
    
    
    self.afterGame_score.text = [score stringByAppendingString:self.score.text ];
    
    
    [self.afterGame_highScore setTextColor:self.matchRed];
    
    
    if([self.umpire.gameScoreWrap isEqualToValue:self.umpire.highScore]){
        
        
        self.afterGame_highScore.text = newHighScore;
    }
    
    else {
        
        
        self.afterGame_highScore.text = notHighScore;
        
        
    }
    
    
    [self.umpire endGame];
    
    [UIView animateWithDuration:1.6 animations:^{
        
        
        self.letterA.alpha = 0.0;
        self.letterB.alpha = 0.0;
        self.letterC.alpha = 0.0;
        self.targetA.alpha = 0.0;
        self.targetB.alpha = 0.0;
        self.targetC.alpha = 0.0;
        
        self.buttonAOutlet.alpha = 0.0;
        self.buttonBOutlet.alpha = 0.0;
        self.buttonCOutlet.alpha = 0.0;
        self.score.alpha = 0.0;
        self.pauseOutlet.alpha = 0.0;
        self.soundOutlet.alpha = 0.0;
        
        self.highScore.alpha = 0.0;

        self.time.alpha = 0.0;
        
        
        self.S1A.alpha = 0;
        self.S1B.alpha = 0;
        self.S1C.alpha = 0;
        self.S2B.alpha = 0;
        self.S2A.alpha = 0;
        self.S2C.alpha = 0;
        
        self.RingA.alpha = 0;
        self.RingB.alpha = 0;
        self.RingC.alpha = 0;
        
    }];
    [UIView animateWithDuration:2.0 animations:^{
        
        
        self.starter.alpha = 1.0;
        
        self.afterGame_GameOver.alpha = 1.0;
        self.afterGame_score.alpha = 1.0;
        self.afterGame_highScore.alpha = 1.0;
        
    }];
    

    
    
    
    
}

#pragma mark - Game Length control


// Creating memory URLs for the sound files. This method is flagged for memory leaks, likley due to the tolled CF bridging confusing ARC count values for the sound objects.


- (void) prepareSounds{
    
    
    self.soundPathK1 = [[NSBundle mainBundle] pathForResource:@"key3" ofType:@"aiff"];
    
    self.soundK1URL = [NSURL fileURLWithPath:self.soundPathK1];
    
    AudioServicesCreateSystemSoundID(CFBridgingRetain(self.soundK1URL), &keySound1);
    
    
    
    
    self.soundPathT1 = [[NSBundle mainBundle] pathForResource:@"ting1" ofType:@"aiff"];
    
    self.soundT1URL = [NSURL fileURLWithPath:self.soundPathT1];
    
    AudioServicesCreateSystemSoundID(CFBridgingRetain(self.soundT1URL), &oneTing);
    
    


    
    

}

- (void) prepareNotifications{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(napStateChangeMethod:)name:@"Nap" object: nil];
    
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(wakeyStateChangeMethod:)name:@"Wakey" object: nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moreTimeMethod:)name:@"moreTime" object: nil];

}



@end





// I'll answer the throng - let life be short - else shame shall be too long!

// FRED IN AETURNUM MMXV  /  FRED REX MMXIV

