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
#import "MKButton.h"

@interface ViewController ()


@property (strong, nonatomic) NSArray *sortedTitleArr;
@property (strong, nonatomic) NSMutableArray *titleArr;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    MKButton *button = [[MKButton alloc] initWithFrame:CGRectMake(20, 100, 211, 60)];
    button.style = MKButtonStyleTitleBottom;
    [button setImage:[UIImage imageNamed:@"favor"] forState:UIControlStateNormal];
    [button setTitle:@"bottom 咋没用" forState:UIControlStateNormal];
    [self.view addSubview:button];
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

//有序集合
-(void)mergeArray:(NSArray *)originArr {
    NSOrderedSet *set =  [NSOrderedSet orderedSetWithArray:originArr];
    NSLog(@"%@", set.array);
}

//开辟新的内存空间，然后判断是否存在，若不存在则添加到数组中，得到最终结果的顺序不发生变化。效率分析：时间复杂度为O ( n2 )：
-(void)mergefunction1:(NSArray *)originArr  {
    NSMutableArray *resultArray = [[NSMutableArray alloc] initWithCapacity:originArr.count];
    // 外层一个循环
    for (NSString *item in originArr) {
        // 调用-containsObject:本质也是要循环去判断，因此本质上是双层遍历
        // 时间复杂度为O ( n^2 )而不是O (n)
        if (![resultArray containsObject:item]) {
            [resultArray addObject:item];
        }
    }
    NSLog(@"resultArray: %@", resultArray);
}
//第二种方法：利用NSDictionary去重，字典在设置key-value时，若已存在则更新值，若不存在则插入值，然后获取allValues。若不要求有序，则可以采用此种方法。若要求有序，还得进行排序。效率分析：只需要一个循环就可以完成放入字典，若不要求有序，时间复杂度为O(n)。若要求排序，则效率与排序算法有关：
-(void)mergefunction2:(NSArray *)originArr {
//    originArr = [originArr valueForKeyPath:@"@distinctUnionOfObjects.self"];
//    NSLog(@"%@", originArr );
    
    NSMutableDictionary *resultDict = [[NSMutableDictionary alloc] initWithCapacity:originArr.count];
    for (NSString *item in originArr) {
        [resultDict setObject:item forKey:item];
    }
    NSArray *resultArray = resultDict.allValues;
    resultArray = [resultArray sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1,id  _Nonnull obj2) {
        NSString *item1 = obj1;
        NSString *item2 = obj2;
        return [item1 compare:item2 options:NSLiteralSearch];
    }];
    NSLog(@"%@", resultArray);
}

//第三种方法：利用集合NSSet的特性(确定性、无序性、互异性)，放入集合就自动去重了。但是它与字典拥有同样的无序性，所得结果顺序不再与原来一样。如果不要求有序，使用此方法与字典的效率应该是差不多的。效率分析：时间复杂度为O (n)：
-(void)mergefunction3:(NSArray *)originArr {
    NSSet *set = [NSSet setWithArray:originArr];
    NSArray *resultArray = [set allObjects];
    
    resultArray = [resultArray sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1,id  _Nonnull obj2) {
        NSString *item1 = obj1;
        NSString *item2 = obj2;
        return [item1 compare:item2 options:NSLiteralSearch];
    }];
    NSLog(@"%@", resultArray);
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
