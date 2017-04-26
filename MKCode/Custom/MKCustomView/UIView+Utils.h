//
//  UIView+Utils.h
//  MKCode
//
//  Created by shendan on 2017/4/13.
//  Copyright © 2017年 Mark. All rights reserved.
//  转自https://my.oschina.net/iceTear/blog

#import <UIKit/UIKit.h>

@interface UIView(Edge)
//左边框
@property(nonatomic) IBInspectable CGFloat edgeWidthLeft_lc;
@property(nonatomic) IBInspectable UIColor * edgeColorLeft_lc;
//顶边框
@property(nonatomic) IBInspectable CGFloat edgeWidthTop_lc;
@property(nonatomic) IBInspectable UIColor * edgeColorTop_lc;
//右边框
@property(nonatomic) IBInspectable CGFloat edgeWidthRight_lc;
@property(nonatomic) IBInspectable UIColor * edgeColorRight_lc;
//下边框
@property(nonatomic) IBInspectable CGFloat edgeWidthBottom_lc;
@property(nonatomic) IBInspectable UIColor * edgeColorBottom_lc;

//边框开关
@property(nonatomic) IBInspectable BOOL edgeWidthUnitInPixel_lc;

@property(nonatomic) IBInspectable CGFloat edgeZPosition_lc;
@end

@interface UIView(Border)
//边框 颜色 宽度 以及是否开启边框
@property(nonatomic) IBInspectable UIColor * borderColor_lc;
@property(nonatomic) IBInspectable CGFloat borderWidth_lc;
@property(nonatomic) IBInspectable BOOL borderWidthUnitInPixel_l;
//圆角
@property(nonatomic) IBInspectable CGFloat borderCornerRadius_lc;
@property(nonatomic) IBInspectable UIColor * borderLayerColor_lc;
@property(nonatomic) IBInspectable BOOL clipsToBounds_lc;
//阴影
@property(nonatomic) IBInspectable UIColor * shadowColor_lc;//shadowColor阴影颜色
@property(nonatomic) IBInspectable CGFloat shadowOpacity_lc;//阴影透明度，默认0
@property(nonatomic) IBInspectable CGFloat shadowRadius_lc;//阴影半径，默认3
@property(nonatomic) IBInspectable CGPoint shadowOffset_lc;//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使
@end


@interface UIView (Visibility)
@property(nonatomic) IBInspectable BOOL goneVertical_lc;
@property(nonatomic) IBInspectable BOOL goneHorizontal_lc;
@end

@interface UIView (Xib)
+ (UIView*) lc_loadXibIntoView:(UIView *)view owner:(UIView *)owner;
@end
