//
//  Note.m
//  NoteApp
//
//  Created by Vincent on 2015/10/12.
//  Copyright © 2015年 Vincent. All rights reserved.
//

#import "Note.h"

@implementation Note

@dynamic text;
@dynamic imageName;

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super init];
    if (self) {
        
        self.text = [coder decodeObjectForKey:@"text"];
        self.imageName = [coder decodeObjectForKey:@"imageName"];
        
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder{
    //寫到檔案
    [aCoder encodeObject:self.text forKey:@"text"];
    [aCoder encodeObject:self.imageName forKey:@"imageName"];
    
    
}


-(UIImage*)image{
    
    //組檔案路徑
    NSString *documentPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSString *imagePath = [documentPath stringByAppendingPathComponent:self.imageName];
    /*
    //產生Documents/photos目錄範例
    NSString *photoDir = [documentPath stringByAppendingPathComponent:@"photos"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isFolder = NO;
    BOOL folderExist =  [fileManager fileExistsAtPath:photoDir isDirectory:&isFolder];
    if ( !folderExist ){
        [fileManager createDirectoryAtPath:photoDir withIntermediateDirectories:YES attributes:nil error:nil];
    }
    */
    return [UIImage imageWithContentsOfFile:imagePath];
}
-(UIImage *)thumbnailImage{

    UIImage *image = [self image];
    if ( !image){
        return nil;
    }
    CGSize thumbnailSize = CGSizeMake(50, 50); //設定縮圖大小
    CGFloat scale = [UIScreen mainScreen].scale; //找出目前螢幕的scale，視網膜技術為2.0,plus 3.0
    //產生畫布，指定大小,透明(NO),scale為螢幕scale
    UIGraphicsBeginImageContextWithOptions(thumbnailSize, NO, scale);
    
    //計算長寬要縮圖比例，取最大值MAX會變成UIViewContentModeScaleAspectFill
    //最小值MIN會變成UIViewContentModeScaleAspectFit
    CGFloat widthRatio = thumbnailSize.width / image.size.width;
    CGFloat heightRadio = thumbnailSize.height / image.size.height;
    CGFloat ratio = MAX(widthRatio,heightRadio);
    
    CGSize imageSize = CGSizeMake(image.size.width*ratio, image.size.height*ratio);
    
    //切成圓形
    UIBezierPath *circlePath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, thumbnailSize.width, thumbnailSize.height)];
    [circlePath addClip];

    
    [image drawInRect:CGRectMake(-(imageSize.width-50.0)/2.0, -(imageSize.height-50.0)/2.0,
                                 imageSize.width, imageSize.height)];
    
    //取得畫布上的縮圖
    image = UIGraphicsGetImageFromCurrentImageContext();
    //關掉畫布
    UIGraphicsEndImageContext();
    return image;
}










@end
