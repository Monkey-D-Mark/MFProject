//
//  MKCode.h
//  MKCode
//
//  Created by shendan on 2017/3/16.
//  Copyright © 2017年 Mark. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MKCode : NSObject

/**
 *  创建单例
 */
+(MKCode *)sharedInstance;

/**
 *  传入手机号码
 *  返回YES or NO
 */
-(BOOL)isMobileNumber:(NSString *)mobileNum;

/**
 *  判断传入的字符是否为数字
 */
-(BOOL)isNumber:(NSString *)string;

/**
 *  返回一个汉字的宽度
 */
-(CGFloat)widthOfOneChineseCharacter;

/**
 *  将颜色转换image
 */
-(UIImage *)createImageWithColor:(UIColor*) color;

-(NSArray *)mergeArray:(NSArray *)originArr;
-(NSArray *)mergefunction1:(NSArray *)originArr;
-(NSArray *)mergefunction2:(NSArray *)originArr;
-(NSArray *)mergefunction3:(NSArray *)originArr;

@end
