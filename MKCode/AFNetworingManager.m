//
//  AFNetworingManager.m
//  MKCode
//
//  Created by shendan on 2017/4/7.
//  Copyright © 2017年 Mark. All rights reserved.
//

#import "AFNetworingManager.h"

@implementation AFNetworingManager

+(AFNetworingManager *)sharedInstance {
    static AFNetworingManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[AFNetworingManager alloc] init];
    });
    return manager;
}

-(void)requestAFURL{

}

@end
