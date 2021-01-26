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

#import <libkern/OSAtomic.h>
#import <pthread.h>


@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[OSUnfairLockDemo new] ticketTest];
}

- (void)asyncSaleTicket{
    // 初始化属性
    pthread_mutexattr_t attr;
    pthread_mutexattr_init(&attr);
    pthread_mutexattr_settype(&attr, PTHREAD_MUTEX_RECURSIVE);
    // 初始化锁
    pthread_mutex_t mutex;
    pthread_mutex_init(&mutex, &attr);
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
