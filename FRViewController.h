//
//  FRViewController.h
//  Ting
//  A Fred 2014 Endaevor
//  Created by Fred Clamp-Gray on 09/08/2014.
//  Copyright (c) 2014 Fred Clamp-Gray. All rights reserved.
//

#import <UIKit/UIKit.h>


@class FRLetterSystem;
@class FRUmpiringSystem;

@interface FRViewController : UIViewController




#pragma mark - Operational Label Properties

@property (strong, nonatomic) NSArray *labelArray;

// Outlets for gameplay target graphics...

@property (strong, nonatomic) IBOutlet UILabel *letterA;
@property (strong, nonatomic) IBOutlet UILabel *letterB;
@property (strong, nonatomic) IBOutlet UILabel *letterC;


@property (strong, nonatomic) IBOutlet UILabel *targetA;
@property (strong, nonatomic) IBOutlet UILabel *targetB;
@property (strong, nonatomic) IBOutlet UILabel *targetC;


// Property declrations for custom class instances...

@property (strong, nonatomic) FRLetterSystem *letterSystem;
@property (strong, nonatomic) FRUmpiringSystem *umpire;






#pragma mark - Timer properties

// FGTMS (Fred Game Time Management System)...

- (void) timerFireMethod:(NSTimer *)timer;
- (void) spotTimerFireMethod:(NSTimer *)spotTimer;


@property (strong, nonatomic) UIImage *S1d;
@property (strong, nonatomic) UIImage *S1;


@property (strong,nonatomic) NSTimer *UTSMasterGameTimer;

@property (strong,nonatomic) NSTimer *spotterTimer;



- (void) pause;
- (void) resume;
- (void) napStateChangeMethod:(NSNotification *)notification;
- (void) wakeyStateChangeMethod:(NSNotification *)notification;
- (void) moreTimeMethod:(NSNotification *)notification;


- (void) endGameFinal;




#pragma mark - Buttons (IBActions and IBOutlets)



- (IBAction)pauseGame;
@property (strong, nonatomic) IBOutlet UIButton *pauseOutlet;



- (IBAction)buttonA;
@property (strong, nonatomic) IBOutlet UIButton *buttonAOutlet;


- (IBAction)buttonB;
@property (strong, nonatomic) IBOutlet UIButton *buttonBOutlet;


- (IBAction)buttonC;
@property (strong, nonatomic) IBOutlet UIButton *buttonCOutlet;



- (IBAction)start:(UIButton *)sender;
@property (strong, nonatomic) IBOutlet UIButton *starter;

- (IBAction)sound;

@property (strong, nonatomic) IBOutlet UIButton *soundOutlet;

@property (strong, nonatomic) NSNumber *soundKey;


-(void) goHomeDJ;
-(void) helloDJ;

@property(strong, nonatomic) UIImage *soundOff;
@property(strong, nonatomic) UIImageView *soundOffV;


@property (strong, nonatomic) IBOutlet UIImageView *spokeA;

#pragma mark - Colour properties

@property (strong, nonatomic) IBOutlet UIImageView *S1A;
@property (strong, nonatomic) IBOutlet UIImageView *S1B;
@property (strong, nonatomic) IBOutlet UIImageView *S1C;
@property (strong, nonatomic) IBOutlet UIImageView *S2B;
@property (strong, nonatomic) IBOutlet UIImageView *S2A;
@property (strong, nonatomic) IBOutlet UIImageView *S2C;

@property (strong, nonatomic) IBOutlet UIImageView *RingA;
@property (strong, nonatomic) IBOutlet UIImageView *RingB;
@property (strong, nonatomic) IBOutlet UIImageView *RingC;


@property (strong, nonatomic) UIColor *matchRed;
@property (strong, nonatomic) UIColor *standardBlack;


#pragma mark - Game Control method declarations

- (void) compareWords;
- (void) colourCheckA;
- (void) colourCheckB;
- (void) colourCheckC;


#pragma mark - Display properties and graphical control methods

@property (strong, nonatomic) IBOutlet UILabel *score;
@property (strong, nonatomic) IBOutlet UILabel *highScore;

@property (strong, nonatomic) IBOutlet UILabel *afterGame_GameOver;

@property (strong, nonatomic) IBOutlet UILabel *afterGame_score;

@property (strong, nonatomic) IBOutlet UILabel *afterGame_highScore;

@property (strong, nonatomic) IBOutlet UILabel *gameIsPaused;
@property (strong, nonatomic) IBOutlet UILabel *tapToResume;

@property (strong, nonatomic) IBOutlet UILabel *time;

@property (strong, nonatomic) NSArray *no_HS_messages;

@property (strong, nonatomic) NSURL *soundK1URL;

@property (strong, nonatomic) NSURL *soundT1URL;

@property (strong, nonatomic) NSString *soundPathT1;
@property (strong, nonatomic) NSString *soundPathK1;


@property (strong, nonatomic) NSNumber *timeForDisplay;

- (void) prepareSounds;
- (void) prepareNotifications;

// Welcome to the new UTS (Universal Time System) property suite...

//Fixed UTS entities...

@property (assign, nonatomic) double UTSbasicTime80;
@property (assign, nonatomic) double UTSplusTime15;


//Tracker UTS entities...


@property (assign,nonatomic) double UTSelapsedTime;
@property (assign,nonatomic) double UTSextraTimeCredit;
@property (assign,nonatomic) double UTStotalGameTime;
@property (assign,nonatomic) double UTStimeLeft;



@end
