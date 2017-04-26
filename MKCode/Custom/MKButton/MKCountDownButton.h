//
//  MKCountDownButton.h
//  QuickLookDataDemo
//
//  Created by shendan on 2017/4/12.
//  Copyright © 2017年 shendan. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MKCountDownButtonDelegate <NSObject>


@end

@interface MKCountDownButton : UIButton

@property (weak, nonatomic) id <MKCountDownButtonDelegate> delegate;


-(void)makeButtonClickable:(BOOL)phoneNumber;

@end
