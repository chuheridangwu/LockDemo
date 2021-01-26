//
//  OSSpinLockDemo.m
//  LockDemo
//
//  Created by mlive on 2021/1/25.
//

#import "OSSpinLockDemo.h"
#import <libkern/OSAtomic.h>
// OSSpinLock 属于自旋锁，在iOS10中已经过期了，在iOS10以后推荐使用os_unfair_lock
@interface OSSpinLockDemo()
@property (nonatomic, assign)OSSpinLock moneyLock;
@property (nonatomic, assign)OSSpinLock ticketLock;

@end

@implementation OSSpinLockDemo

- (instancetype)init{
    if (self = [super init]) {
        // 初始化锁
        _moneyLock = OS_SPINLOCK_INIT;
        _ticketLock = OS_SPINLOCK_INIT;
    }
    return self;
}

- (void)__saveMoney{
    sleep(1);
    // 加锁
    OSSpinLockLock(&_moneyLock);
    [super __saveMoney];
    // 解锁
    OSSpinLockUnlock(&_moneyLock);
}

- (void)__drewMoney{
    sleep(1);
    OSSpinLockLock(&_moneyLock);
    [super __drewMoney];
    OSSpinLockUnlock(&_moneyLock);
}

- (void)__saleTicket{
    sleep(1);
    OSSpinLockLock(&_ticketLock);
    [super __saleTicket];
    OSSpinLockUnlock(&_ticketLock);
}

@end
