//
//  MKButton.h
//  MKCode
//
//  Created by shendan on 2017/4/1.
//  Copyright © 2017年 Mark. All rights reserved.
//  from QMUI Team.

#import <UIKit/UIKit.h>
#import <CoreGraphics/CoreGraphics.h>
#import <QuartzCore/QuartzCore.h>

typedef NS_ENUM(NSInteger, MKButtonStyle){
    MKButtonStyleTitleBottom,
    MKButtonStyleTitleRight,
    MKButtonStyleTitleTop,
    MKButtonStyleTitleLeft
};

@interface MKButton : UIButton


@property(assign, nonatomic) BOOL adjustsTitleTintColorAutomatically;

@property(nonatomic, assign)  BOOL adjustsImageTintColorAutomatically;

@property(nonatomic, assign)  BOOL adjustsButtonWhenHighlighted;

@property(nonatomic, assign)  BOOL adjustsButtonWhenDisabled;

@property(nonatomic, strong)  UIColor *highlightedBackgroundColor;

@property(nonatomic, strong)  UIColor *highlightedBorderColor;

@property(nonatomic, assign) MKButtonStyle style;

@end
