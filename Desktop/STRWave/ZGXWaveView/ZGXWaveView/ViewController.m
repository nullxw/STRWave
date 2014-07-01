//
//  ViewController.m
//  ZGXWaveView
//
//  Created by the9 on 14-6-30.
//  Copyright (c) 2014年 the9. All rights reserved.
//

#import "ViewController.h"
#import "ZGXWaveView.h"
#import "UIColor+CustomColors.h"

@interface ViewController ()
@property (strong, nonatomic) ZGXWaveView *waveView;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.waveView = [[ZGXWaveView alloc] initWithFrame:CGRectMake(0, 0, 320, 480) WithType:WaveViewTypeCustom];
	[self.view addSubview:self.waveView];
    
    UIButton *startButton = [[UIButton alloc] initWithFrame:CGRectMake(60, 106, 60, 30)];
    [startButton addTarget:self action:@selector(start) forControlEvents:UIControlEventTouchUpInside];
    startButton.backgroundColor = [UIColor customBlueColor];
    [startButton setTitle:@"start" forState:UIControlStateNormal];
    [self.view addSubview:startButton];
    
    UIButton *stopButton = [[UIButton alloc] initWithFrame:CGRectMake(200, 106, 60, 30)];
    [stopButton addTarget:self action:@selector(stop) forControlEvents:UIControlEventTouchUpInside];
    stopButton.backgroundColor = [UIColor customBlueColor];
    [stopButton setTitle:@"stop" forState:UIControlStateNormal];
    stopButton.titleLabel.text = @"stop";
    [self.view addSubview:stopButton];
    
}

- (void)start {
    [self.waveView startAnimation];
}

- (void)stop{
    [self.waveView stopAnimation];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
