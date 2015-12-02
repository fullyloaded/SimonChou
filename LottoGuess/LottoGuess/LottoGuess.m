//
//  LottoGuess.m
//  HelloLongTerm
//
//  Created by Michael Pan on 2015/11/16.
//  Copyright © 2015年 Zencher. All rights reserved.
//

#import "LottoGuess.h"

@implementation LottoGuess
-(NSMutableArray *) genGuessWithBase:(NSInteger) baseNumber andGuess:
(NSInteger) guessNumber{
    reversed = NO;
    if (baseNumber < guessNumber) {
        NSLog(@"base number must be bigger than guess number");
        return nil; }
    if (guessNumber > baseNumber/2) {
        self.numOfGuess = baseNumber - guessNumber;
        reversed = YES;
    }else{
        self.numOfGuess = guessNumber;
    }
    self.numOfBase = baseNumber;
    [self genGuessBalls];
    if(reversed){
        return self.restBalls;
    }
    return self.guessBalls;
}

-(void) genGuessBalls{
    self.lottoBalls = [NSMutableArray arrayWithCapacity:self.numOfBase];
    self.guessBalls = [NSMutableArray arrayWithCapacity:self.numOfGuess];
    for (NSInteger ballValue = 0 ; ballValue < self.numOfBase; ballValue++) {
        [self.lottoBalls addObject:[NSNumber numberWithInteger:(ballValue+1)]];
    }
    for (NSInteger guessOrder = 0 ; guessOrder < self.numOfGuess; guessOrder++) {
        NSNumber * selectedNumber = [self.lottoBalls objectAtIndex:(arc4random() % (self.numOfBase - guessOrder) )];
        [self.guessBalls addObject:selectedNumber];
        [self.lottoBalls removeObject:selectedNumber];
    }
    self.restBalls = self.lottoBalls;
}
@end
