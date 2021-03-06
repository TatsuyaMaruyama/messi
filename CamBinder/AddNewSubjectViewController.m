//
//  AddNewSubjectViewController.m
//  CamBinder
//
//  Created by Takuma Horiuchi on 2014/09/08.
//  Copyright (c) 2014年 MatsumotoTakuma. All rights reserved.
//

#import "AddNewSubjectViewController.h"
#import "AddTableTableViewCell.h"
#import "NoteViewController.h"

@interface AddNewSubjectViewController ()

@end

@implementation AddNewSubjectViewController

////@synthesize tasks = _tasks;
//
//- (id)initWithStyle:(UITableViewStyle)style
//{
//    self = [super initWithStyle:style];
//    if (self) {
//        // Custom initialization
//    }
//    return self;
//}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _tableSubject.delegate = self;
    _tableSubject.dataSource = self;
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.navigationItem.leftBarButtonItem = [self editButtonItem];
    
    self.editButtonItem.title = @"編集";
    
    self.editButtonItem.enabled = NO;
    
    self.tasks = [[NSMutableArray alloc] init];
    
    UINib *nibSubject = [UINib nibWithNibName:@"AddTableTableViewCell" bundle:nil];
    [_tableSubject registerNib:nibSubject forCellReuseIdentifier:@"SubjectCell"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setEditing:(BOOL)editing animated:(BOOL)animated {
    [super setEditing:editing animated:YES];
    
    if(editing){
        self.editButtonItem.title = @"完了";
    }else{
        self.editButtonItem.title = @"編集";
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tasks.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"SubjectCell";
    
    //AddNewSubject *currentTask  = [self.tasks objectAtIndex:indexPath.row];
    
    AddTableTableViewCell *subjectCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    if (!cell) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
//    }
    
    // Configure the cell...
    
    NSDictionary *dict = _tasks[indexPath.row];
    
    subjectCell.labelSubject.text = dict[@"name"];
    subjectCell.labelSemester.text = dict[@"semester"];
    subjectCell.labelClass.text = dict[@"class"];
    
    return subjectCell;
}

    // *セルがタップされた時の処理
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"pushNoteView" sender:nil];
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [self.tasks removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        if (self.tasks.count == 0) {
            self.editButtonItem.enabled = NO;
            self.editButtonItem.title = @"編集";
            [tableView setEditing:NO animated:YES];
        }
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}

// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
    AddNewSubject *movedTask = [self.tasks objectAtIndex:fromIndexPath.row];
    [self.tasks removeObjectAtIndex:fromIndexPath.row];
    [self.tasks insertObject:movedTask atIndex:toIndexPath.row];
}



// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}

#pragma mark - TableView data source method


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [AddTableTableViewCell rowHeight];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
 */

#pragma mark - IBActions

- (void)editButtonPressed:(id)sender {
    self.editing = !self.editing;
}

- (void)secAddNewSubjectDidDone:(SecAddNewSubjectViewController *)controller item:(NSString *)item
{
    NSLog(@"SecAddOjbectViewControllerDidDone");
    
    // 配列を受け取って挿入
    if (!_tasks) {
        _tasks = [[NSMutableArray alloc] init];
    }
    [_tasks insertObject:item atIndex:0];
    // セルを挿入
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [_tableSubject insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationRight];
    // 画面を閉じる
    [self dismissViewControllerAnimated:YES completion:NULL];
    self.editButtonItem.enabled = YES;
}

- (void)secAddNewSubjectDidCancel:(SecAddNewSubjectViewController *)contoller
{
    NSLog(@"SecAddOjbectViewControllerDidCancel");
    
    // 画面を閉じる
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"AddTaskSegue"]){
        /*
         UINavigationController *navCon = segue.destinationViewController;
         SecAddNewSubjectViewController *addNewSubjectViewController = [navCon.viewControllers objectAtIndex:0];
         addNewSubjectViewController.SubjectViewController = self;
         */
        SecAddNewSubjectViewController *secAddNewSubjectViewController = (SecAddNewSubjectViewController *)[[[segue destinationViewController] viewControllers] objectAtIndex:0];
        secAddNewSubjectViewController.delegate = self;
    } else if ([segue.identifier isEqualToString:@"pushNoteView"]) {
        NoteViewController *noteViewController = segue.destinationViewController;
        NSIndexPath *indexPath = [_tableSubject indexPathForSelectedRow];
        NSDictionary *dict = _tasks[indexPath.row];
        noteViewController.navigationItem.title = dict[@"name"];
    }
}

@end
