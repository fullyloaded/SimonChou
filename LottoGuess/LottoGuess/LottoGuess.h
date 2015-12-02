//
//  LottoGuess.h
//  HelloLongTerm
//
//  Created by Michael Pan on 2015/11/16.
//  Copyright © 2015年 Zencher. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LottoGuess : NSObject{
    BOOL reversed;
}
@property (nonatomic) NSInteger numOfBase;
@property (nonatomic) NSInteger numOfGuess;
@property (nonatomic, retain) NSMutableArray * lottoBalls;
@property (nonatomic, retain) NSMutableArray * guessBalls;
@property (nonatomic, retain) NSMutableArray * restBalls;
-(NSMutableArray *) genGuessWithBase:(NSInteger) baseNumber andGuess:(NSInteger) guessNumber;
@end

