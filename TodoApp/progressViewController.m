//
//  progressViewController.m
//  TodoApp
//
//  Created by Dragon on 17/01/2023.
//

#import "progressViewController.h"
#import "MyTodo.h"
#import "editViewController.h"
@interface progressViewController ()

@end

@implementation progressViewController

{
    NSUserDefaults *defaults;
    NSMutableArray<MyTodo*> *progressArr;
    MyTodo* task;
    NSMutableArray* doneArr;
    NSMutableArray* lowArr;
    NSMutableArray* midArr;
    NSMutableArray* highArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _progressTable.delegate=self;
    _progressTable.dataSource=self;
    task=[MyTodo new];
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    defaults=[NSUserDefaults standardUserDefaults];
    progressArr=[[self unarchiveMethod:@"inProgress"]mutableCopy];
   doneArr=[[self unarchiveMethod:@"done"]mutableCopy];
    [_progressTable reloadData];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [progressArr count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text=[[progressArr objectAtIndex:indexPath.row] taskName ];
    if([[progressArr objectAtIndex:indexPath.row] taskPriority]==0)
    {
        cell.imageView.image=[UIImage imageNamed:@"1"];
    }
    else if ([[progressArr objectAtIndex:indexPath.row] taskPriority]==1)
    {
        cell.imageView.image=[UIImage imageNamed:@"2"];
    }
    else
    {
        cell.imageView.image=[UIImage imageNamed:@"3"];
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 75;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    editViewController *view=[self.storyboard instantiateViewControllerWithIdentifier:@"editViewController"];
    
    view.task=[progressArr objectAtIndex:indexPath.row];
    [view setIndex:indexPath.row];
    view.x = 1;
    _progressIndex= indexPath.item;
    
    [self.navigationController pushViewController:view animated:YES];
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIAlertController *myalert=[UIAlertController alertControllerWithTitle:@"Add frined" message:@"Do you want to add!" preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *gotable=[UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        [progressArr removeObjectAtIndex:indexPath.row];
        [_progressTable deleteRowsAtIndexPaths:[NSMutableArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        defaults=[NSUserDefaults standardUserDefaults];
        [self archiveMethod:@"inProgress" withArray:progressArr];
        [_progressTable reloadData];
      }
        
    }];
    UIAlertAction *back=[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:nil];
    
    [myalert addAction:gotable];
    [myalert addAction:back];
    [self presentViewController:myalert animated:YES completion:nil];
}
-(void)archiveMethod:(NSString *)keyName withArray:(NSMutableArray *)myArray
{
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:myArray];
    [defaults setObject:data forKey:keyName];
    [defaults synchronize];
}
-(NSArray *)unarchiveMethod:(NSString*)keyName
{
    NSData *data = [defaults objectForKey:keyName];
    NSArray *myArray = [[NSKeyedUnarchiver unarchiveObjectWithData:data]mutableCopy];
    return myArray;
}
@end
