//
//  AFNetworingManager.h
//  MKCode
//
//  Created by shendan on 2017/4/7.
//  Copyright © 2017年 Mark. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, RequestMethod){
    Method_GET = 0,
    Method_POST,
};

@interface AFNetworingManager : NSObject

/**
 *  创建单利
 */
+(AFNetworingManager *)sharedInstance;

-(void)requestAFNetworkingWithUrlString:(NSString *)urlString;

@end
