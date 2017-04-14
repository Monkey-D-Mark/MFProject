//
//  MKCustomView.h
//  MKCode
//
//  Created by shendan on 2017/4/13.
//  Copyright © 2017年 Mark. All rights reserved.
//

#import <UIKit/UIKit.h>

IBInspectable

@interface MKCustomView : UIView

@property (nonatomic, assign) IBInspectable CGFloat cornerRadius;
@property (nonatomic, assign) IBInspectable CGFloat boderWidth;
@property (nonatomic, assign) IBInspectable UIColor *boderColor;

@end
