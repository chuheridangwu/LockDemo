//
//  SehaporeDemo.m
//  LockDemo
//
//  Created by mlive on 2021/1/28.
//

#import "SemaphoreDemo.h"

@interface SemaphoreDemo ()
@property (nonatomic, strong)dispatch_semaphore_t moneySemaphore;
@property (nonatomic, strong)dispatch_semaphore_t ticketSemaphore;
@property (nonatomic, strong)dispatch_semaphore_t semaphore;

@end

@implementation SemaphoreDemo

- (instancetype)init
{
    self = [super init];
    if (self) {
        _moneySemaphore = dispatch_semaphore_create(1);
        _ticketSemaphore = dispatch_semaphore_create(1);
        _semaphore = dispatch_semaphore_create(2);
    }
    return self;
}

- (void)otherTest{
    for (int  i = 0; i < 20; i++) {
        [[[NSThread new] initWithTarget:self selector:@selector(test) object:nil] start];
    }
}

- (void)test{
    dispatch_semaphore_wait(_semaphore, DISPATCH_TIME_FOREVER);
    NSLog(@"%@ ----",[NSThread currentThread]);
    sleep(1);
    dispatch_semaphore_signal(_semaphore);
}

-(void)__drewMoney{
    dispatch_semaphore_wait(_moneySemaphore, DISPATCH_TIME_FOREVER);
    [super __drewMoney];
    dispatch_semaphore_signal(_moneySemaphore);
}

-(void)__saveMoney{
    dispatch_semaphore_wait(_moneySemaphore, DISPATCH_TIME_FOREVER);
    [super __saveMoney];
    dispatch_semaphore_signal(_moneySemaphore);
}

-(void)__saleTicket{
    dispatch_semaphore_wait(_ticketSemaphore, DISPATCH_TIME_FOREVER);
    [super __saleTicket];
    dispatch_semaphore_signal(_ticketSemaphore);
}

@end
