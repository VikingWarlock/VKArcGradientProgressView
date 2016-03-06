##VKArcGradientProgressView
#####Easy to create a gradient circle progress view
---
##ScreenShot
![screenshot](https://raw.githubusercontent.com/VikingWarlock/VKArcGradientProgressView/master/demoGIF.gif)

##Usage
####1.import the VKArcProgressBar.h
	#import "VKArcProgressBar.h"

####2.create a object
	VKArcProgressBar *progress=[VKArcProgressBar alloc]init];

####3.customize

---

#####Set the colors
	@property(nonatomic,copy)NSArray<UIColor*> *gradientColorList;

If your don't set this ,you will get the default colors pattern

	progress.gradientColorList=@[[UIColor redColor],[UIColor yellowColor],[[UIColor greenColor]];

---
#####Set the width
	@property(nonatomic,assign)CGFloat width;
Default is 8

---

#####Set the maximum and minimum value of this progress
	@property(nonatomic,assign)CGFloat minData;
	@property(nonatomic,assign)CGFloat maxData;
Default is 0 and 80

---

#####Set the data
	-(void)setdata:(CGFloat)data andAnimated:(BOOL)animate;

The parameter data should `less` than the maximum value and `greater` than the minimum value,otherwise you may not get what you want.

---

#####Set the animate time
	@property(nonatomic,assign)CGFloat animatedTime;
if `animatedTime <= 0`, it `won't move` smoothly!

---

#####Set the angle
	@property(nonatomic,assign)CGFloat startAngle;
	@property(nonatomic,assign)CGFloat endAngle;

---

#####Set the location of each gradient stop
	@property(nonatomic,copy)NSArray<NSNumber *> *customLocations;
value in the range `[0,1]`,Default may not look good.The demo use 0.2,0.5,0.8

##Install
I am working on Cocoapods...

##Contact
Contact me by an email if you have any question or advice😊.

[Email](mailto://vikingwarlock@163.com)

##License

Copyright (C) 2016 Viking Warlock

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.