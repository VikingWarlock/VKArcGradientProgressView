//
//  ViewController.m
//  VKArcProgressBar
//
//  Created by VikingWarlock on 3/5/16.
//  Copyright © 2016 VikingWarlock. All rights reserved.
//

#import "ViewController.h"
#import "VKArcProgressBar.h"

@interface ViewController ()
{
    VKArcProgressBar *progress;

    NSInteger currentData;
    NSTimer *timer;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    progress=[[VKArcProgressBar alloc]init];
    currentData=5;
    [self.view addSubview:progress];
    timer = [NSTimer scheduledTimerWithTimeInterval:1.f target:self selector:@selector(handleTimer) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop]addTimer:timer forMode:NSRunLoopCommonModes];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    progress.frame=CGRectMake(20, 40, self.view.frame.size.width-40.f, self.view.frame.size.width-40.f);
    [progress setdata:currentData andAnimated:YES];
}

-(void)handleTimer
{
    int offset= arc4random() % 20 -10;
    currentData+=offset;
    if (currentData>80) {
        currentData=80;
    }
    if (currentData<0) {
        currentData=0;
    }
    [progress setdata:currentData andAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
