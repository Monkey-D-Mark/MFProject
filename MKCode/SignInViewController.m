//
//  SignInViewController.m
//  MKCode
//
//  Created by shendan on 2017/3/21.
//  Copyright © 2017年 Mark. All rights reserved.
//
#define STATUS_HEIGHT 20
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
#import "SignInViewController.h"
#import "Masonry.h"

@interface SignInViewController ()

@property (strong, nonatomic) UIButton *closeButton;
@property (strong, nonatomic) UITextField *phone;
@property (strong, nonatomic) UITextField *password;

@end

@implementation SignInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGBACOLOR(238, 238, 238, 1);
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        [self setEdgesForExtendedLayout:UIRectEdgeNone];
    }
    [self setupSubView];
}



-(void)setupSubView {
    _closeButton = [[UIButton alloc] init];

    [_closeButton setTitle:@"X"forState:UIControlStateNormal];
    [_closeButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
//    [_closeButton setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [self.view addSubview:_closeButton];
    [_closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(44, 44));
        make.leading.equalTo(self.view.mas_leading);
        make.top.equalTo(self.view.mas_top).offset(STATUS_HEIGHT);
    }];
    
    UILabel *title = [[UILabel alloc] init];
    title.text = @"手机号快捷登陆";
    title.font = [UIFont systemFontOfSize:17];
    [self.view addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.centerY.equalTo(_closeButton.mas_centerY);
    }];
    
    UIView *line1 = [[UIView alloc] init];
    line1.backgroundColor = [UIColor grayColor];
    [self.view addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@1);
        make.top.equalTo(self.view.mas_top).offset(64);
        make.leading.equalTo(self.view.mas_leading);
        make.width.equalTo(self.view.mas_width);
    }];
    
    UIView *samllView = [[UIView alloc] init];
    samllView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:samllView];
    [samllView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line1.mas_bottom).offset(STATUS_HEIGHT);
        make.leading.equalTo(self.view.mas_leading);
        make.trailing.equalTo(self.view.mas_trailing);
        make.height.equalTo(@80);
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
