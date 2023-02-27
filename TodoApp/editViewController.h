//
//  editViewController.h
//  TodoApp
//
//  Created by Dragon on 18/01/2023.
//

#import <UIKit/UIKit.h>
#import "MyTodo.h"
NS_ASSUME_NONNULL_BEGIN

@interface editViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *editName;
@property (weak, nonatomic) IBOutlet UITextView *editDetails;
@property (weak, nonatomic) IBOutlet UISegmentedControl *editPriority;
@property (weak, nonatomic) IBOutlet UISegmentedControl *editState;

@property MyTodo* task;
@property int index;
@property int x;

@end

NS_ASSUME_NONNULL_END
