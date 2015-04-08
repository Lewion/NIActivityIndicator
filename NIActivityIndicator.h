//
//  NIActivityIndicator.h
//
//  Created by Nikki Vergracht on 07/04/15.
//  Copyright (c) 2015 Lewion.ninja All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NIActivityIndicator : UIView

// Duration of 1 round of the animation.
@property (nonatomic) NSTimeInterval duration;
// The activity indicator color.
@property (nonatomic, strong) UIColor *strokeColor;
// The mask color (set this to match your background color).
@property (nonatomic, strong) UIColor *maskColor;
// The width of the activity indicator.
@property (nonatomic) CGFloat strokeWidth;
// Boolean to set the initially shown full circle to NO. (Defaults to YES).
@property (nonatomic) BOOL initiallyShowFullStroke;
// Start the animation
- (void) startAnimation;
// End the animation
- (void) finishAnimation;

@end