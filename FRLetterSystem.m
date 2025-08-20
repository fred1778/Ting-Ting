//
//  FRLetterSystem.m
//  testA9
//
//  Created by Fred Clamp-Gray on 09/08/2014.
//  Copyright (c) 2014 Fred Clamp-Gray. All rights reserved.
//

#import "FRLetterSystem.h"
#import "FRViewController.h"

@implementation FRLetterSystem



- (NSArray *) letterArray{
    

    _letterArray = [NSArray arrayWithObjects:@"A",@"B",@"C",@"D",@"E",@"F",@"G"
                                            ,@"H",@"I",@"J",@"K",@"L",@"M",@"N"
                                            ,@"O",@"P",@"Q",@"R",@"S",@"T",@"U"
                                            ,@"V",@"X",@"W",@"Y",@"Z", nil];
    
    
    return _letterArray;
    
    
    
}


- (NSString *) letterSet{
    
    int randomIndex = arc4random_uniform((uint32_t)self.letterArray.count);
    
    return [self.letterArray objectAtIndex:randomIndex];
    
    
}

- (NSArray *) targetWordRandomSet{

    
    self.targetWordChar1 = [self letterSet];
    self.targetWordChar2 = [self letterSet];
    self.targetWordChar3 = [self letterSet];


    self.targetArray = [NSArray arrayWithObjects:self.targetWordChar1, self.targetWordChar2, self.targetWordChar3,nil];
    
    

    return self.targetArray;


}

    






@end
