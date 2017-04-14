//
//  UIView+Utils.m
//  MKCode
//
//  Created by shendan on 2017/4/13.
//  Copyright © 2017年 Mark. All rights reserved.
//

#import "UIView+Utils.h"
#import <objc/runtime.h>

@interface LCEdgeLayer : CALayer

@property(nonatomic) UIEdgeInsets edges;

@property(nonatomic) UIColor *leftColor;
@property(nonatomic) UIColor *topColor;
@property(nonatomic) UIColor *rightColor;
@property(nonatomic) UIColor *bottomColor;

@property(nonatomic) BOOL widthUnitInPixel;

@end

@implementation LCEdgeLayer

- (void)setLeftColor:(UIColor *)leftColor {
    _leftColor = leftColor;
    [self setNeedsDisplay];
}

- (void)setRightColor:(UIColor *)rightColor {
    _rightColor = rightColor;
    [self setNeedsDisplay];
}

- (void)setTopColor:(UIColor *)topColor {
    _topColor = topColor;
    [self setNeedsDisplay];
}

- (void)setBottomColor:(UIColor *)bottomColor {
    _bottomColor = bottomColor;
    [self setNeedsDisplay];
}

- (void)setEdges:(UIEdgeInsets)edges {
    _edges = edges;
    [self setNeedsDisplay];
}

-(void)setWidthUnitInPixel:(BOOL)widthUnitInPixel {
    _widthUnitInPixel = widthUnitInPixel;
    [self setNeedsDisplay];
}

- (void)drawInContext:(CGContextRef)ctx {
    const CGFloat ONE_PIXEL_WIDTH = 1.0 / self.contentsScale;
    if (_edges.left > 0 && _leftColor) {
        CGContextSetFillColorWithColor(ctx, _leftColor.CGColor);
        CGRect rect = self.bounds;
        if (_widthUnitInPixel)
            rect.size.width = _edges.left * ONE_PIXEL_WIDTH;
        else
            rect.size.width = _edges.left;
        CGContextFillRect(ctx, rect);
    }
    
    if (_edges.top > 0 && _topColor) {
        CGContextSetFillColorWithColor(ctx, _topColor.CGColor);
        CGRect rect = self.bounds;
        if (_widthUnitInPixel)
            rect.size.height = _edges.top * ONE_PIXEL_WIDTH;
        else
            rect.size.height = _edges.top;
        CGContextFillRect(ctx, rect);
    }
    
    if (_edges.right > 0 && _rightColor) {
        CGContextSetFillColorWithColor(ctx, _rightColor.CGColor);
        CGRect rect = self.bounds;
        if (_widthUnitInPixel){
            rect.origin.x += (rect.size.width - _edges.right * ONE_PIXEL_WIDTH);
            rect.size.width = _edges.right * ONE_PIXEL_WIDTH;
        }else{
            rect.origin.x += (rect.size.width - _edges.right);
            rect.size.width = _edges.right;
        }
        CGContextFillRect(ctx, rect);
    }
    
    if (_edges.bottom > 0 && _bottomColor) {
        CGContextSetFillColorWithColor(ctx, _bottomColor.CGColor);
        CGRect rect = self.bounds;
        if (_widthUnitInPixel){
            rect.origin.y += (rect.size.height - _edges.bottom * ONE_PIXEL_WIDTH);
            rect.size.height = _edges.bottom * ONE_PIXEL_WIDTH;
        }else{
            rect.origin.y += (rect.size.height - _edges.bottom);
            rect.size.height = _edges.bottom;
        }
        CGContextFillRect(ctx, rect);
    }
}

@end

@interface CALayer (Edge)

-(LCEdgeLayer *) lc_findEdgeLayer;
-(LCEdgeLayer *) lc_ensureEdgeLayer;

@end

@implementation CALayer (Hook)
#if !TARGET_INTERFACE_BUILDER
+ (void)load {
    Method m1 = class_getInstanceMethod(self, @selector(lc_layoutSublayers));
    Method m2 = class_getInstanceMethod(self, @selector(layoutSublayers));
    method_exchangeImplementations(m1, m2);
}

- (void)lc_layoutSublayers {
    [self lc_layoutSublayers];
    
    [self lc_findEdgeLayer].frame = self.bounds;
}
#endif

-(LCEdgeLayer*) lc_findEdgeLayer {
    for (CALayer *layer in self.sublayers) {
        if ([layer isKindOfClass:LCEdgeLayer.class]) {
            return (LCEdgeLayer*)layer;
        }
    }
    return nil;
}

-(LCEdgeLayer*) lc_ensureEdgeLayer{
    
    return [self lc_findEdgeLayer] ?: ({
        LCEdgeLayer * edgeLayer = [LCEdgeLayer layer];
        edgeLayer.contentsScale = [UIScreen mainScreen].scale;;
        edgeLayer.frame = self.bounds;
        edgeLayer.needsDisplayOnBoundsChange = YES;
        [self insertSublayer:edgeLayer atIndex:0];
        
        edgeLayer;
    });
}

@end

@implementation UIView (Edge)

#pragma -mark WIDTH
- (CGFloat)edgeWidthLeft{
    return [self.layer lc_findEdgeLayer].edges.left;
}

-(void)setEdgeWidthLeft:(CGFloat)edgeWidthLeft{
    LCEdgeLayer * layer = [self.layer lc_ensureEdgeLayer];
    UIEdgeInsets edges = layer.edges;
    edges.left = edgeWidthLeft;
    layer.edges = edges;
}

- (CGFloat)edgeWidthRight{
    return [self.layer lc_findEdgeLayer].edges.right;
}

-(void)setEdgeWidthRight:(CGFloat)edgeWidthRight{
    LCEdgeLayer * layer = [self.layer lc_ensureEdgeLayer];
    UIEdgeInsets edges = layer.edges;
    edges.right = edgeWidthRight;
    layer.edges = edges;
}

- (CGFloat)edgeWidthTop{
    return [self.layer lc_findEdgeLayer].edges.top;
}

-(void)setEdgeWidthTop:(CGFloat)edgeWidthTop{
    LCEdgeLayer * layer = [self.layer lc_ensureEdgeLayer];
    UIEdgeInsets edges = layer.edges;
    edges.top = edgeWidthTop;
    layer.edges = edges;
}

- (CGFloat)edgeWidthBottom{
    return [self.layer lc_findEdgeLayer].edges.bottom;
}

-(void)setEdgeWidthBottom:(CGFloat)edgeWidthBottom_lc{
    LCEdgeLayer * layer = [self.layer lc_ensureEdgeLayer];
    UIEdgeInsets edges = layer.edges;
    edges.bottom = edgeWidthBottom_lc;
    layer.edges = edges;
}

- (BOOL)edgeWidthUnitInPixel{
    return [self.layer lc_findEdgeLayer].widthUnitInPixel;
}

-(void)setEdgeWidthUnitInPixel:(BOOL)edgeWidthUnitInPixel{
    [self.layer lc_ensureEdgeLayer].widthUnitInPixel = edgeWidthUnitInPixel;
}

- (CGFloat)edgeZPosition{
    return [self.layer lc_findEdgeLayer].zPosition;
}

-(void)setEdgeZPosition:(CGFloat)edgeZPosition{
    LCEdgeLayer * layer = [self.layer lc_ensureEdgeLayer];
    layer.zPosition = edgeZPosition;
#if TARGET_INTERFACE_BUILDER
    [layer removeFromSuperlayer];
    
    for(CALayer * sub in self.layer.sublayers){
        if(edgeZPosition_lc <= sub.zPosition){
            [self.layer insertSublayer:layer below:sub];
            break;
        }
    }
    
    if(!layer.superlayer)
        [self.layer addSublayer:layer];
    
#endif
    
}

#pragma -mark COLOR
-(UIColor *)edgeColorLeft{
    return [self.layer lc_findEdgeLayer].leftColor;
}

-(void)setEdgeColorLeft:(UIColor *)edgeColorLeft{
    [self.layer lc_ensureEdgeLayer].leftColor = edgeColorLeft;
}

-(UIColor *)edgeColorRight{
    return [self.layer lc_findEdgeLayer].rightColor;
}

-(void)setEdgeColorRight:(UIColor *)edgeColorRight{
    [self.layer lc_ensureEdgeLayer].rightColor = edgeColorRight;
}

-(UIColor *)edgeColorTop{
    return [self.layer lc_findEdgeLayer].topColor;
}

-(void)setEdgeColorTop:(UIColor *)edgeColorTop{
    [self.layer lc_ensureEdgeLayer].topColor = edgeColorTop;
}

-(UIColor *)edgeColorBottom{
    return [self.layer lc_findEdgeLayer].bottomColor;
}

-(void)setEdgeColorBottom:(UIColor *)edgeColorBottom{
    [self.layer lc_ensureEdgeLayer].bottomColor = edgeColorBottom;
}

@end

@implementation UIView(Border)

-(UIColor *)borderColor{
    return [UIColor colorWithCGColor:self.layer.borderColor];
}
-(void)setBorderColor:(UIColor *)borderColor{
    self.layer.borderColor = borderColor.CGColor;
}

-(CGFloat)borderWidth{
    return [objc_getAssociatedObject(self, _cmd) floatValue];
}

-(void)setBorderWidth:(CGFloat)borderWidth{
    objc_setAssociatedObject(self, @selector(borderWidth), @(borderWidth), OBJC_ASSOCIATION_RETAIN);
    
    if(self.borderWidthUnitInPixel)
        self.layer.borderWidth = borderWidth / [UIScreen mainScreen].scale;
    else
        self.layer.borderWidth = borderWidth;
}

-(BOOL)borderWidthUnitInPixel{
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

-(void)setBorderWidthUnitInPixel:(BOOL)borderWidthUnitInPixel{
    objc_setAssociatedObject(self, @selector(borderWidthUnitInPixel), @(borderWidthUnitInPixel), OBJC_ASSOCIATION_RETAIN);
    
    if(borderWidthUnitInPixel)
        self.layer.borderWidth = self.borderWidth / [UIScreen mainScreen].scale;
    else
        self.layer.borderWidth = self.borderWidth;
}

-(CGFloat)borderCornerRadius{
    return self.layer.cornerRadius;
}

-(void)setBorderCornerRadius:(CGFloat)borderCornerRadius{
    self.layer.cornerRadius = borderCornerRadius;
}

-(UIColor *)borderLayerColor{
    return [UIColor colorWithCGColor: self.layer.backgroundColor];
}

-(void)setBorderLayerColor:(UIColor *)borderLayerColor{
    self.layer.backgroundColor = borderLayerColor.CGColor;
}

-(BOOL)clipsToBounds{
    return self.clipsToBounds;
}

-(void)setClipsToBounds:(BOOL)clipToBounds{
    self.clipsToBounds = clipToBounds;
}

-(UIColor *)shadowColor{
    return [UIColor colorWithCGColor:self.layer.shadowColor];
}

-(void)setShadowColor:(UIColor *)shadowColor{
    self.layer.shadowColor = shadowColor.CGColor;
}

-(CGFloat)shadowOpacity{
    return self.layer.shadowOpacity;
}

-(void)setShadowOpacity:(CGFloat)shadowOpacity{
    self.layer.shadowOpacity = shadowOpacity;
}

-(CGFloat)shadowRadius{
    return self.layer.shadowRadius;
}

-(void)setShadowRadius:(CGFloat)shadowRadius{
    self.layer.shadowRadius = shadowRadius;
}

-(CGPoint)shadowOffset{
    CGSize size = self.layer.shadowOffset;
    return CGPointMake(size.width, size.height);
}

-(void)setShadowOffset:(CGPoint)shadowOffset{
    
    self.layer.shadowOffset =
#if TARGET_INTERFACE_BUILDER
    CGSizeMake(shadowOffset.x, -shadowOffset.y);
#else
    CGSizeMake(shadowOffset.x, shadowOffset.y);
#endif
    
}

@end

@interface LCLayoutConstraint : NSLayoutConstraint

+ (instancetype) constraintOfZeroAttribute:(NSLayoutAttribute) attr toView:(UIView*)view;

@end

@implementation LCLayoutConstraint

+ (instancetype) constraintOfZeroAttribute:(NSLayoutAttribute) attr toView:(UIView*)view{
    return [self constraintWithItem:view attribute:attr relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:0];
}

@end


@implementation UIView(Visibility)
- (LCLayoutConstraint*) findConstraintByAttribute:(NSLayoutAttribute)attr{
    for(NSLayoutConstraint * con in self.constraints){
        if([con isKindOfClass:LCLayoutConstraint.class] &&
           con.firstAttribute == attr)
            return (LCLayoutConstraint*)con;
    }
    return nil;
}

- (LCLayoutConstraint*) ensureConstraintByAttribute:(NSLayoutAttribute)attr{
    return [self findConstraintByAttribute:attr] ?:({
        LCLayoutConstraint *con = [LCLayoutConstraint constraintOfZeroAttribute:attr toView:self];
        [self addConstraint:con];
        con;
    });
}

- (BOOL)goneHorizontal_lc{
    return [self findConstraintByAttribute:NSLayoutAttributeWidth];
}

-(void)setGoneHorizontal_lc:(BOOL)goneHorizontal_lc{
    if(goneHorizontal_lc){
        [self ensureConstraintByAttribute:NSLayoutAttributeWidth];
    }else{
        NSLayoutConstraint * cons = [self findConstraintByAttribute:NSLayoutAttributeWidth];
        if(cons)
            [self removeConstraint:cons];
    }
}

-(BOOL)goneVertical_lc{
    return [self findConstraintByAttribute:NSLayoutAttributeHeight];
}

-(void)setGoneVertical_lc:(BOOL)goneVertical_lc{
    if(goneVertical_lc){
        [self ensureConstraintByAttribute:NSLayoutAttributeHeight];
    }else{
        NSLayoutConstraint * cons = [self findConstraintByAttribute:NSLayoutAttributeHeight];
        if(cons)
            [self removeConstraint:cons];
    }
}

@end


@implementation UIView(Xib)
+ (UIView*) lc_loadXibIntoView:(UIView *)view owner:(UIView *) owner{
    NSString * xibName = NSStringFromClass(self);
    NSBundle * bundle = [NSBundle bundleForClass:self];
    
    UIView * contentView;
    
    @try{
        contentView = [bundle loadNibNamed:xibName owner:owner options:nil].firstObject;
    }@catch(NSException * e){
#if TARGET_INTERFACE_BUILDER
        @try{
            contentView = [bundle loadNibNamed:[xibName stringByAppendingString:@"~iphone"] owner:owner options:nil].firstObject;
        }@catch(NSException * e){
            contentView = [bundle loadNibNamed:[xibName stringByAppendingString:@"~ipad"] owner:owner options:nil].firstObject;
        }
#else
        @throw e;
#endif
        
    }
    //required if we manually add sub view with constraints
    contentView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [view addSubview:contentView];
    
    [view addConstraint:[NSLayoutConstraint constraintWithItem:contentView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeTop multiplier:1 constant:0]];
    [view addConstraint:[NSLayoutConstraint constraintWithItem:contentView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];
    [view addConstraint:[NSLayoutConstraint constraintWithItem:contentView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeRight multiplier:1 constant:0]];
    [view addConstraint:[NSLayoutConstraint constraintWithItem:contentView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeBottom multiplier:1 constant:0]];
    
    return contentView;
}

@end

//set custom class to __cls to preview in IB
@interface __UIView : UIView

@end

IB_DESIGNABLE
@implementation __UIView

@end

@interface __UILabel : UILabel

@end

IB_DESIGNABLE
@implementation __UILabel

@end

@interface __UIButton : UIButton

@end

IB_DESIGNABLE
@implementation __UIButton

@end

@interface __UIImageView : UIImageView

@end

IB_DESIGNABLE
@implementation __UIImageView

@end

@interface __UITextField : UITextField

@end

IB_DESIGNABLE
@implementation __UITextField

@end

@implementation UIView (Utils)

@end
