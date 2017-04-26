//
//  MKCountDownButton.m
//  QuickLookDataDemo
//
//  Created by shendan on 2017/4/12.
//  Copyright © 2017年 shendan. All rights reserved.
//

#import "MKCountDownButton.h"

@interface MKCountDownButton ()



@end


@implementation MKCountDownButton

-(id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self setTitle:@"获取验证码" forState:UIControlStateNormal];
        [self setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:12];
        self.layer.borderWidth = 1;
        self.layer.borderColor = [UIColor yellowColor].CGColor;
        self.backgroundColor = [UIColor yellowColor];
        self.layer.cornerRadius = (self.frame.size.height)/2;
        [self addTarget:self action:@selector(cutDownTime) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

-(void)cutDownTime {
    
    __block int timeout = 59; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer (_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler (_timer, ^{
        if(timeout <= 0){
            //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(),   ^{
                //设置界面的按钮显示 根据自己需求设置
                [self setupButtonEnable];
            });
        }else{
            int seconds = timeout % 60;
            NSString *timeStr = [NSString stringWithFormat:@"%d", seconds];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationDuration:1];
                [UIView commitAnimations];
                
                [self setupButtonUnenable:timeStr];
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
}

-(void)setupButtonEnable {
    self.enabled = YES;
    [self setTitle:@"重新获取" forState:UIControlStateNormal];
    self.titleLabel.font = [UIFont systemFontOfSize:12];
    self.backgroundColor = [UIColor yellowColor];
}

-(void)setupButtonUnenable:(NSString *)strTime {
    [self setTitle:[NSString stringWithFormat:@"(%@)重新获取",strTime] forState:UIControlStateNormal];
    self.titleLabel.font = [UIFont systemFontOfSize:12];
    
    self.enabled = NO;
    self.backgroundColor = [UIColor grayColor];
}

-(void)makeButtonClickable:(BOOL)phoneNumber {
    if (phoneNumber) {
        self.enabled = YES;
    }else {
        self.enabled = NO;
    }
}

@end
