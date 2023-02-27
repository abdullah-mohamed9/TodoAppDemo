//
//  DoneViewController.h
//  TodoApp
//
//  Created by Dragon on 17/01/2023.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DoneViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *doneTable;

@end

NS_ASSUME_NONNULL_END
