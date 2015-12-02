//
//  ViewController.m
//  HelloLongTerm
//
//  Created by Michael Pan on 2015/11/16.
//  Copyright © 2015年 Zencher. All rights reserved.
//

#import "ViewController.h"
#import "MyLabel.h"
#import "LottoGuess.h"
#import "MyViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *inputField;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UITextField *input2;
@property (weak, nonatomic) IBOutlet UITextField *input1;
@property (strong, nonatomic) IBOutletCollection(MyLabel) NSArray *labels;
@property (weak, nonatomic) IBOutlet UIButton *myBtn;
@property (weak, nonatomic) IBOutlet UISlider *slider;

@end

@implementation ViewController{
    
}
- (IBAction)removeView:(id)sender {
    
    
    
    [UIView animateWithDuration:2.0 animations:^{
        self.imageView.center = CGPointMake(100, 100);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:1.0 animations:^{
            self.imageView.center = CGPointMake(150, 200);
        }];
        
        
    }];
    
}
- (IBAction)addView:(id)sender {
    
    NSString * filePath = @"/Users/michael/Desktop/img.jpg";
    
    NSData * data = [NSData dataWithContentsOfFile:filePath];
    UIImage * myImage = [UIImage imageWithData:data];
    
    self.imageView.image = myImage;
    
}
- (IBAction)changeLabel:(id)sender {
    [self.labels makeObjectsPerformSelector:@selector(setText:) withObject:@"Changed"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.myBtn addTarget:self action:@selector(changeColor:) forControlEvents:UIControlEventTouchDown];
    
    [self.slider addTarget:self action:@selector(changeValue:forEvent:) forControlEvents:UIControlEventValueChanged];
    
    LottoGuess * lotto = [LottoGuess new];
    NSMutableArray * array = [lotto genGuessWithBase:49 andGuess:6];
    
    NSLog(@"%@",array);
}
-(void) changeValue:(UISlider *) sender forEvent:(UIEvent *) event {
    
}
-(void) changeValue:(UISlider *) sender  {
    CGFloat value = sender.value;
    [self.labels makeObjectsPerformSelector:@selector(setText:) withObject:[NSString stringWithFormat:@"%f", value]];
}
-(void) changeColor:(UIButton *) sender {
    self.view.backgroundColor = [UIColor whiteColor];
}
- (IBAction)sayHello:(id)sender {
    NSString * str1 = self.input1.text;
    
    NSString * str2 = self.input2.text;
    
    NSInteger value1 = [str1 integerValue];
    NSInteger value2 = [str2 integerValue];
    NSInteger sum = value1 + value2;
    
    [self.labels makeObjectsPerformSelector:@selector(setText:) withObject:[NSString stringWithFormat:@"%ld", (long)sum]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
//    NSLog(@"Touch in view controller");
//}
-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    NSString * text = self.inputField.text;
    
    MyViewController * myVC = segue.destinationViewController;
    myVC.data = text;
    
    
}

-(IBAction) home:(UIStoryboardSegue *)segue{
    NSLog(@"id %@",segue.identifier);
    if ([segue.sourceViewController isMemberOfClass:[MyViewController class]]){
        MyViewController * source = segue.sourceViewController;
        self.firstLabel.text = source.orangeField.text;
    }
}

@end
