//
//  VKArcProgressBar.m
//  VKArcProgressBar
//
//  Created by VikingWarlock on 3/5/16.
//  Copyright © 2016 VikingWarlock. All rights reserved.
//

#import "VKArcProgressBar.h"
#import <QuartzCore/QuartzCore.h>

#define StartRadius 9/40.f
#define StartlineWidth 8
#define rwidth (rect.size.width-StartlineWidth)
#define rheight (rect.size.height-StartlineWidth)


@interface VKArcProgressBar()
{
    UIBezierPath *path;
    CALayer *gradientLayer;
    CAShapeLayer *progressLayer;
    CGFloat ProgresslineWidth;
}
@end

@implementation VKArcProgressBar


- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupProgressLayer];
        self.minData=0;
        self.maxData=80;
    }
    return self;
}

-(void)setupProgressLayer
{
    ProgresslineWidth=12;
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
    [CATransaction begin];
    [CATransaction setDisableActions:!animate];
    [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
    [CATransaction setAnimationDuration:_animatedTime];
    progressLayer.strokeEnd=data/(_maxData-_minData);
    [CATransaction commit];
}

-(void)setupGradientLayer
{
    gradientLayer=[CALayer layer];
    
    CAGradientLayer *leftLayer=[CAGradientLayer layer];
    leftLayer.frame=CGRectMake(0, 0, self.frame.size.width/2.f, self.frame.size.height);
    [leftLayer setColors:@[(__bridge id)[UIColor blueColor].CGColor,(__bridge id)[UIColor greenColor].CGColor,(__bridge id)[UIColor yellowColor].CGColor]];
    [leftLayer setStartPoint:CGPointMake(0, 1)];
    [leftLayer setEndPoint:CGPointMake(1, 0)];
    [leftLayer setLocations:@[@0.2,@0.5,@0.8]];
    
    CAGradientLayer *rightLayer=[CAGradientLayer layer];
    rightLayer.frame=CGRectMake(self.frame.size.width/2.f, 0, self.frame.size.width/2.f, self.frame.size.height);
    [rightLayer setColors:@[(__bridge id)[UIColor redColor].CGColor,(__bridge id)[UIColor orangeColor].CGColor,(__bridge id)[UIColor yellowColor].CGColor]];
    [rightLayer setStartPoint:CGPointMake(1, 1)];
    [rightLayer setEndPoint:CGPointMake(0, 0)];
    [rightLayer setLocations:@[@0.2,@0.5,@0.8]];
    
    [gradientLayer addSublayer:leftLayer];
    [gradientLayer addSublayer:rightLayer];
    [gradientLayer setMask:progressLayer];
    
    [self.layer addSublayer:gradientLayer];
    
    CGPoint point=CGPointMake(self.frame.size.width/2.f-ProgresslineWidth/2.f, self.frame.size.height/2.f-ProgresslineWidth/2.f);
    path=[UIBezierPath bezierPathWithArcCenter:point radius:self.frame.size.width/2.f-50 startAngle:-M_PI*(StartRadius+1) endAngle:M_PI*(-StartRadius-1+(1+2*StartRadius)) clockwise:YES];
    progressLayer.path=path.CGPath;
    
}


-(void)drawRect:(CGRect)rect
{
    //    [super drawRect:rect];
    CGContextRef ctx=UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(ctx, 8);
    //    CGContextSetFillColorWithColor(ctx, [UIColor lightGrayColor].CGColor);
    
    
    CGContextSetStrokeColorWithColor(ctx, [UIColor whiteColor].CGColor);
    
    
    CGContextSetRGBStrokeColor(ctx, 1, 1, 1, 1);
    
    float fullRadius=(1+2*StartRadius);
    
    for(int i=0;i<151;i++)
    {
        if (i % 10 == 0 ) {
            CGContextDrawPath(ctx, kCGPathStroke);
            CGContextSetLineWidth(ctx, 2);
            
            CGContextMoveToPoint(ctx, rwidth/2.f*(1+1*cosf(M_PI*(-1-StartRadius+fullRadius*i/150.f))), rheight/2.f*(1+1*sinf(M_PI*(-1-StartRadius+fullRadius*i/150.f))));
            
            CGContextAddLineToPoint(ctx, rwidth/2.f*(1+0.85*cosf(M_PI*(-1-StartRadius+fullRadius*i/150.f))), rheight/2.f*(1+0.85*sinf(M_PI*(-1-StartRadius+fullRadius*i/150.f))));
            CGContextDrawPath(ctx, kCGPathStroke);
        }else
        {
            CGContextSetLineWidth(ctx, 1);
            
            CGContextMoveToPoint(ctx, rwidth/2.f*(1+0.95*cosf(M_PI*(-1-StartRadius+fullRadius*i/150.f))), rheight/2.f*(1+0.95*sinf(M_PI*(-1-StartRadius+fullRadius*i/150.f))));
            
            CGContextAddLineToPoint(ctx, rwidth/2.f*(1+0.9*cosf(M_PI*(-1-StartRadius+fullRadius*i/150.f))), rheight/2.f*(1+0.9*sinf(M_PI*(-1-StartRadius+fullRadius*i/150.f))));
            
        }
    }
    CGContextDrawPath(ctx, kCGPathStroke);
    
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
