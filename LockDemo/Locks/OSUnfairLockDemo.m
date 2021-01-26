//
//  OSUnfairLockDemo.m
//  LockDemo
//
//  Created by mlive on 2021/1/25.
//

#import "OSUnfairLockDemo.h"
#import <os/lock.h>

API_AVAILABLE(ios(10.0))
@interface OSUnfairLockDemo()
@property (nonatomic,assign)os_unfair_lock moneyLock;
@property (nonatomic,assign)os_unfair_lock ticketLock;
@end

API_AVAILABLE(ios(10.0))
@implementation OSUnfairLockDemo
- (instancetype)init{
    if (self = [super init]) {
        _moneyLock = OS_UNFAIR_LOCK_INIT;
        _ticketLock = OS_UNFAIR_LOCK_INIT;
    }
    return self;;
}

- (void)__saveMoney{
    sleep(1);
    os_unfair_lock_lock(&_moneyLock);
    [super __saveMoney];
    os_unfair_lock_unlock(&_moneyLock);
}

- (void)__drewMoney{
    sleep(1);
    os_unfair_lock_lock(&_moneyLock);
    [super __drewMoney];
    os_unfair_lock_unlock(&_moneyLock);
}

- (void)__saleTicket{
    sleep(1);
    os_unfair_lock_lock(&_ticketLock);
    [super __saleTicket];
    os_unfair_lock_unlock(&_ticketLock);
}

@end
