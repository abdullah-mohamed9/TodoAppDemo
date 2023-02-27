//
//  ViewController.h
//  TodoApp
//
//  Created by Dragon on 17/01/2023.
//

#import <UIKit/UIKit.h>
#import "MyTodo.h"
@interface ViewController : UIViewController<UITableViewDelegate,UITableViewDataSource> 

@property (weak, nonatomic) IBOutlet UITableView *todoTable;
@property NSInteger *todoIndex;

@end

