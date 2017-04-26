//
//  MKButton.m
//  MKCode
//
//  Created by shendan on 2017/4/1.
//  Copyright © 2017年 Mark. All rights reserved.
//  from QMUI Team.

#import "MKButton.h"

@interface MKButton ()
@property(nonatomic, strong) CALayer *highlightedBackgroundLayer;
@property(nonatomic, strong) UIColor *originBorderColor;
-(void)initialized;
@end

@implementation MKButton

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initialized];
    }
    return self;
}

-(void)initialized {
    self.adjustsTitleTintColorAutomatically = NO;
    self.adjustsImageTintColorAutomatically = NO;
    self.tintColor = [UIColor blueColor];
    if (!self.adjustsTitleTintColorAutomatically) {
        [self setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    }
    
    self.adjustsImageWhenHighlighted = NO;
    self.adjustsImageWhenDisabled = NO;
    self.adjustsButtonWhenHighlighted = YES;
    self.adjustsButtonWhenDisabled = YES;

    self.contentEdgeInsets = UIEdgeInsetsMake(1, 0, 1, 0);
    
    self.style = MKButtonStyleTitleRight;
}

-(CGSize)sizeThatFits:(CGSize)size {
    if (CGSizeEqualToSize(self.bounds.size, size)) {
        size = CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX);
    }
    CGSize resultSize = CGSizeZero;
    
    CGSize contentLimiteSize = CGSizeMake(size.width - UIEdgeInsetsGetHorizontalValue(self.contentEdgeInsets), size.height - UIEdgeInsetsGetVerticalValue(self.contentEdgeInsets));
    switch (self.style) {
        case MKButtonStyleTitleBottom:
        case MKButtonStyleTitleTop:{
            CGFloat imageLimitWidth = contentLimiteSize.width - UIEdgeInsetsGetHorizontalValue(self.imageEdgeInsets);
            CGSize imageSize = [self.imageView sizeThatFits:CGSizeMake(imageLimitWidth, CGFLOAT_MAX)];
            
            CGSize titleLimitSize = CGSizeMake(contentLimiteSize.width - UIEdgeInsetsGetHorizontalValue(self.titleEdgeInsets), contentLimiteSize.height - UIEdgeInsetsGetVerticalValue(self.imageEdgeInsets) - imageSize.height - UIEdgeInsetsGetVerticalValue(self.titleEdgeInsets));
            CGSize titleSize = [self.titleLabel sizeThatFits:titleLimitSize];
            titleSize.height = fminf(titleSize.height, titleLimitSize.height);
            
            resultSize.width = UIEdgeInsetsGetHorizontalValue(self.contentEdgeInsets);
            resultSize.width += fmaxf(UIEdgeInsetsGetHorizontalValue(self.imageEdgeInsets) + imageSize.width, UIEdgeInsetsGetHorizontalValue(self.titleEdgeInsets) + titleSize.width);
            resultSize.height = UIEdgeInsetsGetVerticalValue(self.contentEdgeInsets) + UIEdgeInsetsGetVerticalValue(self.imageEdgeInsets) + imageSize.height + UIEdgeInsetsGetVerticalValue(self.titleEdgeInsets) + titleSize.height;
        }
            break;
        case MKButtonStyleTitleRight:
        case MKButtonStyleTitleLeft:{
            if (self.style == MKButtonStyleTitleRight && self.titleLabel.numberOfLines == 1) {
                resultSize = [super sizeThatFits:size];
            } else {
                CGFloat imageLimitHeight = contentLimiteSize.height - UIEdgeInsetsGetVerticalValue(self.imageEdgeInsets);
                CGSize imageSize = [self.imageView sizeThatFits:CGSizeMake(CGFLOAT_MAX, imageLimitHeight)];
                
                CGSize titleLimitSize = CGSizeMake(contentLimiteSize.width - UIEdgeInsetsGetHorizontalValue(self.titleEdgeInsets) - imageSize.width - UIEdgeInsetsGetHorizontalValue(self.imageEdgeInsets), contentLimiteSize.height - UIEdgeInsetsGetVerticalValue(self.titleEdgeInsets));
                CGSize titleSize = [self.titleLabel sizeThatFits:titleLimitSize];
                titleSize.height = fminf(titleSize.height, titleLimitSize.height);
                
                resultSize.width = UIEdgeInsetsGetHorizontalValue(self.contentEdgeInsets) + UIEdgeInsetsGetHorizontalValue(self.imageEdgeInsets) + imageSize.width + UIEdgeInsetsGetHorizontalValue(self.titleEdgeInsets) + titleSize.width;
                resultSize.height = UIEdgeInsetsGetVerticalValue(self.contentEdgeInsets);
                resultSize.height += fmaxf(UIEdgeInsetsGetVerticalValue(self.imageEdgeInsets) + imageSize.height, UIEdgeInsetsGetVerticalValue(self.titleEdgeInsets) +titleSize.height);
            }
        }
            break;
    }
    return resultSize;
}

-(void)layoutSubviews {
    [super layoutSubviews];
    
    if (CGRectIsEmpty(self.bounds)) {
        return;
    }
    
    if (self.style == MKButtonStyleTitleRight) {
        return;
    }
}

-(void)setStyle:(MKButtonStyle)style {
    _style = style;
    [self setNeedsLayout];
}

-(void)setHighlightedBackgroundColor:(UIColor *)highlightedBackgroundColor {
    _highlightedBackgroundColor = highlightedBackgroundColor;
    if (_highlightedBackgroundColor) {
        // 只要开启了highlightedBackgroundColor，就默认不需要alpha的高亮
        self.adjustsButtonWhenHighlighted = NO;
    }
}

-(void)setHighlightedBorderColor:(UIColor *)highlightedBorderColor {
    _highlightedBorderColor = highlightedBorderColor;
    if (_highlightedBorderColor) {
        // 只要开启了highlightedBackgroundColor，就默认不需要alpha的高亮
        self.adjustsButtonWhenHighlighted = NO;
    }
}

-(void)setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];
    
    if (highlighted && !self.originBorderColor) {
         // 手指按在按钮上会不断触发setHighlighted:，所以这里做了保护，设置过一次就不用再设置了
        self.originBorderColor = [UIColor colorWithCGColor:self.layer.borderColor];
    }
    // 渲染背景色
    if (self.highlightedBackgroundColor || self.highlightedBorderColor) {
        //[self adjustsButtonHighlighted];
    }
    // 如果此时是disabled，则disabled的样式优先
    if (!self.enabled) {
        return;
    }
    if (self.adjustsButtonWhenHighlighted) {
        if (highlighted) {
            self.alpha = 0.5f;
        } else {
            [UIView animateWithDuration:0.25f animations:^{
                self.alpha = 1;
            }];
        }
    }
}

-(void)setEnabled:(BOOL)enabled {
    [super setEnabled:enabled];
    if (!enabled && self.adjustsButtonWhenDisabled) {
        self.alpha = 0.5f;
    } else {
        [UIView animateWithDuration:0.25f animations:^{
            self.alpha = 1;
        }];
    }
}

-(void)adjustsButtonHighlighted {
    if (self.highlightedBackgroundColor) {
        if (!self.highlightedBackgroundLayer) {
            self.highlightedBackgroundLayer = [CALayer layer];
            [self removeDefaultAnimations:self.highlightedBackgroundLayer];
            [self.layer insertSublayer:self.highlightedBackgroundLayer atIndex:0];
        }
        self.highlightedBackgroundLayer.frame = self.bounds;
        self.highlightedBackgroundLayer.cornerRadius = self.layer.cornerRadius;
        self.highlightedBackgroundLayer.backgroundColor = self.highlighted ? self.highlightedBackgroundColor.CGColor : [UIColor clearColor].CGColor;
    }
    if (self.highlightedBorderColor) {
        self.layer.borderColor = self.highlighted ? self.highlightedBorderColor.CGColor : self.originBorderColor.CGColor;
    }
}

-(void)setAdjustsTitleTintColorAutomatically:(BOOL)adjustsTitleTintColorAutomatically {
    _adjustsTitleTintColorAutomatically = adjustsTitleTintColorAutomatically;
    [self updateTitleColorIfNeeded];
}

-(void)updateTitleColorIfNeeded {
    if (self.adjustsTitleTintColorAutomatically && self.currentTitleColor) {
        [self setTitleColor:self.tintColor forState:UIControlStateNormal];
    }
    if (self.adjustsTitleTintColorAutomatically && self.currentAttributedTitle) {
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:self.currentAttributedTitle];
        [attributedString addAttribute:NSForegroundColorAttributeName value:self.tintColor range:NSMakeRange(0, attributedString.length)];
        [self setAttributedTitle:attributedString forState:UIControlStateNormal];
    }
}

-(void)setAdjustsImageTintColorAutomatically:(BOOL)adjustsImageTintColorAutomatically {
    BOOL valueDifference = _adjustsImageTintColorAutomatically;
    _adjustsImageTintColorAutomatically = adjustsImageTintColorAutomatically;
    if (valueDifference) {
      [self updateImageRenderingModeIfNeeded];
    }
}

-(void)updateImageRenderingModeIfNeeded {
    if (self.currentImage) {
        NSArray<NSNumber *> *states = @[@(UIControlStateNormal),@(UIControlStateHighlighted),@(UIControlStateDisabled)];
        for (NSNumber *number in states) {
            UIImage *image = [self imageForState:[number unsignedIntegerValue]];
            if (!image) {
                continue;
            }
            if (self.adjustsImageTintColorAutomatically) {
                [self setImage:image forState:[number unsignedIntegerValue]];
            } else {
                [self setImage:[image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:[number unsignedIntegerValue]];
            }
        }
    }
}

-(void)setImage:(UIImage *)image forState:(UIControlState)state {
    if (self.adjustsImageTintColorAutomatically) {
        image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    }
    [super setImage:image forState:state];
}

-(void)tintColorDidChange {
    [super tintColorDidChange];
    [self updateTitleColorIfNeeded];
    if (self.adjustsImageTintColorAutomatically) {
        [self updateImageRenderingModeIfNeeded];
    }
}


- (void)removeDefaultAnimations:(CALayer *)layer {
    layer.actions = @{@"sublayers": [NSNull null],
                     @"contents": [NSNull null],
                     @"bounds": [NSNull null],
                     @"frame": [NSNull null],
                     @"position": [NSNull null],
                     @"anchorPoint": [NSNull null],
                     @"cornerRadius": [NSNull null],
                     @"transform": [NSNull null],
                     @"hidden": [NSNull null],
                     @"opacity": [NSNull null],
                     @"backgroundColor": [NSNull null],
                     @"shadowColor": [NSNull null],
                     @"shadowOpacity": [NSNull null],
                     @"shadowOffset": [NSNull null],
                     @"shadowRadius": [NSNull null],
                     @"shadowPath": [NSNull null]};
}

/// 获取UIEdgeInsets在水平方向上的值
CG_INLINE CGFloat
UIEdgeInsetsGetHorizontalValue(UIEdgeInsets insets) {
    return insets.left + insets.right;
}

/// 获取UIEdgeInsets在垂直方向上的值
CG_INLINE CGFloat
UIEdgeInsetsGetVerticalValue(UIEdgeInsets insets) {
    return insets.top + insets.bottom;
}

@end
