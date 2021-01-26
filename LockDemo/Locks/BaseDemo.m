//
//  BaseDemo.m
//  LockDemo
//
//  Created by mlive on 2021/1/25.
//

#import "BaseDemo.h"

@interface BaseDemo()
@property (nonatomic, assign)int moneyCount;
@property (nonatomic, assign)int ticketCount;
@end

@implementation BaseDemo
- (instancetype)init{
    if (self = [super init]) {
        
    }
    return self;
}
- (void)moneyTest{
    _moneyCount = 1000;
    dispatch_async(dispatch_queue_create("saveMoney", 0), ^{
        for (int i = 0; i < 10; i++) {
            [self __saveMoney];
        }
    });
    
    dispatch_async(dispatch_queue_create("drewMoney", 0), ^{
        for (int i = 0; i < 10; i++) {
            [self __drewMoney];
        }
    });
    
}
- (void)ticketTest{
    _ticketCount = 100;
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    dispatch_async(queue, ^{
        for (int i = 0; i < 10; i++) {
            [self __saleTicket];
        }
    });
    dispatch_async(queue, ^{
        for (int i = 0; i < 10; i++) {
            [self __saleTicket];
        }
    });
    dispatch_async(queue, ^{
        for (int i = 0; i < 10; i++) {
            [self __saleTicket];
        }
    });
    dispatch_async(queue, ^{
        for (int i = 0; i < 10; i++) {
            [self __saleTicket];
        }
    });
}
#pragma mark -- 暴露方法给子类实现
- (void)__saveMoney{
    _moneyCount += 20;
    NSLog(@"存入 20元，剩余  %d 元 -- %@",_moneyCount,[NSThread currentThread]);

}
- (void)__drewMoney{
    _moneyCount -= 10;
    NSLog(@"取出 10元，剩余  %d 元 -- %@",_moneyCount,[NSThread currentThread]);

}
- (void)__saleTicket{
    _ticketCount -= 1;
    NSLog(@"还剩余  %d 张票 -- %@",_ticketCount,[NSThread currentThread]);
}
@end
