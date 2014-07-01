//
//  ZGXWaveView.h
//  ZGXWaveView
//
//  Created by the9 on 14-6-30.
//  Copyright (c) 2014年 the9. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, WaveViewType) {
    WaveViewTypeCustom = 0,
    WaveViewTypeLoad = 1,
    WaveViewTypeRefresh = 2
};

@interface ZGXWaveView : UIView

- (instancetype)initWithFrame:(CGRect)frame
                WithWaveHeight:(float)waveHeight
                WithWaterHeight:(float)waterHeight
                WithWaveSpeed:(float)waveSpeed
                WithWaterColor:(UIColor *)waterColor;

- (instancetype)initWithFrame:(CGRect)frame WithType:(WaveViewType)WaveViewType;

- (void)startAnimation;
- (void)stopAnimation;

@end
