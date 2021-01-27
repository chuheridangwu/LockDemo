//
//  MutexDemo2.m
//  LockDemo
//
//  Created by mlive on 2021/1/26.
//

#import "MutexDemo2.h"
#import <pthread.h>

@interface MutexDemo2 ()
@property (nonatomic, assign)pthread_mutex_t mutex;
@property (nonatomic, assign)pthread_cond_t cond;
@property (nonatomic, strong)NSMutableArray *dataAry;
@end

@implementation MutexDemo2

- (instancetype)init
{
    self = [super init];
    if (self) {
        _dataAry = [NSMutableArray array];
        // 初始化锁
        pthread_mutex_init(&_mutex, NULL);
        // 初始化条件
        pthread_cond_init(&_cond, NULL);
    }
    return self;
}

- (void)otherTest{
    [[[NSThread alloc] initWithTarget:self selector:@selector(__removeObject) object:nil] start];
    sleep(1);
    [[[NSThread alloc] initWithTarget:self selector:@selector(__addObject) object:nil] start];
}

- (void)__removeObject{
    // 加锁
    pthread_mutex_lock(&_mutex);
    if (_dataAry.count == 0) {
        //当前线程进入休眠状态，等待条件成立，会先解锁，条件成立之后再次加锁继续执行
        pthread_cond_wait(&_cond, &_mutex);
        NSLog(@"消费者");
    }
    [_dataAry removeLastObject];
    pthread_mutex_unlock(&_mutex);
}

- (void)__addObject{
    // 加锁
    pthread_mutex_lock(&_mutex);
    [_dataAry addObject:@"1"];
    NSLog(@"生产者");
    // 发出信号,唤醒等待条件的线程
    pthread_cond_signal(&_cond);
    // 解锁
    pthread_mutex_unlock(&_mutex);}

- (void)dealloc{
    // 注销
    pthread_mutex_destroy(&_mutex);
    pthread_cond_destroy(&_cond);
}

@end
