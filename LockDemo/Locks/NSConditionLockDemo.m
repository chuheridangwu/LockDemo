//
//  NSConditionLockDemo.m
//  LockDemo
//
//  Created by mlive on 2021/1/28.
//

#import "NSConditionLockDemo.h"

@interface NSConditionLockDemo ()
@property (nonatomic, strong)NSConditionLock *ticketLock;
@property (nonatomic, strong)NSConditionLock *moneyLock;
@end

@implementation NSConditionLockDemo

- (instancetype)init
{
    self = [super init];
    if (self) {
        _ticketLock = [[NSConditionLock new] initWithCondition:1];
        // 初始化条件锁为1
        _moneyLock = [[NSConditionLock new] initWithCondition:1];
    }
    return self;
}

- (void)__saveMoney{
    // 条件为1时进行加锁
    [_moneyLock lockWhenCondition:1];
    [super __saveMoney];
    // 解锁之后设置条件为2
    [_moneyLock unlockWithCondition:2];
}

-(void)__drewMoney{
    [_moneyLock lockWhenCondition:2];
    [super __drewMoney];
    [_moneyLock unlockWithCondition:1];
}

-(void)__saleTicket{
    // lock方法，不管什么条件都可以加锁
    [_ticketLock lock];
    [super __saleTicket];
    [_ticketLock unlockWithCondition:2];
}

@end
