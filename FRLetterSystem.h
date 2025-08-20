//
//  FRLetterSystem.h
//  testA9
//
//  Created by Fred Clamp-Gray on 09/08/2014.
//  Copyright (c) 2014 Fred Clamp-Gray. All rights reserved.
//

#import <Foundation/Foundation.h>
@class FRViewController;

@interface FRLetterSystem : NSObject




@property(strong, nonatomic) NSArray *letterArray;
@property(strong, nonatomic) NSString *targetWordChar1;
@property(strong, nonatomic) NSString *targetWordChar2;
@property(strong, nonatomic) NSString *targetWordChar3;
@property(strong, nonatomic) NSArray *targetArray;



- (NSString *) letterSet;
- (NSArray *) targetWordRandomSet;


@end
