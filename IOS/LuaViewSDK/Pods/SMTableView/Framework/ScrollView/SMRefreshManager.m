//
//  SMBaseRefreshManager.m
//  tableivewSimplifyDemo
//
//  Created by 王金东 on 14/12/15.
//  Copyright © 2015年 王金东. All rights reserved.
//

#import "SMRefreshManager.h"

#define defaultKey @"SMRefreshManager_global";

@implementation SMRefreshManager{
    NSMutableDictionary *_refreshDelegate;
}

+ (instancetype)shareInstance {
    static SMRefreshManager *sharedInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (void)registerRefreshViewDataSource:(id<SMScrollViewRefreshDataSource>)delegate {
    [self registerRefreshViewDataSource:delegate forKey:nil];
}
- (void)registerRefreshViewDataSource:(id<SMScrollViewRefreshDataSource>)delegate forKey:(NSString *)key{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _refreshDelegate = [NSMutableDictionary dictionary];
    });
    if(key == nil){
        key = defaultKey;
    }
    [_refreshDelegate setObject:delegate forKey:key];
}

- (id<SMScrollViewRefreshDataSource>)refreshViewDataSourceForKey:(NSString *)key {
    if(key == nil){
        key = defaultKey;
    }
    return [_refreshDelegate objectForKey:key];
}


@end
