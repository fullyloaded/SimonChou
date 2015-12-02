//
//  NoteListViewController.m
//  NoteApp
//
//  Created by Vincent on 2015/10/12.
//  Copyright © 2015年 Vincent. All rights reserved.
//

#import "NoteListViewController.h"
#import "Note.h"
#import "NoteCell.h"
#import "NoteViewController.h"
#import "CoreDataHelper.h"

@interface NoteListViewController ()<UITableViewDataSource,UITableViewDelegate,NoteViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property(nonatomic) NSMutableArray<Note *> *notes;
@end

@implementation NoteListViewController

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        //NSKeyedArchive
        //[self loadFromFile];
        [self queryFromCoreData];
        
        //新增，刪除，修改，查詢
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(finishUpdate:) name:@"NoteUpdated" object:nil];
    }
    return self;
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)finishUpdate:(NSNotification*)notification{
    Note *note = notification.userInfo[@"note"];
    NSUInteger index = [self.notes indexOfObject:note];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    //自動計算cell高度，字越多，cell越高
    self.tableView.estimatedRowHeight = 44;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    
    self.navigationItem.title = @"List";//程式控制
    
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *hasPurchased = @"hasPurchased";
    
    if ( ![userDefaults boolForKey:hasPurchased]){
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"title" message:@"謝謝購買" preferredStyle:UIAlertControllerStyleAlert];
    
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"OK");
        }];
    
        [alert addAction:okAction];
        [self presentViewController:alert animated:YES completion:nil];
        [userDefaults setBool:YES forKey:hasPurchased];
        [userDefaults synchronize];//一般情況不用寫
    }
}

#pragma mark NSKeyArchiving
-(void)saveToFile{
    //產生檔案路徑
    NSString *documentPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSString *filePath = [documentPath stringByAppendingPathComponent:@"notes.archive"];
    //寫到檔案
    [NSKeyedArchiver archiveRootObject:self.notes toFile:filePath];
}
-(void)loadFromFile{
    NSString *documentPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSString *filePath = [documentPath stringByAppendingPathComponent:@"notes.archive"];
    NSArray *notesInFiles = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    self.notes = [NSMutableArray arrayWithArray:notesInFiles];
}
#pragma mark CoreData
-(void)queryFromCoreData{
    
    CoreDataHelper *helper = [CoreDataHelper sharedInstance];
    NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:@"Note"];
    
    NSError *error = nil;
    
    
    NSArray *result = [helper.managedObjectContext executeFetchRequest:request error:&error];
    
    if ( error ){
        NSLog(@"error %@",error);
        self.notes = [NSMutableArray array];
    }else{
        self.notes = [NSMutableArray arrayWithArray:result];
    }
    //P.335
}
-(void)saveToCoreData{
    //P.337
    CoreDataHelper *helper = [CoreDataHelper sharedInstance];
    
    NSError *error = nil;
    [helper.managedObjectContext save:&error];
    if ( error ){
        NSLog(@"error while save %@",error);
    }
}

-(void)setEditing:(BOOL)editing animated:(BOOL)animated{
    [super setEditing:editing animated:animated];
    [self.tableView setEditing:editing animated:YES];
}



- (IBAction)edit:(id)sender {
    
    //self.tableView.editing = !self.tableView.editing;
    
    [self.tableView setEditing:!self.tableView.editing animated:YES];
    
}
- (IBAction)addNote:(id)sender {
    
    //Note *note = [[Note alloc]init];
    //P.336
    CoreDataHelper *helper = [CoreDataHelper sharedInstance];
    Note *note = [NSEntityDescription insertNewObjectForEntityForName:@"Note" inManagedObjectContext:helper.managedObjectContext];
    
    note.text = @"New Note";
    //[self.notes addObject:note];
    //新增到第一筆
    [self.notes insertObject:note atIndex:0];
    
    //[self saveToFile]; //NSArchive
    [self saveToCoreData]; //CoreData
    //取得網路上檔案(10MB)
    //......
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    
    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    [self performSegueWithIdentifier:@"noteSegue" sender:self];
    
}

#pragma mark UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.notes.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    /*
     //custom cell
     NoteCell *cell = [tableView dequeueReusableCellWithIdentifier:@"customcell" forIndexPath:indexPath];
     cell.mylabel.text = note.text; //custom cell
     */
    
    //basic cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"id1" forIndexPath:indexPath];
    
    cell.showsReorderControl = YES;
    
    Note *note = self.notes[indexPath.row];
    cell.textLabel.text = note.text;
    cell.imageView.image = note.thumbnailImage;
    return cell;
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if ( editingStyle == UITableViewCellEditingStyleDelete ){
        
        CoreDataHelper *helper = [CoreDataHelper sharedInstance];
        
        Note *note = self.notes[indexPath.row];
        [helper.managedObjectContext deleteObject:note];
        [self saveToCoreData];//P.338
        
        [self.notes removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        
        //[self saveToFile];
    }
}

-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{
    
    Note *note =  self.notes[sourceIndexPath.row];
    
    [self.notes removeObject:note];
    [self.notes insertObject:note atIndex:destinationIndexPath.row];
    
}

#pragma mark UITableViewDelegate
//整筆
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"row %ld",(long)indexPath.row);
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    /*
    NoteViewController *noteViewController =  [self.storyboard instantiateViewControllerWithIdentifier:@"noteViewController"];
    
    [self.navigationController pushViewController:noteViewController animated:YES];
    //[self showViewController:noteViewController sender:self];
    */
    
}
//點accessory view
-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath{
    //2種detail accessory type才會有效
    NSLog(@"accessory ");
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ( [segue.identifier isEqualToString:@"noteSegue"]){
        
        NoteViewController *noteViewController = segue.destinationViewController;
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        if ( !indexPath ){
            //表示為新增的情況
            indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        }
        Note *note = self.notes[indexPath.row];
        noteViewController.currentNote = note;
        noteViewController.delegate = self;
    }
    
}

-(void)didFinishUpdateNote:(Note *)note{
    NSLog(@"note = %@",note.text);
    //取得array中的位置
    NSUInteger index = [self.notes indexOfObject:note];
    //轉換成畫面的位置
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    //reload cell
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];

    //[self saveToFile];
    [self saveToCoreData];
    
}







@end
