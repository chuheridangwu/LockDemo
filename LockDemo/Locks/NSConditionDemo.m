//
//  NSConditionDemo.m
//  LockDemo
//
//  Created by mlive on 2021/1/28.
//

#import "NSConditionDemo.h"

@interface NSConditionDemo()
@property (nonatomic, strong)NSCondition *condition;
@property (nonatomic, strong)NSMutableArray *dataAry;
@end

@implementation NSConditionDemo

- (instancetype)init
{
    self = [super init];
    if (self) {
        _dataAry = [NSMutableArray array];
        _condition = [[NSCondition alloc] init];
    }
    return self;
}

- (void)otherTest{
    [[[NSThread new] initWithTarget:self selector:@selector(__remove) object:nil] start];
    sleep(2);
    [[[NSThread new] initWithTarget:self selector:@selector(__add) object:nil] start];
}

- (void)__remove{
    [_condition lock];
    
    if (_dataAry.count == 0) {
        [_condition wait];
        NSLog(@"消费者");
    }
    [_dataAry removeAllObjects];
    
    [_condition unlock];
}

- (void)__add{
    [_condition lock];
    
    [_dataAry addObject:@"1"];
    NSLog(@"生产者");
    [_condition signal];
    
    [_condition unlock];
}

@end
