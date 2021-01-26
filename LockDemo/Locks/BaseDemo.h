//
//  BaseDemo.h
//  LockDemo
//
//  Created by mlive on 2021/1/25.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseDemo : NSObject
- (void)moneyTest;
- (void)ticketTest;
- (void)otherTest; // 递归锁
#pragma mark -- 暴露方法给子类实现
- (void)__saveMoney;
- (void)__drewMoney;
- (void)__saleTicket;
@end

NS_ASSUME_NONNULL_END
