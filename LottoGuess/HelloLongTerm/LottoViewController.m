//
//  LottoViewController.m
//  HelloLongTerm
//
//  Created by Michael Pan on 2015/11/16.
//  Copyright © 2015年 Zencher. All rights reserved.
//

#import "LottoViewController.h"
#import "LottoGuess.h"
@interface LottoViewController ()
@property (weak, nonatomic) IBOutlet UITextField *baseInput;
@property (weak, nonatomic) IBOutlet UITextField *guessInput;

@end

@implementation LottoViewController
- (IBAction)genNumbers:(id)sender {
    
    NSInteger base = [self.baseInput.text integerValue];
    NSInteger guess = [self.guessInput.text integerValue];
    
    LottoGuess * lotto = [LottoGuess new];
    
    NSMutableArray * numbers = [lotto genGuessWithBase:base andGuess:guess];
    
    NSSortDescriptor * descripter = [NSSortDescriptor sortDescriptorWithKey:@"integerValue" ascending:NO ];
    [numbers sortUsingDescriptors:@[descripter]];
    NSLog(@"%@",numbers);
    
    UILabel * label = [UILabel new];
    label.backgroundColor = [UIColor whiteColor];
    label.frame = CGRectMake(20, 300 + 400, 320, 50);
    
    NSMutableString * mStr = [NSMutableString string];
    for (int index = 0 ; index < numbers.count ; index++) {
        [mStr appendFormat:@"%@,", numbers[index]];
    }
    label.text = mStr;
    
    
    [self.view addSubview:label];
    
    [UIView animateWithDuration:1.0 animations:^{
        label.frame = CGRectMake(20, 300, 320, 50);
    }];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
