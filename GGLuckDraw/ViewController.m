//
//  ViewController.m
//  GGLuckDraw
//
//  Created by GRX on 2022/10/18.
//

#import "ViewController.h"
#import "LuckDrawView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    LuckDrawView *luckView = [[LuckDrawView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:luckView];
    //指定抽奖结果,对应数组中的下标
    luckView.stopPosition = 3;
    luckView.luckResultBlock = ^(NSInteger result) {
        NSLog(@"block====>抽到了第%ld个",result);
    };
}


@end
