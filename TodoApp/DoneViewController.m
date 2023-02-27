//
//  DoneViewController.m
//  TodoApp
//
//  Created by Dragon on 17/01/2023.
//

#import "DoneViewController.h"
#import "editViewController.h"
#import "MyTodo.h"
@interface DoneViewController ()

@end

@implementation DoneViewController

{
    NSUserDefaults *defaults;
    NSMutableArray<MyTodo*> *doneArr;
    MyTodo *task;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _doneTable.delegate=self;
    _doneTable.dataSource=self;
    task=[MyTodo new];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    defaults = [NSUserDefaults standardUserDefaults];
    doneArr = [[self unarchiveMethod:@"done"]mutableCopy];
    [_doneTable reloadData];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [doneArr count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.textLabel.text=[[doneArr objectAtIndex:indexPath.row] taskName ];
    if([[doneArr objectAtIndex:indexPath.row] taskPriority]==0){
        cell.imageView.image=[UIImage imageNamed:@"1"];
    }else if ([[doneArr objectAtIndex:indexPath.row] taskPriority]==1){
        cell.imageView.image=[UIImage imageNamed:@"2"];
    }else{
        cell.imageView.image=[UIImage imageNamed:@"3"];
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 75;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
        UIAlertController *myalert=[UIAlertController alertControllerWithTitle:@"Add frined" message:@"Do you want to add!" preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *gotable=[UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        [doneArr removeObjectAtIndex:indexPath.row];
        [_doneTable deleteRowsAtIndexPaths:[NSMutableArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        defaults=[NSUserDefaults standardUserDefaults];
        [self archiveMethod:@"done" withArray: doneArr];
        [_doneTable reloadData];
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
