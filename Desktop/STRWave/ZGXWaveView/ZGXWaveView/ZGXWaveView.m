//
//  ZGXWaveView.m
//  ZGXWaveView
//
//  Created by the9 on 14-6-30.
//  Copyright (c) 2014年 the9. All rights reserved.
//

#import "ZGXWaveView.h"
#import "UIColor+CustomColors.h"

@interface ZGXWaveView ()
@property (assign, nonatomic) float waveHeight;
@property (assign, nonatomic) float waterHeight;
@property (assign, nonatomic) float waveSpeed;
@property (assign, nonatomic) float realWaveSpeed;
@property (strong, nonatomic) UIColor *_waterColor;
@property (assign, nonatomic) BOOL isLoaded;
@property (strong, nonatomic) NSTimer *timer;

@property (assign, nonatomic) WaveViewType waveViewType;
@end

@implementation ZGXWaveView

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.realWaveSpeed = 0;
        self.waveViewType = WaveViewTypeCustom;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame WithWaveHeight:(float)waveHeight WithWaterHeight:(float)waterHeight WithWaveSpeed:(float)waveSpeed WithWaterColor:(UIColor *)waterColor{
    self = [self initWithFrame:frame];
    
    self._waterColor = waterColor;
    self.waveSpeed = waveSpeed;
    self.waterHeight = frame.size.height - waterHeight;
    self.waveHeight = waveHeight;
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame WithType:(WaveViewType)WaveViewType{
    self = [self initWithFrame:frame];
    switch (WaveViewType) {
        case WaveViewTypeCustom:
            self.waveViewType = WaveViewTypeCustom;
            self._waterColor = [UIColor customYellowColor];
            self.waveSpeed = 0.1;
            self.waterHeight = frame.size.height / 3.0 * 2.0;
            self.waveHeight = 8;
            break;
        case WaveViewTypeLoad:
            self.waveViewType = WaveViewTypeLoad;
            self._waterColor = [UIColor customBlueColor];
            self.waveSpeed = 0.1;
            self.waterHeight = frame.size.height;
            self.waveHeight = 8;
            self.isLoaded = NO;
            break;
        case WaveViewTypeRefresh:
            self.waveViewType = WaveViewTypeRefresh;
            break;
        default:
            break;
    }
    
    return self;
}

- (void)startAnimation{
    if (self.timer == nil) {
        switch (self.waveViewType) {
            case WaveViewTypeCustom:
                self.timer = [NSTimer scheduledTimerWithTimeInterval:0.02 target:self selector:@selector(waveAnimation) userInfo:nil repeats:YES];
                break;
            case WaveViewTypeLoad:
                self.waterHeight = self.bounds.size.height;
                self.isLoaded = NO;
                self.alpha = 1;
                self.timer = [NSTimer scheduledTimerWithTimeInterval:0.02 target:self selector:@selector(waveLoadAnimation) userInfo:nil repeats:YES];
                break;
            case WaveViewTypeRefresh:
                
            default:
                break;
        }
    }
}

- (void)stopAnimation{
    switch (self.waveViewType) {
        case WaveViewTypeCustom:
            [self stopBaseAnimation];
            break;
        case WaveViewTypeLoad:
            [self stopWaveLoadAnimation];
            break;
        default:
            break;
    }
}

- (void)stopBaseAnimation{
    if ([self.timer isValid]) {
        [self.timer invalidate];
        self.timer = nil;
    }
}

- (void)waveAnimation{
    self.realWaveSpeed += self.waveSpeed;
    [self setNeedsDisplay];
}

- (void)waveLoadAnimation{
    if (self.isLoaded) {
        self.waterHeight -= self.waterHeight / 5.0;
        self.realWaveSpeed += self.waveSpeed;
    }
    else if(self.waterHeight > 0){
        self.waterHeight -= self.waterHeight / 100.0;
    }
    self.realWaveSpeed += self.waveSpeed;
    [self setNeedsDisplay];
}

- (void)stopWaveLoadAnimation{
    if (self.waveViewType == WaveViewTypeLoad) {
        self.isLoaded = YES;
        [UIView animateWithDuration:0.8 delay:0.5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.alpha = 0;
        } completion:^(BOOL finished) {
            [self stopBaseAnimation];
        }];
    }
}

- (void)drawRect:(CGRect)rect{
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGMutablePathRef path = CGPathCreateMutable();
    
    CGContextSetLineWidth(context, 1);
    CGContextSetFillColorWithColor(context, self._waterColor.CGColor);
    
    float height = self.waterHeight;
    CGPathMoveToPoint(path, NULL, 0, height);
    for (int i = 0; i <= rect.size.width ; ++i) {
        height = sin((float)i / 180 * M_PI + 4 * self.realWaveSpeed / M_PI) * self.waveHeight + self.waterHeight;
        CGPathAddLineToPoint(path, nil, i, height);
    }
    
    CGPathAddLineToPoint(path, nil, rect.size.width, rect.size.height);
    CGPathAddLineToPoint(path, nil, 0, rect.size.height);
    CGPathAddLineToPoint(path, nil, 0, self.waveHeight);
    
    CGContextAddPath(context, path);
    CGContextDrawPath(context, kCGPathFill);
    CGPathRelease(path);
}


@end
