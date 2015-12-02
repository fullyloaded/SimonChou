//
//  NoteViewController.m
//  NoteApp
//
//  Created by Vincent on 2015/10/13.
//  Copyright © 2015年 Vincent. All rights reserved.
//

#import "NoteViewController.h"

@interface NoteViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *cameraItem;
@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;
@property(nonatomic) NSLayoutConstraint *imageHeightRatioConstraint;
@end

@implementation NoteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.textView.text = self.currentNote.text;
    self.imageView.image = self.currentNote.image;
    
    self.imageView.layer.borderWidth = 10;
    self.imageView.layer.borderColor = [UIColor blueColor].CGColor;
    
    NSLog(@"toolbar contentSize %@",NSStringFromCGSize(self.toolbar.intrinsicContentSize));
    NSLog(@"imageView contentSize %@",NSStringFromCGSize(self.imageView.intrinsicContentSize));
    NSLog(@"textView contentSize %@",NSStringFromCGSize(self.textView.intrinsicContentSize));
    
    self.imageHeightRatioConstraint =
    [NSLayoutConstraint constraintWithItem:self.imageView
                                 attribute:NSLayoutAttributeHeight
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.imageView
                                 attribute:NSLayoutAttributeWidth
                                multiplier:0.75
                                  constant:0];
    //直向時，才加這個條件
    if ( self.traitCollection.verticalSizeClass == UIUserInterfaceSizeClassRegular ){
        [self.imageView addConstraint:self.imageHeightRatioConstraint];
    }
}

-(UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskAllButUpsideDown;
}


-(void)willTransitionToTraitCollection:(UITraitCollection *)newCollection withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator{
    //高度為compact表示為橫向
    if ( newCollection.verticalSizeClass == UIUserInterfaceSizeClassCompact ){
        //橫向，移除4:3
        [self.imageView removeConstraint:self.imageHeightRatioConstraint];
    }else{
        //其它，確認4:3 constraint要在imageView中
        if ( ![self.imageView.constraints containsObject:self.imageHeightRatioConstraint]){
            [self.imageView addConstraint:self.imageHeightRatioConstraint];
        }
    }
    
    [self.toolbar invalidateIntrinsicContentSize];
}


- (IBAction)done:(id)sender {
    
    self.currentNote.text = self.textView.text;
    //self.currentNote.image = self.imageView.image;
    
    //把照片存到Documents
    // sdfs-dsfsdf-fsdfsdf-fds.jpg (UUID)
    NSUUID *uuid = [NSUUID UUID];
    self.currentNote.imageName = [NSString stringWithFormat:@"%@.jpg",[uuid UUIDString]];
    
    //組檔案路徑
    NSString *documentPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSString *imagePath = [documentPath stringByAppendingPathComponent:self.currentNote.imageName];
    //轉成NSData (JPEG格式）
    NSData *imageData = UIImageJPEGRepresentation(self.imageView.image, 1);
    //寫入到指定位置imagePath
    [imageData writeToFile:imagePath atomically:YES];
    NSLog(@"home %@",NSHomeDirectory());
    
    
    
    //透過delegate通知
    //@optional
    if ( [self.delegate respondsToSelector:@selector(didFinishUpdateNote:)] ){
        [self.delegate didFinishUpdateNote:self.currentNote];
    }
    
    //[[NSNotificationCenter defaultCenter] postNotificationName:@"NoteUpdated" object:nil userInfo:@{@"note":self.currentNote}];
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)camera:(id)sender {
    
    UIImagePickerController *pickerController = [[UIImagePickerController alloc]init];
    pickerController.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    pickerController.delegate = self;
    [self presentViewController:pickerController animated:YES completion:nil];
    
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    
    self.imageView.image = image;
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    //[self dismissViewControllerAnimated:YES completion:nil];兩種都以。
    
    
    
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
