//
//  UIView+Utils.h
//  MKCode
//
//  Created by shendan on 2017/4/13.
//  Copyright © 2017年 Mark. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Edge)

//左边框
@property(nonatomic) IBInspectable CGFloat edgeWidthLeft;
@property(nonatomic) IBInspectable UIColor *edgeColorLeft;

//顶边框
@property(nonatomic) IBInspectable CGFloat edgeWidthTop;
@property(nonatomic) IBInspectable UIColor *edgeColorTop;

//右边框
@property(nonatomic) IBInspectable CGFloat edgeWidthRight;
@property(nonatomic) IBInspectable UIColor *edgeColorRight;

//下边框
@property(nonatomic) IBInspectable CGFloat edgeWidthBottom;
@property(nonatomic) IBInspectable UIColor *edgeColorBottom;

//边框开关
@property(nonatomic) IBInspectable BOOL edgeWidthUnitInPixel;
@property(nonatomic) IBInspectable CGFloat edgeZPosition;

@end

@interface UIView(Border)

//边框 颜色 宽度 以及是否开启边框
@property(nonatomic) IBInspectable UIColor *borderColor;
@property(nonatomic) IBInspectable CGFloat borderWidth;
@property(nonatomic) IBInspectable BOOL borderWidthUnitInPixel;

//圆角
@property(nonatomic) IBInspectable CGFloat borderCornerRadius;
@property(nonatomic) IBInspectable UIColor *borderLayerColor;
@property(nonatomic) IBInspectable BOOL clipsToBounds;

//阴影
@property(nonatomic) IBInspectable UIColor *shadowColor;//shadowColor阴影颜色
@property(nonatomic) IBInspectable CGFloat shadowOpacity;//阴影透明度，默认0
@property(nonatomic) IBInspectable CGFloat shadowRadius;//阴影半径，默认3
@property(nonatomic) IBInspectable CGPoint shadowOffset;//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使

@end

@interface UIView (Visibility)

@property(nonatomic) IBInspectable BOOL goneVertical_lc;
@property(nonatomic) IBInspectable BOOL goneHorizontal_lc;

@end

@interface UIView (Xib)

+(UIView *)lc_loadXibIntoView:(UIView *)view owner:(UIView *)owner;

@end

@interface UIView (Utils)

@end
