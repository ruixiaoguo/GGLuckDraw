//
//  LuckDrawView.h
//  GGLuckDraw
//
//  Created by GRX on 2022/10/18.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LuckDrawView : UIView
@property (nonatomic, assign) int stopPosition;/** 停止位置:数组下标*/
@property (nonatomic, assign) int turnsNumber;/** 旋转周数:默认3周 */
@property (nonatomic, assign) int decelerateNumber;/** 从第几个开始减速:默认6 */
@property (nonatomic, assign) CGFloat timeInterval;/** 切换时间间隔：默认0.15 */
@property (nonatomic, assign) BOOL isArcrandom;/** 是否随机抽奖动画：默认NO */
@property (copy, nonatomic) void(^luckResultBlock)(NSInteger result);
@end

NS_ASSUME_NONNULL_END
