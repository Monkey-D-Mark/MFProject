//
//  MKButton.m
//  MKCode
//
//  Created by shendan on 2017/4/1.
//  Copyright © 2017年 Mark. All rights reserved.
//

#import "MKButton.h"

@implementation MKButton

-(id)initWithFrame:(CGRect)frame buttonStyle:(MKButtonStyle)style {
    if (self = [super initWithFrame:frame]) {
        self.width = frame.size.width;
        self.height = frame.size.height;
        self.buttonStyle = style;
        self.titleLabel.font = [UIFont systemFontOfSize:14];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.imageView.contentMode = UIViewContentModeCenter;
        self.titleLabel.backgroundColor = [UIColor whiteColor];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

    }
    return self;
}

-(CGRect)imageRectForContentRect:(CGRect)contentRect {
    CGFloat x = 0,
            y = 0,
            width = _width,
            height = _height;
    return CGRectMake(x, y, width, height);
}

-(CGRect)titleRectForContentRect:(CGRect)contentRect {
    CGFloat x,
            y,
            width,
            height;
    if (self.buttonStyle == MKButtonStyleTitleDown) {
        x = 0;
        y = _height;
        width = _width;
        height = 15;
        return CGRectMake(x, y, width, height);
    }else if (self.buttonStyle == MKButtonStyleTitleLeft){
        x = -30;
        y = 0;
        width = fabs(x);
        height = _height;
        return CGRectMake(x, y, width, height);
    } else {
        x = _width;
        y = 0;
        width = 30;
        height = _height;
        return CGRectMake(x, y, width, height);
    }
}

@end
