//
//  LuckDrawView.m
//  GGLuckDraw
//
//  Created by GRX on 2022/10/18.
//

#import "LuckDrawView.h"
#import "LuckDrawSubView.h"
#define HScreen [[UIScreen mainScreen] bounds].size.height
#define WScreen [[UIScreen mainScreen] bounds].size.width
@interface LuckDrawView () {
    NSTimer *_startTimer;
    int _currentTime;
    NSInteger _stopTime;/** 停止位置 */
    int _finalPosition;/** 最终位置 */
    int _currentIndex;/** 当前位置 */
}
@property (nonatomic, strong) NSMutableArray *allSubArray;
@property (nonatomic, strong) UIButton *startButton;
@property (nonatomic, assign) CGFloat time;
@property (nonatomic, assign) BOOL isJumpStart;/** 是否跳过抽奖动画 */

@end
@implementation LuckDrawView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self creatUI];
    }
    return self;
}

- (void)creatUI{
    self.turnsNumber = 3;      /** 默认：3 */
    self.decelerateNumber = 6; /** 默认：6 */
    self.timeInterval = 0.15;  /** 默认：0.15 */
    self.isArcrandom = NO;
    self.isJumpStart = NO;
    self.allSubArray = [NSMutableArray arrayWithCapacity:0];
    /** 九宫格抽奖 */
    NSArray *titleArray = @[@"10",@"30",@"50",@"60",@"80",@"100",@"150",@"250",@"500"];
    for (int i=0; i<3; i++) {
        for (int j=0; j<3; j++) {
            LuckDrawSubView *subView = [LuckDrawSubView initWithFrame:CGRectMake(j*100+60, i*100+120, 100, 100)];
            subView.label.text = [NSString stringWithFormat:@"%@",titleArray[j+i*3]];
            [self addSubview:subView];
            [self.allSubArray addObject:subView];
        }
    }
    /** 开始抽奖按钮 */
    self.startButton = [[UIButton alloc]initWithFrame:CGRectMake(150, 500, 100, 50)];
    [self addSubview:self.startButton];
    [self.startButton addTarget:self action:@selector(startButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.startButton setTitle:@"开始抽奖" forState:UIControlStateNormal];
    [self.startButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.startButton setBackgroundColor:[UIColor purpleColor]];
    self.startButton.layer.borderWidth = 1;
    self.startButton.layer.cornerRadius = 5;
    /** 默认抽奖起始位置:0 */
    [self changeLotteryCellNumber:0];
}

- (void)startButtonClick {
    if (self.isJumpStart == NO) {
        self.time = self.timeInterval;
        _currentTime = _finalPosition;
        _stopTime = self.turnsNumber*self.allSubArray.count + self.stopPosition;
        [self.startButton setTitle:@"跳过等待" forState:UIControlStateNormal];
        _startTimer = [NSTimer scheduledTimerWithTimeInterval:self.time target:self selector:@selector(start:) userInfo:nil repeats:YES];
    }else{
        [_startTimer invalidate];
        [self.startButton setTitle:@"开始抽奖" forState:UIControlStateNormal];
        [self changeLotteryCellNumber:self.stopPosition];
        [self gaintStopResult];
    }
    self.isJumpStart = !self.isJumpStart;
}

- (void)start:(NSTimer *)timer {
    if(self.isArcrandom){
        [self changeLotteryCellNumber:arc4random() % self.allSubArray.count];
    }else{
        [self changeLotteryCellNumber:_currentTime];
    }
    /** 每次执行递增当前时间 */
    _currentTime++;
    if (_currentTime > _stopTime) {
        self.isJumpStart = NO;
        [timer invalidate];
        [self.startButton setTitle:@"开始抽奖" forState:UIControlStateNormal];
        NSLog(@"%d", self.stopPosition);
        /** 抽奖结束最终停落位置 */
        [self changeLotteryCellNumber:self.stopPosition];
        /** 中奖结果回调 */
        [self gaintStopResult];
        return;
    }
    
    /** 控制轮转时间倒数第几个开始减速 */
    if (_currentTime > _stopTime - self.decelerateNumber) {
        // 结束时间递增
        self.time += self.timeInterval;
        [timer invalidate];
        _startTimer = [NSTimer scheduledTimerWithTimeInterval:self.time target:self selector:@selector(start:) userInfo:nil repeats:YES];
    }
}

/** 抽奖闪烁效果 */
- (void)changeLotteryCellNumber:(int)number {
    LuckDrawSubView *oldSubView = [self.allSubArray objectAtIndex:_currentIndex];
    oldSubView.titleImageView.image = [UIImage imageNamed:@"luckunSel"];
    if (number >= self.allSubArray.count) {
        _currentIndex = number % self.allSubArray.count;
    }else{
        _currentIndex = number;
    }
    LuckDrawSubView *currentSubView = [self.allSubArray objectAtIndex:_currentIndex];
    currentSubView.titleImageView.image = [UIImage imageNamed:@"luckSel"];
    /** 停留最终位置 */
    _finalPosition = _currentIndex;
}

- (void)gaintStopResult {
    if (self.luckResultBlock != nil) {
        self.luckResultBlock(_finalPosition);
    }
}

- (void)dealloc {
    [_startTimer invalidate];
}




@end
