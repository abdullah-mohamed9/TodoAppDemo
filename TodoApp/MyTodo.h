//
//  MyTodo.h
//  TodoApp
//
//  Created by Dragon on 17/01/2023.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyTodo : NSObject


@property  NSString *taskName;
@property NSString *taskDescription;
@property  NSDate *dateOfCreation;
@property  int taskPriority;



@end

NS_ASSUME_NONNULL_END
