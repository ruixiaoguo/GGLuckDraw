//
//  LuckDrawSubView.h
//  GGLuckDraw
//  自定义抽奖模块
//  Created by GRX on 2022/10/18.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LuckDrawSubView : UIView
@property (nonatomic, weak) UILabel *label;
@property (nonatomic, weak) UIImageView *titleImageView;
+ (LuckDrawSubView *)initWithFrame:(CGRect)frame;
@end

NS_ASSUME_NONNULL_END
