//
//  XMLRootModel.m
//  MKCode
//
//  Created by shendan on 2017/4/11.
//  Copyright © 2017年 Mark. All rights reserved.
//

#import "XMLRootModel.h"

@implementation XMLRootModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

- (void)setValue:(id)value forKey:(NSString *)key {
    if ([value isKindOfClass:[NSNull class]]) {
        return;
    }
    if ([key isEqualToString:@"yourkey"] && [value isKindOfClass:[NSDictionary class]]) {
        //KeyModel *model = [[KeyModel alloc] initWithDictionary:dictionary];
        //[dataArray addObject:model];
    }
    if ([key isEqualToString:@"yourkey"] && [value isKindOfClass:[NSArray class]]) {
        NSArray *array = value;
        NSMutableArray *dataArray = [NSMutableArray array];
        for (NSDictionary *dictionary in array) {
            //KeyModel *model = [[KeyModel alloc] initWithDictionary:dictionary];
            //[dataArray addObject:model];
        }
        value = dataArray;
    }
    [super setValue:value forKey:key];
}

-(instancetype)initWithDictionary:(NSDictionary *)dictionary {
    if ([dictionary isKindOfClass:[NSDictionary class]]) {
        if (self = [super init]) {
            [self setValuesForKeysWithDictionary:dictionary];
        }
    }
    return self;
}

@end
