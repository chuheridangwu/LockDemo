//
//  NSLockDemo.m
//  LockDemo
//
//  Created by mlive on 2021/1/27.
//

#import "NSLockDemo.h"

@interface NSLockDemo ()
@property (nonatomic, strong)NSLock *ticketLock;
@property (nonatomic, strong)NSLock *moneyLock;

@end

@implementation NSLockDemo

- (instancetype)init
{
    self = [super init];
    if (self) {
        _ticketLock = [[NSLock alloc] init];
        _moneyLock = [[NSLock alloc] init];

    }
    return self;
}

- (void)__saveMoney{
    sleep(1);
    [_moneyLock lock];
    [super __saveMoney];
    [_moneyLock unlock];
}

- (void)__drewMoney{
    sleep(1);
    [_moneyLock lock];
    [super __drewMoney];
    [_moneyLock unlock];
}

- (void)__saleTicket{
    sleep(1);
    [_ticketLock lock];
    [super __saleTicket];
    [_ticketLock unlock];
}

@end
