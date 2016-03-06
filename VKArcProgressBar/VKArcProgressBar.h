//
//  VKArcProgressBar.h
//  VKArcProgressBar
//
//  Created by VikingWarlock on 3/5/16.
//  Copyright © 2016 VikingWarlock. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VKArcProgressBar : UIView

-(void)setdata:(CGFloat)data andAnimated:(BOOL)animate;

@property(nonatomic,assign)CGFloat animatedTime;

@property(nonatomic,assign)CGFloat minData;

@property(nonatomic,assign)CGFloat maxData;

@property(nonatomic,assign)NSArray *gradientColorList;

@property(nonatomic,assign)

@end
