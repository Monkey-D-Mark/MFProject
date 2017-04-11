//
//  XMLSerializer.m
//  MKCode
//
//  Created by shendan on 2017/4/11.
//  Copyright © 2017年 Mark. All rights reserved.
//

#import "XMLSerializer.h"
#import "XMLDictionary.h"
#import "XMLRootModel.h"

@implementation XMLSerializer

-(id)serializeResponseData:(id)data {
    NSData *responseData = data;
    NSString *str =  [[NSString alloc]initWithData:responseData encoding:NSUTF8StringEncoding];
    NSDictionary *xmlDic = [NSDictionary dictionaryWithXMLString:str];
    return [[XMLRootModel alloc] initWithDictionary:xmlDic];
}

@end
