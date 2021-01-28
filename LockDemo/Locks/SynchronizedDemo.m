//
//  SynchronizedDemo.m
//  LockDemo
//
//  Created by mlive on 2021/1/28.
//

#import "SynchronizedDemo.h"

@implementation SynchronizedDemo
- (void)__saleTicket{
    static NSObject *object = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        object = [NSObject new];
    });
    
    @synchronized (object) {
        [super __saleTicket];
    }
}
- (void)__saveMoney{
    @synchronized ([self class]) {
        [super __saveMoney];
    }
}
- (void)__drewMoney{
    @synchronized ([self class]) {
        [super __drewMoney];
    }
}
@end
