//
//  MKButton.h
//  MKCode
//
//  Created by shendan on 2017/4/1.
//  Copyright © 2017年 Mark. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, MKButtonStyle){
    MKButtonStyleTitleDown = 0,
    MKButtonStyleTitleRight,                     
    MKButtonStyleTitleLeft
};

@interface MKButton : UIButton

@property (assign, nonatomic) CGFloat width;
@property (assign, nonatomic) CGFloat height;

@property (assign, nonatomic) MKButtonStyle buttonStyle;

-(id)initWithFrame:(CGRect)frame buttonStyle:(MKButtonStyle)style;

@end
