//
//  SearchHistoryManager.h
//  MKCode
//
//  Created by shendan on 2017/3/20.
//  Copyright © 2017年 Mark. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchHistoryManager : NSObject

+(SearchHistoryManager *)sharedManager;

/**
 *  缓存搜索的数组
 */
-(void)saveSearchText:(NSString *)searchText;

/**
 *  清除搜索缓存数组
 */
-(void)removeAllSearchHistoryArr;

/**
 *  取出缓存的数据
 */
-(NSArray *)readUserDefault;

@end
