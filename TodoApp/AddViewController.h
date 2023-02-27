//
//  AddViewController.h
//  TodoApp
//
//  Created by Dragon on 17/01/2023.
//

#import <UIKit/UIKit.h>
#import "MyTodo.h"
NS_ASSUME_NONNULL_BEGIN

@interface AddViewController : UIViewController 

@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextView *des;
@property (weak, nonatomic) IBOutlet UIDatePicker *date;
@property (weak, nonatomic) IBOutlet UISegmentedControl *prio;

@end

NS_ASSUME_NONNULL_END
