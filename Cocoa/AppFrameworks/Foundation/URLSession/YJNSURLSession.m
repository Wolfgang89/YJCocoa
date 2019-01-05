//
//  YJNSURLSession.m
//  YJFoundation
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2016/11/29.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import "YJNSURLSession.h"
#import "YJNSLog.h"

@implementation YJNSURLSession

+ (void)resumeAllNeedTask {
    NSArray *allEffectiveTask = [self allEffectiveTask];
    for (YJNSURLSessionTask *task in allEffectiveTask) {
        if (task.needResume && task.request.supportResume && task.request.source) {
            YJLogInfo(@"%@重发网络请求>>>>>>>>>>>>>>>", task.request.identifier);
            [task resume];
        }
    }
}

+ (NSArray *)allEffectiveTask {
    YJNSCache *cache = YJNSURLSessionPoolS.cache;
    NSMutableArray *allEffectiveTask = [NSMutableArray arrayWithCapacity:cache.count];
    for (YJNSURLSessionTask *task in cache.allValues) {
        YJNSURLRequest *request = task.request;
        request.source ? [allEffectiveTask addObject:task] : [cache removeObjectForKey:request.identifier];
    }    
    return allEffectiveTask;
}

@end
