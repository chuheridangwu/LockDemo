//
//  SerialQueue.m
//  LockDemo
//
//  Created by mlive on 2021/1/28.
//

#import "SerialQueue.h"

@interface SerialQueue()
@property (nonatomic, strong)dispatch_queue_t moneyQueue;
@property (nonatomic, strong)dispatch_queue_t ticketQueue;

@end

@implementation SerialQueue

- (instancetype)init
{
    self = [super init];
    if (self) {
        _moneyQueue = dispatch_queue_create("money", DISPATCH_QUEUE_SERIAL);
        _ticketQueue = dispatch_queue_create("ticket", DISPATCH_QUEUE_SERIAL);

    }
    return self;
}

- (void)__saleTicket{
    dispatch_sync(_ticketQueue, ^{
        [super __saleTicket];
    });
}

- (void)__saveMoney{
    dispatch_sync(_ticketQueue, ^{
        [super __saveMoney];
    });
}

- (void)__drewMoney{
    dispatch_sync(_ticketQueue, ^{
        [super __drewMoney];
    });
}

@end
