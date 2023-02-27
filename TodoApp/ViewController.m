//
//  ViewController.m
//  TodoApp
//
//  Created by Dragon on 17/01/2023.
//

#import "ViewController.h"
#import "MyTodo.h"
#import "AddViewController.h"
#import "editViewController.h"
@interface ViewController ()

@end

@implementation ViewController
{
    NSUserDefaults *defaults;
    NSMutableArray<MyTodo*> *todoArr;
    MyTodo *task;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [_todoTable reloadData];
    _todoTable.delegate=self;
    _todoTable.dataSource=self;
     task=[MyTodo new];
    [_todoTable reloadData];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [_todoTable reloadData];
    defaults=[NSUserDefaults standardUserDefaults];
    todoArr=[[self loadTasks:@"task"]mutableCopy];
    [_todoTable reloadData];
}

- (void)viewDidAppear:(BOOL)animated{
    [_todoTable reloadData];
}

- (IBAction)addButton:(id)sender {
      AddViewController *view=[self.storyboard instantiateViewControllerWithIdentifier:@"AddViewController"];
    [self presentViewController:view animated:YES completion:nil];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [todoArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.textLabel.text=[[todoArr objectAtIndex:indexPath.row] taskName ];    if([[todoArr objectAtIndex:indexPath.row] taskPriority]==0)
    {
        cell.imageView.image=[UIImage imageNamed:@"1"];
    }
    else if ([[todoArr objectAtIndex:indexPath.row] taskPriority]==1)
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
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UIAlertController *myalert=[UIAlertController alertControllerWithTitle:@"Add frined" message:@"Do you want to add!" preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *gotable=[UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [todoArr removeObjectAtIndex:indexPath.row];
        [_todoTable deleteRowsAtIndexPaths:[NSMutableArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        defaults=[NSUserDefaults standardUserDefaults];
        [self saveTasks:@"task" withArray:todoArr];
        [_todoTable reloadData];
    }
    }];
    UIAlertAction *back=[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:nil];
    
    [myalert addAction:gotable];
    [myalert addAction:back];
    [self presentViewController:myalert animated:YES completion:nil];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    editViewController *view=[self.storyboard instantiateViewControllerWithIdentifier:@"editViewController"];
    
    view.task=[todoArr objectAtIndex:indexPath.row];
    [view setIndex:indexPath.row];
    _todoIndex = indexPath.item;
    view.x=0;
    [self.navigationController pushViewController:view animated:YES];
    
}
-(void)saveTasks:(NSString *)keyName withArray:(NSMutableArray *)myArray
{
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:myArray];
    [defaults setObject:data forKey:keyName];
    [defaults synchronize];
}



-(NSArray *)loadTasks:(NSString*)keyName
{
    NSData *data = [defaults objectForKey:keyName];
    NSArray *myArray = [[NSKeyedUnarchiver unarchiveObjectWithData:data]mutableCopy];
    return myArray;
}

@end
