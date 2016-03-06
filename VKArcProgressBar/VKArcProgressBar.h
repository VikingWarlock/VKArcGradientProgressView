//
//  VKArcProgressBar.h
//  VKArcProgressBar
//
//  Created by VikingWarlock on 3/5/16.
//  Copyright © 2016 VikingWarlock. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VKArcProgressBar : UIView

/**
 *set the current time
 */
-(void)setdata:(CGFloat)data andAnimated:(BOOL)animate;

/**
 *set the animated time
 */
@property(nonatomic,assign)CGFloat animatedTime;

/**
 *set the minimum
 */
@property(nonatomic,assign)CGFloat minData;

/**
 *set the maximum
 */
@property(nonatomic,assign)CGFloat maxData;

/**
 *Gradient color list
 */
@property(nonatomic,copy)NSArray *gradientColorList;

/**
 *ProgressBar start angle
 */
@property(nonatomic,assign)CGFloat startAngle;

/**
 *ProgressBar end angle
 */
@property(nonatomic,assign)CGFloat endAngle;

/**
 *ProgressBar width
 */
@property(nonatomic,assign)CGFloat width;

/**
 *Gradient Locations
 *@see the locations property of CAGradientLayer
 */
@property(nonatomic,copy)NSArray<NSNumber *> *customLocations;

@end
