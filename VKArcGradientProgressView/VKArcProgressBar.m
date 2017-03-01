//
//  VKArcProgressBar.m
//  VKArcProgressBar
//
//  Created by VikingWarlock on 3/5/16.
//  Copyright © 2016 VikingWarlock. All rights reserved.
//

#import "VKArcProgressBar.h"
#import <QuartzCore/QuartzCore.h>

//#define StartRadius 9/40.f
//#define StartlineWidth 8
//#define rwidth (rect.size.width-StartlineWidth)
//#define rheight (rect.size.height-StartlineWidth)


@interface VKArcProgressBar()
{
    
    UIBezierPath *path;
    
    CALayer *gradientLayer;
    
    CAShapeLayer *progressLayer;
    
    CGFloat ProgresslineWidth;
    
    BOOL enableAnimate;
    
    CGFloat min;
    CGFloat max;
    CGFloat startA;
    CGFloat endA;
    CGFloat time;
    
}
@end

@implementation VKArcProgressBar


- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initialized];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        [self initialized];
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self=[super initWithCoder: aDecoder];
    if (self) {
        [self initialized];
    }
    return self;
}

-(void)initialized
{
    [self setupProgressLayer];
    min=0;
    max=80;
    startA=-220;
    endA=40;
    time=1.f;
    enableAnimate=YES;
    ProgresslineWidth=8;
}

-(void)setWidth:(CGFloat)width
{
    ProgresslineWidth=width;
    progressLayer.lineWidth=width;
}

-(void)setMaxData:(CGFloat)maxData
{
    max=maxData;
    [self resetPath];
}

-(void)setMinData:(CGFloat)minData
{
    min=minData;
    [self resetPath];
}

-(void)setStartAngle:(CGFloat)startAngle
{
    startA=startAngle;
    [self resetPath];
}

-(void)setEndAngle:(CGFloat)endAngle
{
    endA=endAngle;
    [self resetPath];
}

-(void)setAnimatedTime:(CGFloat)animatedTime
{
    time=animatedTime;
    if (animatedTime<=0) {
        enableAnimate=NO;
    }else
    {
        enableAnimate=YES;
    }
}

-(void)setGradientColorList:(NSArray *)gradientColorList
{
    _gradientColorList = gradientColorList;
    [self resetColor];
}

-(void)setupProgressLayer
{
    progressLayer=[CAShapeLayer layer];
    progressLayer.lineCap=kCALineCapRound;
    progressLayer.fillColor=[UIColor clearColor].CGColor;
    progressLayer.strokeColor=[UIColor blackColor].CGColor;
    progressLayer.lineWidth=ProgresslineWidth;
    progressLayer.strokeEnd=1;
    progressLayer.strokeStart=0;
}

-(void)setFrame:(CGRect)frame
{
    [super setFrame: frame];
    progressLayer.frame=CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    [self setupGradientLayer];
}

-(void)setdata:(CGFloat)data andAnimated:(BOOL)animate
{
    if (data>max || data <min) {
        return;
    }
    [CATransaction begin];
    [CATransaction setDisableActions:!(animate&&enableAnimate)];
    [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
    [CATransaction setAnimationDuration:time];
    progressLayer.strokeEnd=data/(max-min);
    [CATransaction commit];
}

-(void)setupGradientLayer
{
    [gradientLayer removeFromSuperlayer];
    gradientLayer=[CALayer layer];
    [self.layer addSublayer:gradientLayer];
    [self resetPath];
    [self resetColor];
}

-(void)resetPath
{
    CGPoint point=CGPointMake(self.frame.size.width/2.f, self.frame.size.height/2.f);
    
    path=[UIBezierPath bezierPathWithArcCenter:point radius:self.frame.size.width/2.f-ProgresslineWidth/2.f startAngle:M_PI*(startA/180.f) endAngle:M_PI*(endA/180.f) clockwise:YES];
    
    progressLayer.path=path.CGPath;
    
}

-(void)resetColor{
    
    [gradientLayer.sublayers makeObjectsPerformSelector:@selector(removeFromSuperlayer
                                                                  )];/*
                                                                      for(CALayer *layer in gradientLayer.sublayers)
                                                                      {
                                                                      [layer removeFromSuperlayer];
                                                                      }*/
    
    CAGradientLayer *leftLayer=[CAGradientLayer layer];
    leftLayer.frame=CGRectMake(0, 0, self.frame.size.width/2.f, self.frame.size.height);
    
    NSArray *rightColorList;
    NSArray *leftColorList;
    
    if (_gradientColorList) {
        NSInteger countOfColor=_gradientColorList.count;
        if (countOfColor>0) {
            NSMutableArray *rightTempArray=[NSMutableArray array];
            NSMutableArray *leftTempArray=[NSMutableArray array];
            
            for(NSInteger number=0;number<countOfColor/2;number++)
            {
                UIColor *color=_gradientColorList[number];
                [leftTempArray addObject:(__bridge id)color.CGColor];
            }
            
            if (countOfColor % 2 !=0) {
                UIColor *color=_gradientColorList[countOfColor/2];
                [leftTempArray addObject:(__bridge id)color.CGColor];
            }
            
            for(NSInteger number=countOfColor;number>countOfColor/2;number--)
            {
                UIColor *color=_gradientColorList[number-1];
                [rightTempArray addObject:(__bridge id)color.CGColor];
            }
            rightColorList=[NSArray arrayWithArray:rightTempArray];
            leftColorList=[NSArray arrayWithArray:leftTempArray];
        }
    }
    
    
    if (!leftColorList) {
        leftColorList=@[(__bridge id)[UIColor blueColor].CGColor,(__bridge id)[UIColor greenColor].CGColor,(__bridge id)[UIColor yellowColor].CGColor];
    }
    
    if (!rightColorList) {
        rightColorList=@[(__bridge id)[UIColor redColor].CGColor,(__bridge id)[UIColor orangeColor].CGColor,(__bridge id)[UIColor yellowColor].CGColor];
    }
    
    
    [leftLayer setColors:leftColorList];
    [leftLayer setStartPoint:CGPointMake(0, 1)];
    [leftLayer setEndPoint:CGPointMake(1, 0)];
    
    NSArray *locations=[_customLocations copy];
    if (!locations) {
        NSMutableArray *temp=[NSMutableArray array];
        for (NSInteger count=leftColorList.count+1; count>1; count--) {
            [temp addObject:@(1.f/count)];
        }
        locations=[NSArray arrayWithArray:temp];
    }
    
    [leftLayer setLocations:locations];
    CAGradientLayer *rightLayer=[CAGradientLayer layer];
    rightLayer.frame=CGRectMake(self.frame.size.width/2.f, 0, self.frame.size.width/2.f, self.frame.size.height);
    [rightLayer setColors:rightColorList];
    [rightLayer setStartPoint:CGPointMake(1, 1)];
    [rightLayer setEndPoint:CGPointMake(0, 0)];
    
    [rightLayer setLocations:locations];
    
    [gradientLayer addSublayer:leftLayer];
    [gradientLayer addSublayer:rightLayer];
    [gradientLayer setMask:progressLayer];
    
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
