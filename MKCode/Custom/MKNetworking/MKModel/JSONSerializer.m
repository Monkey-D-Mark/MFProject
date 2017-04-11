//
//  JSONSerializer.m
//  MKCode
//
//  Created by shendan on 2017/4/11.
//  Copyright © 2017年 Mark. All rights reserved.
//

#import "JSONSerializer.h"
#import "JSONRootModel.h"

@implementation JSONSerializer

-(id)serializeResponseData:(id)data {
    return [[JSONRootModel alloc] initWithDictionary:data];
}

@end
