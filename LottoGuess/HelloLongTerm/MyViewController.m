//
//  MyViewController.m
//  HelloLongTerm
//
//  Created by Michael Pan on 2015/11/16.
//  Copyright © 2015年 Zencher. All rights reserved.
//

#import "MyViewController.h"

@interface MyViewController ()

@end

@implementation MyViewController


//-(void) loadView{
//    [super loadView];
//    
//    self.view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
//    self.view.backgroundColor = [UIColor grayColor];
//    
//    
//}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.myLabel.text = self.data;
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
