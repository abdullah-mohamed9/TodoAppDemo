//
//  progressViewController.h
//  TodoApp
//
//  Created by Dragon on 17/01/2023.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface progressViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *progressTable;
@property NSInteger *progressIndex;
@end

NS_ASSUME_NONNULL_END
