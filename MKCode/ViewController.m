//
//  ViewController.m
//  MKCode
//
//  Created by shendan on 2017/3/16.
//  Copyright © 2017年 Mark. All rights reserved.
//

#import "ViewController.h"
#import "MKCode.h"
#import "HXSearchBar.h"
#import "SignInViewController.h"
#import "RealReachability.h"
#import "QMUIButton.h"

@interface ViewController ()


@property (strong, nonatomic) NSArray *sortedTitleArr;
@property (strong, nonatomic) NSMutableArray *titleArr;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    NSArray *array = @[@"1052路",
                            @"81路",@"85路",@"313路",@"455路",@"610路",@"794路",@"799路",@"971路",@"981路",@"1052路",@"浦东15路",@"浦东4路",
                            @"610路",@"799路"
                            ];
    
}

-(void)networkstatus {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(networkChanged:)
                                                 name:kRealReachabilityChangedNotification
                                               object:nil];
    
    ReachabilityStatus status = [GLobalRealReachability currentReachabilityStatus];
    NSLog(@"Initial reachability status:%@",@(status));
    
    if (status == RealStatusNotReachable){
        NSLog(@"Network unreachable!");
    }
    
    if (status == RealStatusViaWiFi){
        NSLog(@"Network wifi! Free!");
    }
    
    if (status == RealStatusViaWWAN){
        NSLog( @"Network WWAN! In charge!");
    }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)networkChanged:(NSNotification *)notification {
    RealReachability *reachability = (RealReachability *)notification.object;
    ReachabilityStatus status = [reachability currentReachabilityStatus];
    ReachabilityStatus previousStatus = [reachability previousReachabilityStatus];
    NSLog(@"networkChanged, currentStatus:%@, previousStatus:%@", @(status), @(previousStatus));
    
    if (status == RealStatusNotReachable){
        NSLog( @"Network unreachable!");
    }
    
    if (status == RealStatusViaWiFi){
        NSLog( @"Network wifi! Free!");
    }
    
    if (status == RealStatusViaWWAN){
        NSLog(@"Network WWAN! In charge!");
    }
    
    WWANAccessType accessType = [GLobalRealReachability currentWWANtype];
    
    if (status == RealStatusViaWWAN){
        if (accessType == WWANType2G){
            NSLog( @"RealReachabilityStatus2G");
        }
        else if (accessType == WWANType3G){
            NSLog( @"RealReachabilityStatus3G");
        }
        else if (accessType == WWANType4G){
            NSLog( @"RealReachabilityStatus4G");
        }
        else{
            NSLog( @"Unknown RealReachability WWAN Status, might be iOS6");
        }
    }
}


-(void)pushbutton{
    UIButton *signin = [[UIButton alloc] initWithFrame:CGRectMake(20, 100, 60, 30)];
    signin.backgroundColor = [UIColor redColor];
    [signin setTitle:@"signin" forState:UIControlStateNormal];
    [signin addTarget:self action:@selector(signinclick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:signin];
}


-(void)signinclick:(UIButton *)btn {
    SignInViewController *vc = [SignInViewController new];
    [self presentViewController:vc animated:NO completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
