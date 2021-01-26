//
//  ViewController.m
//  LockDemo
//
//  Created by mlive on 2021/1/25.
//

#import "ViewController.h"
#import "OSSpinLockDemo.h"
#import "OSUnfairLockDemo.h"
#import <libkern/OSAtomic.h>


@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[OSUnfairLockDemo new] ticketTest];
}

- (void)asyncSaleTicket{
    // 初始化锁
    OSSpinLock lock = OS_SPINLOCK_INIT;
    // 尝试加锁（如果需要等待就不加锁，返回false，如果不需要等待就加锁，返回true）
    OSSpinLockTry(&lock);
    // 加锁
    OSSpinLockLock(&lock);
    // 解锁
    OSSpinLockUnlock(&lock);
}




@end
