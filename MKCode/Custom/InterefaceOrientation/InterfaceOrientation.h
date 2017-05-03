//
//  InterfaceOrientation.h
//  TestDemo
//
//  Created by shendan on 2017/4/19.
//  Copyright © 2017年 Mark. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, InterfaceOrientationType) {
    InterfaceOrientationTypePortrait,
    InterfaceOrientationTypeLandscape
};

@interface InterfaceOrientation : NSObject

+ (InterfaceOrientationType)orientation;

@end
