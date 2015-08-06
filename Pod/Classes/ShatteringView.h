//
//  ShatteringView.h
//  shatterSample
//
//  Created by Stas on 03/08/15.
//  Copyright (c) 2015 Batururimi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShatteringView : UIView
/*!
 * @discussion The number of rows of peaces. By default it is equal to 9 and it cannot be less than 2.
 */
@property (nonatomic, assign) NSUInteger rows;

/*!
 * @discussion The number of cols of peaces. By default it is equal to 9 and it cannot be less than 2.
 */
@property (nonatomic, assign) NSUInteger cols;


/*!
 * @discussion The raidus of the circle till which pieces move. By default it is equal to maximum between the height
    and the width of the shattering view multiplied by radiusMultiplier
 and cannot be less than  maximum between the height
 and the width of the shattering view.
 */
@property (nonatomic, assign) CGFloat radius;



/*!
 * @discussion The multiplier by with the maximum between the height
   and the width of the shattering view is multiplied to get the radius.
   By default is equal to 0.8.
 */
@property (nonatomic, assign) CGFloat radiusMultiplier;



/*!
 * @discussion The animation duration of the splash effect. By default is equal to 3f;
 */
@property (nonatomic, assign) NSTimeInterval animationDuration;


/*!
 * @discussion Smash the view
 * @param hide If yes the splashView is hidden during the animation
 * @param completion The block of code called at the end of the animation
 */
- (void) smashIt:(BOOL)hide onCompletion:(void(^)(BOOL finished)) completion;
@end
