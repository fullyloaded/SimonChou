//
//  Note.h
//  NoteApp
//
//  Created by Vincent on 2015/10/12.
//  Copyright © 2015年 Vincent. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;
//#import <UIKit/UIKit.h>
@import CoreData;

//@interface Note : NSObject<NSCoding>
@interface Note : NSManagedObject
@property(nonatomic) NSString *text;

//@property(nonatomic) UIImage *image;
@property(nonatomic) NSString *imageName;
-(UIImage*)image;
-(UIImage *)thumbnailImage; //50x50縮圖
@property(nonatomic) NSNumber *sequence;






@end
