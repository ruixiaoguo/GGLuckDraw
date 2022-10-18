//
//  LuckDrawSubView.m
//  GGLuckDraw
//
//  Created by GRX on 2022/10/18.
//

#import "LuckDrawSubView.h"

@implementation LuckDrawSubView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        CGFloat width = frame.size.width;
        CGFloat height = frame.size.height;
        /** 背景图 */
        UIImageView *bgImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, width, height)];
        bgImgView.image = [UIImage imageNamed:@"luckunSel"];
        [self addSubview:bgImgView];
        self.titleImageView = bgImgView;
       /** 标题 */
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, width-20, height-20)];
        label.textColor = [UIColor blackColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont boldSystemFontOfSize:20];
        [self addSubview:label];
        self.label = label;
    }
    return self;
}

+ (LuckDrawSubView *)initWithFrame:(CGRect)frame {
    return [[LuckDrawSubView alloc] initWithFrame:frame];
}

@end
