//
//  SearchHistoryManager.m
//  MKCode
//
//  Created by shendan on 2017/3/20.
//  Copyright © 2017年 Mark. All rights reserved.
//

#import "SearchHistoryManager.h"

@implementation SearchHistoryManager

+(SearchHistoryManager *)sharedManager {
    static SearchHistoryManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[SearchHistoryManager alloc] init];
    });
    return manager;
}

-(void)saveSearchText:(NSString *)searchText {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSArray *searchHistoryArr = [ud objectForKey:@"searchHistoryArr"];
    if (searchHistoryArr.count > 0) {
        
    } else {
        searchHistoryArr = [NSArray array];
    }
    NSMutableArray *searchTextArr = [searchHistoryArr mutableCopy];
    [searchTextArr addObject:searchText];
    if (searchTextArr.count > 5) {
        [searchTextArr removeObjectAtIndex:0];
    }
    [ud setObject:searchTextArr forKey:@"searchHistoryArr"];
    [ud synchronize];
}

-(void)removeAllSearchHistoryArr {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud removeObjectForKey:@"searchHistoryArr"];
    [ud synchronize];
}

-(NSArray *)readUserDefault {
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    NSArray *searchArr = [userDefaultes arrayForKey:@"searchArr"];
    return searchArr;
}

@end

