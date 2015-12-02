//
//  NoteViewController.h
//  NoteApp
//
//  Created by Vincent on 2015/10/13.
//  Copyright © 2015年 Vincent. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Note.h"
#import "NoteListViewController.h"

@protocol NoteViewControllerDelegate <NSObject>
@optional
-(void)didFinishUpdateNote:(Note*)note;
@end

@interface NoteViewController : UIViewController
@property(nonatomic) Note *currentNote;
@property(weak,nonatomic) id<NoteViewControllerDelegate> delegate;
@end








