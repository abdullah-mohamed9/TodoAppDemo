//
//  AddViewController.m
//  TodoApp
//
//  Created by Dragon on 17/01/2023.
//

#import "AddViewController.h"
#import "MyTodo.h"
#import "ViewController.h"
@interface AddViewController ()

@end

@implementation AddViewController
{
    MyTodo *task;
    NSMutableArray *todoArr;
    NSUserDefaults *defaults;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    defaults =[NSUserDefaults standardUserDefaults];
    task = [MyTodo new];
    todoArr=[[self unarchiveMethod:@"task"]mutableCopy];
    
}

- (IBAction)addButon:(id)sender {
    
    UIAlertController *myalert=[UIAlertController alertControllerWithTitle:@"Add frined" message:@"Do you want to add!" preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *gotable=[UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
    
        task.taskName = _name.text;
        task.taskDescription = _des.text;
        task.taskPriority = _prio.selectedSegmentIndex;
        task.dateOfCreation = _date.date;
        [todoArr addObject:task];
        [self archiveMethod:@"task" withArray:todoArr];
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    
    UIAlertAction *back=[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    
    [myalert addAction:gotable];
    [myalert addAction:back];
    ViewController *relod =[self.storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
    [relod.todoTable reloadData];
    [self presentViewController:myalert animated:YES completion:nil];
    [relod.todoTable reloadData];
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
    NSArray *myArray = [NSMutableArray arrayWithArray:[NSKeyedUnarchiver unarchiveObjectWithData:data]];
    return myArray;
}

@end
