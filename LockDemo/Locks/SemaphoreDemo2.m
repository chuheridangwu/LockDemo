//
//  SemaphoreDemo2.m
//  LockDemo
//
//  Created by mlive on 2021/1/28.
//

#import "SemaphoreDemo2.h"

#define SemaphoreBegin \
static dispatch_semaphore_t semaphore; \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
    semaphore = dispatch_semaphore_create(1); \
}); \
dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER); \

#define SemaphoreEnd  dispatch_semaphore_signal(semaphore);

@implementation SemaphoreDemo2

- (void)__saleTicket{
    SemaphoreBegin

    [super __saleTicket];
    
    SemaphoreEnd
}
@end
