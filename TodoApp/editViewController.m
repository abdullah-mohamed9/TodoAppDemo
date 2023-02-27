//
//  editViewController.m
//  TodoApp
//
//  Created by Dragon on 18/01/2023.
//

#import "editViewController.h"
#import "progressViewController.h"
#import "ViewController.h"

@interface editViewController ()

@end

@implementation editViewController
{
    NSMutableArray<MyTodo*>*todoArr;
    MyTodo *task;
    NSUserDefaults *defaults;
    NSMutableArray* progressArr;
    NSMutableArray* doneArr;
    int x;
    progressViewController *progressObject;
    ViewController *todoObject;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _editName.text=_task.taskName;
    _editDetails.text=_task.taskDescription;
    _editPriority.selectedSegmentIndex=_task.taskPriority;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    defaults=[NSUserDefaults standardUserDefaults];
    todoArr=[[self unarchiveMethod:@"task"]mutableCopy];
    progressArr=[[self unarchiveMethod:@"inProgress"]mutableCopy];
    doneArr=[[self unarchiveMethod:@"done"]mutableCopy];
    x=0;
    

}
- (IBAction)editDetails:(id)sender {
    if(_editState.selectedSegmentIndex == 0)
    {
        [[todoArr objectAtIndex:_index] setTaskName:_editName.text];
        [[todoArr objectAtIndex:_index] setTaskDescription:_editDetails.text];
        [[todoArr objectAtIndex:_index] setTaskPriority:_editPriority.selectedSegmentIndex];
        
        [self archiveMethod:@"task" withArray:todoArr];
        x=0;
        [self.navigationController popViewControllerAnimated:YES];
       
    }
    else if (_editState.selectedSegmentIndex == 1)
    {
        task=[MyTodo new];
        task.taskName =_editName.text;
        task.taskDescription=_editDetails.text;
        task.taskPriority =_editPriority.selectedSegmentIndex;
        
        [todoArr removeObjectAtIndex:_index];
        
        [self archiveMethod:@"task" withArray:todoArr];
        
        [progressArr addObject:task];
        [self archiveMethod:@"inProgress" withArray:progressArr];
        x=1;
        
        [self.navigationController popViewControllerAnimated:YES];
    }
    else if (_editState.selectedSegmentIndex == 2)
    {
         if (_x==1)
           {
            task=[MyTodo new];
            task.taskName =_editName.text;
            task.taskDescription=_editDetails.text;
            task.taskPriority =_editPriority.selectedSegmentIndex;
               
            [progressArr removeObjectAtIndex:_index];
            [self archiveMethod:@"inProgress" withArray:progressArr];

            [doneArr addObject:task];
            [self archiveMethod:@"done" withArray:doneArr];

            [self.navigationController popViewControllerAnimated:YES];
        }
        else if (_x==0)
        {
            task=[MyTodo new];
            task.taskName =_editName.text;
            task.taskDescription=_editDetails.text;
            task.taskPriority =_editPriority.selectedSegmentIndex;

            [todoArr removeObjectAtIndex:_index];
            [self archiveMethod:@"task" withArray:todoArr];

            [doneArr addObject:task];
            [self archiveMethod:@"done" withArray:doneArr];

            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}
-(NSArray *)unarchiveMethod:(NSString*)keyName
{
    NSData *data = [defaults objectForKey:keyName];
    NSArray *myArray = [NSMutableArray arrayWithArray:[NSKeyedUnarchiver unarchiveObjectWithData:data]];
    return myArray;
}
-(void)archiveMethod:(NSString *)keyName withArray:(NSMutableArray *)myArray
{
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:myArray];
    [defaults setObject:data forKey:keyName];
    [defaults synchronize];
}
@end
