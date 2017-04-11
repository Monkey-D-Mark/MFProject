//
//  JSONRootModel.h
//  MKCode
//
//  Created by shendan on 2017/4/11.
//  Copyright © 2017年 Mark. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JSONRootModel : NSObject

//数据结构是字典时
//@property (strong, nonatomic) KeyModel *key;
//数据结构是数组时
//@property (strong, nonatomic) NSMutableArray <KeyModel *> *key;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
