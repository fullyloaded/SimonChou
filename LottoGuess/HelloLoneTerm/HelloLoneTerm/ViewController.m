//
//  ViewController.m
//  HelloLoneTerm
//
//  Created by Jenny on 2015/11/16.
//  Copyright © 2015年 PatrickCheng. All rights reserved.
//

#import "ViewController.h"
#import "myLabel.h"
#import "myViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *myButton;
@property (weak, nonatomic) IBOutlet UISlider *slider;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) IBOutlet UIView *touch;
@property (strong, nonatomic) IBOutletCollection(myLabel) NSArray *labels;
@end

@implementation ViewController{
//    UIView * blueView;
}

- (IBAction)changeLabel:(id)sender {
    [self.labels makeObjectsPerformSelector:@selector(setText:) withObject:@"Change"];
}

- (IBAction)outside:(id)sender {
        [self.labels makeObjectsPerformSelector:@selector(setText:) withObject:@"outside"];
}

- (IBAction)addView:(id)sender {
//    UIView * blueView = [UIView new];
//    blueView.tag = 23;
    
    
//        blueView = [UIView new];
//    blueView.frame = CGRectMake(200, 150, 120, 30);
//    
//    blueView.backgroundColor = [UIColor blueColor];
//    
//    [self.view addSubview:blueView];
//
    
    NSString * filePath = @"/Users/jenny/Desktop/img.png";
    NSData * data =[NSData dataWithContentsOfFile:filePath];
    UIImage * myimage = [UIImage imageWithData:data];
    self.imageView.image = myimage;
    
}

- (IBAction)removeView:(id)sender {
    
    [UIView animateWithDuration:1.0 animations:^{
    
        self.imageView.center = CGPointMake(100, 100);
    }completion:^(BOOL finished) {
        
        
            [UIView animateWithDuration:1.0 animations:^{
                self.imageView.center = CGPointMake(150, 200);
            }];
    }];
    
    
    
    
//    [blueView removeFromSuperview];
    UIView * bView = [self.view viewWithTag:23];
    [bView removeFromSuperview];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.myButton addTarget:self action:@selector(changeColor:) forControlEvents:UIControlEventTouchDown];
    
    [self.slider addTarget:self action:@selector(changeValue:) forControlEvents:UIControlEventValueChanged];
    
}

//-(void) changeValue:(UISlider *)sender forEvent{

-(void) changeValue:(UISlider *)sender{
    CGFloat value = sender.value;
    [self.labels makeObjectsPerformSelector:@selector(setText:) withObject:[NSString stringWithFormat:@"%f",value]] ;
}

-(void)changeColor:(UIButton *) sender {
    self.view.backgroundColor = [UIColor blueColor];
}

//-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
//    NSString *
//}

-(void)home:(UIStoryboardSegue *)seque{
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
