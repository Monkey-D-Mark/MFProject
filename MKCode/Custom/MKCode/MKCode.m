//
//  MKCode.m
//  MKCode
//
//  Created by shendan on 2017/3/16.
//  Copyright © 2017年 Mark. All rights reserved.
//

#import "MKCode.h"

@implementation MKCode

-(id)init {
    if (self = [super init]) {
        
    }
    return self;
}

+(MKCode *)sharedInstance {
    static MKCode *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[MKCode alloc] init];
    });
    return instance;
}

-(BOOL)isMobileNumber:(NSString *)mobileNum {
    NSString *MOBILE = @"^1[34578]\\d{9}$";
    NSPredicate *regexTestMobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",MOBILE];
    if ([regexTestMobile evaluateWithObject:mobileNum]) {
        return YES;
    } else {
        return NO;
    }
}

-(BOOL)isNumber:(NSString *)string {
    NSString *number = @"^[0-9]*$";
    NSPredicate *regexText = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",number];
    if ([regexText evaluateWithObject:string]) {
        return YES;
    } else {
        return NO;
    }
}

#pragma mark ***************color to image***************

-(UIImage *)createImageWithColor:(UIColor*) color {
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}


-(CGFloat)widthOfOneChineseCharacter {
    NSString *oneChinese = @"一";
    CGSize oneWordSize = [oneChinese boundingRectWithSize:CGSizeMake(100, 1000) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil].size;
    CGFloat width = oneWordSize.width;
    return width;
}

//有序集合
-(NSArray *)mergeArray:(NSArray *)originArr {
    NSOrderedSet *set =  [NSOrderedSet orderedSetWithArray:originArr];
    return set.array;
}

- (UIViewController *)getPresentedViewController {
    UIViewController *appRootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *topVC = appRootVC;
    if (topVC.presentedViewController) {
        topVC = topVC.presentedViewController;
    }
    return topVC;
}

- (UIViewController *)getCurrentVC {
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]]){
        result = nextResponder;
    } else {
        result = window.rootViewController;
    }
    return result;
}

@end
