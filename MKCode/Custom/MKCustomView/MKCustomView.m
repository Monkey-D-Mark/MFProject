//
//  MKCustomView.m
//  MKCode
//
//  Created by shendan on 2017/4/13.
//  Copyright © 2017年 Mark. All rights reserved.
//

#import "MKCustomView.h"

IB_DESIGNABLE

@implementation MKCustomView

-(void)setCornerRadius:(CGFloat)cornerRadius {
    _cornerRadius = cornerRadius;
    self.layer.cornerRadius = _cornerRadius;
}

-(void)setBoderColor:(UIColor *)boderColor {
    _boderColor = boderColor;
    self.layer.borderColor = _boderColor.CGColor;
}

-(void)setBoderWidth:(CGFloat)boderWidth {
    _boderWidth = boderWidth;
    self.layer.borderWidth = _boderWidth;
}

@end
