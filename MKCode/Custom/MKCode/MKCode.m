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

#pragma mark ***************input number is phonenumber***************

-(BOOL)isMobileNumber:(NSString *)mobileNum {
    NSString *MOBILE = @"^1[34578]\\d{9}$";
    NSPredicate *regexTestMobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",MOBILE];
    if ([regexTestMobile evaluateWithObject:mobileNum]) {
        return YES;
    } else {
        return NO;
    }
}

#pragma mark ***************input character is number***************

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

#pragma mark ***************Chinese Character width***************

-(CGFloat)widthOfOneChineseCharacter {
    NSString *oneChinese = @"一";
    CGSize oneWordSize = [oneChinese boundingRectWithSize:CGSizeMake(100, 1000) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil].size;
    CGFloat width = oneWordSize.width;
    return width;
}

#pragma mark ***************merge in order***************

///有序集合
-(NSArray *)mergeArray:(NSArray *)originArr {
    NSOrderedSet *set =  [NSOrderedSet orderedSetWithArray:originArr];
    return set.array;
}

///开辟新的内存空间，然后判断是否存在，若不存在则添加到数组中，得到最终结果的顺序不发生变化。效率分析：时间复杂度为O ( n2 )：
-(NSArray *)mergefunction1:(NSArray *)originArr  {
    NSMutableArray *resultArray = [[NSMutableArray alloc] initWithCapacity:originArr.count];
    // 外层一个循环
    for (NSString *item in originArr) {
        // 调用-containsObject:本质也是要循环去判断，因此本质上是双层遍历
        // 时间复杂度为O ( n^2 )而不是O (n)
        if (![resultArray containsObject:item]) {
            [resultArray addObject:item];
        }
    }
    return resultArray;
}

///第二种方法：利用NSDictionary去重，字典在设置key-value时，若已存在则更新值，若不存在则插入值，然后获取allValues。若不要求有序，则可以采用此种方法。若要求有序，还得进行排序。效率分析：只需要一个循环就可以完成放入字典，若不要求有序，时间复杂度为O(n)。若要求排序，则效率与排序算法有关：
-(NSArray *)mergefunction2:(NSArray *)originArr {
    //    originArr = [originArr valueForKeyPath:@"@distinctUnionOfObjects.self"];
    //    NSLog(@"%@", originArr );
    
    NSMutableDictionary *resultDict = [[NSMutableDictionary alloc] initWithCapacity:originArr.count];
    for (NSString *item in originArr) {
        [resultDict setObject:item forKey:item];
    }
    NSArray *resultArray = resultDict.allValues;
    resultArray = [resultArray sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1,id  _Nonnull obj2) {
        NSString *item1 = obj1;
        NSString *item2 = obj2;
        return [item1 compare:item2 options:NSLiteralSearch];
    }];
    return resultArray;
}

///第三种方法：利用集合NSSet的特性(确定性、无序性、互异性)，放入集合就自动去重了。但是它与字典拥有同样的无序性，所得结果顺序不再与原来一样。如果不要求有序，使用此方法与字典的效率应该是差不多的。效率分析：时间复杂度为O (n)：
-(NSArray *)mergefunction3:(NSArray *)originArr {
    NSSet *set = [NSSet setWithArray:originArr];
    NSArray *resultArray = [set allObjects];
    
    resultArray = [resultArray sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1,id  _Nonnull obj2) {
        NSString *item1 = obj1;
        NSString *item2 = obj2;
        return [item1 compare:item2 options:NSLiteralSearch];
    }];
    return resultArray;
}

#pragma mark ***************get current viewcontroller***************

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
    if (window.windowLevel != UIWindowLevelNormal) {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows) {
            if (tmpWin.windowLevel == UIWindowLevelNormal) {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]]) {
        result = nextResponder;
    } else {
        result = window.rootViewController;
    }
    return result;
}

@end
