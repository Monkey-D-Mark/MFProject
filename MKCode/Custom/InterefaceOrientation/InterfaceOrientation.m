
//
//  InterfaceOrientation.m
//  TestDemo
//
//  Created by shendan on 2017/4/19.
//  Copyright © 2017年 Mark. All rights reserved.
//

#import "InterfaceOrientation.h"

@implementation InterfaceOrientation

+ (InterfaceOrientationType)orientation{
    
    CGFloat scale = [UIScreen mainScreen].scale;
    CGSize nativeSize = [UIScreen mainScreen].currentMode.size;
    CGSize sizeInPoints = [UIScreen mainScreen].bounds.size;
    
    InterfaceOrientationType result;
    
    if(scale * sizeInPoints.width == nativeSize.width){
        result = InterfaceOrientationTypePortrait;
    }else{
        result = InterfaceOrientationTypeLandscape;
    }
    return result;
}

@end
