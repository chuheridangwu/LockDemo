//
//  ViewController.m
//  LockDemo
//
//  Created by mlive on 2021/1/25.
//

#import "ViewController.h"
#import "OSSpinLockDemo.h"
#import "OSUnfairLockDemo.h"
#import "MutexDemo.h"
#import "MutexDemo1.h"
#import "MutexDemo2.h"
#import "NSLockDemo.h"
#import "NSRecursiveLockDemo.h"
#import "NSConditionDemo.h"
#import "NSConditionLockDemo.h"
#import "SerialQueue.h"
#import "SemaphoreDemo.h"
#import "SemaphoreDemo2.h"
#import "SynchronizedDemo.h"

#import <libkern/OSAtomic.h>
#import <pthread.h>


@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[SemaphoreDemo2 new] ticketTest];
}

- (void)asyncSaleTicket{
    // 初始化锁
    pthread_mutex_t mutex;
    pthread_mutex_init(&mutex, NULL);
    // 初始化条件
    pthread_cond_t cond;
    pthread_cond_init(&cond, NULL);
    // 等待条件（进入休眠，放开mutex锁，被唤醒后，会重新加锁）
    pthread_cond_wait(&cond, &mutex);
    // 激活一个等待该条件的线程
    pthread_cond_signal(&cond);
    // 激活所有等待该条件的线程
    pthread_cond_broadcast(&cond);
    // 销毁资源
    pthread_mutex_destroy(&mutex);
    pthread_cond_destroy(&cond);

    
    // 信号量初始值
    int value = 1;
    // 初始化信号量
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(value);
    // 如果信号量的值 <= 0,当前线程会进入休眠等待 （直到信号量的值>0）,等待时间是传入的时间，DISPATCH_TIME_FOREVER是一直等
    // 如果信号量的值 > 0, 信号量 -1, 然后向下继续执行代码
    dispatch_semaphore_wait(semaphore,DISPATCH_TIME_FOREVER);
    // 信号量的值 + 1
    dispatch_semaphore_signal(semaphore);
    
}
/*
 //OSSpinLock 汇编
 ->  0x7fff60c81aef <+14>: movl   (%rdi), %eax
     0x7fff60c81af1 <+16>: testl  %eax, %eax
     0x7fff60c81af3 <+18>: jne    0x7fff60c81afd            ; <+28>
     0x7fff60c81af5 <+20>: xorl   %eax, %eax
     0x7fff60c81af7 <+22>: lock
     0x7fff60c81af8 <+23>: cmpxchgl %edx, (%rdi)
     0x7fff60c81afb <+26>: je     0x7fff60c81b0c            ; <+43>
     0x7fff60c81afd <+28>: cmpl   $-0x1, %eax
     0x7fff60c81b00 <+31>: jne    0x7fff60c81b14            ; <+51>
     0x7fff60c81b02 <+33>: testl  %ecx, %ecx
     0x7fff60c81b04 <+35>: je     0x7fff60c81b0e            ; <+45>
     0x7fff60c81b06 <+37>: pause
     0x7fff60c81b08 <+39>: incl   %ecx
     0x7fff60c81b0a <+41>: jmp    0x7fff60c81aef            ; <+14>
 
 // while循环的汇编结果
 ->  0x10999d8fa <+58>:  cmpl   $0xa, -0x24(%rbp)
     0x10999d8fe <+62>:  jge    0x10999d921               ; <+97> at ViewController.m:33:1
     0x10999d904 <+68>:  movl   -0x24(%rbp), %eax
     0x10999d907 <+71>:  addl   $0x1, %eax
     0x10999d90a <+74>:  movl   %eax, -0x24(%rbp)
     0x10999d90d <+77>:  cmpl   $0xa, -0x24(%rbp)
     0x10999d911 <+81>:  jle    0x10999d91c               ; <+92> at ViewController.m:27:5
     0x10999d917 <+87>:  jmp    0x10999d921               ; <+97> at ViewController.m:33:1
     0x10999d91c <+92>:  jmp    0x10999d8fa               ; <+58> at ViewController.m:27:18
 
 os_unfair_lock 汇编结果
 libsystem_kernel.dylib`__ulock_wait:
 ->  0x7fff60c53554 <+0>:  movl   $0x2000203, %eax          ; imm = 0x2000203
     0x7fff60c53559 <+5>:  movq   %rcx, %r10
     0x7fff60c5355c <+8>:  syscall
     0x7fff60c5355e <+10>: jae    0x7fff60c53568            ; <+20>
     0x7fff60c53560 <+12>: movq   %rax, %rdi
     0x7fff60c53563 <+15>: jmp    0x7fff60c52629            ; cerror_nocancel
     0x7fff60c53568 <+20>: retq
 
 
 
 pthread_mutex_t 汇编
 libsystem_kernel.dylib`__psynch_mutexwait:
 ->  0x7fff60c54058 <+0>:  movl   $0x200012d, %eax          ; imm = 0x200012D
     0x7fff60c5405d <+5>:  movq   %rcx, %r10
     0x7fff60c54060 <+8>:  syscall
     0x7fff60c54062 <+10>: jae    0x7fff60c5406c            ; <+20>
     0x7fff60c54064 <+12>: movq   %rax, %rdi
     0x7fff60c54067 <+15>: jmp    0x7fff60c52629            ; cerror_nocancel
     0x7fff60c5406c <+20>: retq
 */



@end
