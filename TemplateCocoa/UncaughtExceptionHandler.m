//
//  UncaughtExceptionHandler.m
//  Template
//
//  Created by yuwenhua on 16/8/22.
//  Copyright © 2016年 DS. All rights reserved.
//

#import "UncaughtExceptionHandler.h"

#include <libkern/OSAtomic.h>
#include <execinfo.h>

NSString * const UncaughtExceptionHandlerSignalExceptionName = @"UncaughtExceptionHandlerSignalExceptionName";
NSString * const UncaughtExceptionHandlerSignalKey = @"UncaughtExceptionHandlerSignalKey";
NSString * const UncaughtExceptionHandlerAddressesKey = @"UncaughtExceptionHandlerAddressesKey";

volatile int32_t UncaughtExceptionCount = 0;

const int32_t UncaughtExceptionMaximum = 10;
const NSInteger UncaughtExceptionHandlerSkipAddressCount = 4;
const NSInteger UncaughtExceptionHandlerReportAddressCount = 5;

@implementation UncaughtExceptionHandler

+ (NSArray *)backtrace
{
    void* callstack[128];
    int frames = backtrace(callstack, 128);
    char **strs = backtrace_symbols(callstack, frames);
    
    int i;
    NSMutableArray *backtrace = [NSMutableArray arrayWithCapacity:frames];
    for (
         i = UncaughtExceptionHandlerSkipAddressCount;
         i < UncaughtExceptionHandlerSkipAddressCount + UncaughtExceptionHandlerReportAddressCount;
         i++
         )
    {
        [backtrace addObject:[NSString stringWithUTF8String:strs[i]]];
    }
    free(strs);
    
    return backtrace;
}

- (void)handleException:(NSException *)exception
{
    
#if 0
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"程序出现问题啦", nil) message:[NSString stringWithFormat:NSLocalizedString(@"崩溃信息\n"@"%@\n%@", nil), [exception reason], [[exception userInfo] objectForKey:UncaughtExceptionHandlerAddressesKey]] delegate:self cancelButtonTitle:NSLocalizedString(@"离开", nil) otherButtonTitles:nil];
    [alert show];
    
#else
    // 推荐使用
    NSArray *arr = [exception callStackSymbols];
    NSString *reason = [exception reason];
    NSString *name = [exception name];
    
    NSString *url = [NSString stringWithFormat:@"=============异常崩溃报告=============\nname:\n%@\nreason:\n%@\ncallStackSymbols:\n%@",
                     name,reason,[arr componentsJoinedByString:@"\n"]];
    
    NSLog(@"异常日志:[%@]", url);
    
    /*
     //除了可以选择写到应用下的某个文件，通过后续处理将信息发送到服务器等
     //还可以选择调用发送邮件的的程序，发送信息到指定的邮件地址
     //或者调用某个处理程序来处理这个信息
     */
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString* filepath = [NSString stringWithFormat:@"%@/Crash/crashLog.txt", [paths objectAtIndex:0]];
    filepath = filepath.stringByDeletingLastPathComponent;
    if (![[NSFileManager defaultManager] fileExistsAtPath:filepath])
        [[NSFileManager defaultManager] createDirectoryAtPath:filepath withIntermediateDirectories:YES attributes:nil error:nil];
    
    NSLog(@"Crash path = %@",filepath);
    [url writeToFile:filepath atomically:YES encoding:NSUTF8StringEncoding error:nil];
    
#endif
    
//    CFRunLoopRef runLoop = CFRunLoopGetCurrent();
//    CFArrayRef allModes = CFRunLoopCopyAllModes(runLoop);
//    while (!dismissed)
//    {
//        for (NSString *mode in (__bridge NSArray *)allModes)
//        {
//            CFRunLoopRunInMode((CFStringRef)mode, 0.001, false);
//        }
//    }
//    CFRelease(allModes);
    
    
    NSSetUncaughtExceptionHandler(NULL);
    signal(SIGABRT, SIG_DFL);
    signal(SIGILL, SIG_DFL);
    signal(SIGSEGV, SIG_DFL);
    signal(SIGFPE, SIG_DFL);
    signal(SIGBUS, SIG_DFL);
    signal(SIGPIPE, SIG_DFL);
    if ([[exception name] isEqual:UncaughtExceptionHandlerSignalExceptionName])
    {
        kill(getpid(), [[[exception userInfo] objectForKey:UncaughtExceptionHandlerSignalKey] intValue]);
    }
    else
    {
        [exception raise];
    }
}

NSString* getAppInfo()
{
    NSString *appInfo = [NSString stringWithFormat:@"App : %@ %@(%@)\nDevice : %@\nOS Version : %@ %@\n",
                         [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"],
                         [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"],
                         [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"],
                         [UIDevice currentDevice].model,
                         [UIDevice currentDevice].systemName,
                         [UIDevice currentDevice].systemVersion];
    NSLog(@"Crash!!!!!!!!!!!!!![%@]", appInfo);
    return appInfo;
}

void MySignalHandler(int signal)
{
    int32_t exceptionCount = OSAtomicIncrement32(&UncaughtExceptionCount);
    if (exceptionCount > UncaughtExceptionMaximum)
    {
        return;
    }
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionaryWithObject:[NSNumber numberWithInt:signal] forKey:UncaughtExceptionHandlerSignalKey];
    NSArray *callStack = [UncaughtExceptionHandler backtrace];
    [userInfo setObject:callStack forKey:UncaughtExceptionHandlerAddressesKey];
    // 创建一个OC异常对象
    NSException *ex = [NSException exceptionWithName:UncaughtExceptionHandlerSignalExceptionName reason:[NSString stringWithFormat:NSLocalizedString(@"Signal %d was raised.\n"@"%@", nil), signal, getAppInfo()] userInfo:userInfo];
    // 处理异常消息
    [[[UncaughtExceptionHandler alloc] init] performSelectorOnMainThread:@selector(handleException:) withObject:ex waitUntilDone:YES];
}

void HandleException(NSException *exception)
{
    // 递增的一个全局计数器，很快很安全，防止并发数太大
    int32_t exceptionCount = OSAtomicIncrement32(&UncaughtExceptionCount);
    if (exceptionCount > UncaughtExceptionMaximum) return;
    // 获取 堆栈信息的数组
    NSArray *callStack = [UncaughtExceptionHandler backtrace];
    // 设置该字典
    NSMutableDictionary *userInfo =
    [NSMutableDictionary dictionaryWithDictionary:[exception userInfo]];
    // 给 堆栈信息 设置 地址 Key
    [userInfo
     setObject:callStack
     forKey:UncaughtExceptionHandlerAddressesKey];
    
    // 假如崩溃了执行 handleException: ，并且传出 NSException
    [[[UncaughtExceptionHandler alloc] init] performSelectorOnMainThread:@selector(handleException:) withObject:[NSException exceptionWithName:[exception name] reason:[exception reason]
                                                                                                                                      userInfo:userInfo]
                                                           waitUntilDone:YES];
}

void InstallUncaughtExceptionHandler() {
    NSSetUncaughtExceptionHandler(&HandleException);
    signal(SIGABRT, MySignalHandler);
    signal(SIGILL, MySignalHandler);
    signal(SIGSEGV, MySignalHandler);
    signal(SIGFPE, MySignalHandler);
    signal(SIGBUS, MySignalHandler);
    signal(SIGPIPE, MySignalHandler);
}

@end
