//
//  MyTodo.m
//  TodoApp
//
//  Created by Dragon on 17/01/2023.
//

#import "MyTodo.h"

@implementation MyTodo

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:_taskName forKey:@"taskName"];
    [coder encodeObject:_taskDescription forKey:@"taskDescription"];
    [coder encodeObject:_dateOfCreation forKey:@"dateOfCreation"];
    [coder encodeInt:_taskPriority forKey:@"taskPriorit"];
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
self = [super init];
_taskName=[coder decodeObjectForKey:@"taskName"];
_taskDescription=[coder decodeObjectForKey:@"taskDescription"];
_dateOfCreation=[coder decodeObjectForKey:@"dateOfCreation"];
_taskPriority=[coder decodeIntegerForKey:@"taskPriorit"];
return self;
}
@end
