//
//  ShatteringView.m
//  shatterSample
//
//  Created by Stas on 03/08/15.
//  Copyright (c) 2015 Batururimi. All rights reserved.
//

#import "ShatteringView.h"

const NSUInteger defaultCols = 9;
const NSUInteger defaultRows = 9;
const CGFloat defaultAnimationDuration = 3.f;
const CGFloat defaultRadiusMultiplier = 0.8f;

@implementation ShatteringView

#pragma mark - PRIVATE -
- (id) init{
    self = [super init];
    if (self){
        [self _setupDefaultValues];
    }
    return self;
}

- (id) initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self _setupDefaultValues];
    }
    return self;
}

- (id) initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self _setupDefaultValues];
    }
    return self;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (void) smashIt:(BOOL)hide onCompletion:(void(^)(BOOL finished)) completion{
    

    UIGraphicsBeginImageContext(self.frame.size);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *carNumViewWholeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    
    const NSUInteger portionWidth  = carNumViewWholeImage.size.width / self.cols;
    const NSUInteger portionHeight = carNumViewWholeImage.size.height / self.rows;
    
    const NSUInteger portionsNums = self.cols * self.rows;
    NSMutableArray *portionsArray = [NSMutableArray arrayWithCapacity:portionsNums];
    NSMutableArray *coordinatesArray = [NSMutableArray arrayWithCapacity:portionsNums];
    
    CGPoint circleCenter = self.center;
    
    for(NSUInteger col = 0; col < self.cols; ++col){
        for (NSUInteger row = 0; row < self.rows; ++row) {
            CGRect portionImageFrame = CGRectMake(col * portionWidth, row * portionHeight, portionWidth, portionHeight);
            CGImageRef ref = CGImageCreateWithImageInRect(carNumViewWholeImage.CGImage, portionImageFrame);
            UIImage *portionImage = [UIImage imageWithCGImage:ref];
            CGImageRelease(ref);
            
            CGRect portionframe = CGRectMake(self.frame.origin.x + portionImageFrame.origin.x, self.frame.origin.y + portionImageFrame.origin.y,
                                             portionWidth, portionHeight);
            UIImageView *portionImageView = [[UIImageView alloc] initWithFrame:portionframe];
            portionImageView.image = portionImage;
            [self.superview addSubview:portionImageView];
            [portionsArray addObject:portionImageView];
            
            
            /// find the point on the circle
            CGPoint projectionPoint = CGPointZero;
            /// the circle's center is at (h,k)
            /// line equation  y = b
            if (circleCenter.y == portionImageView.center.y) {
                projectionPoint.y = circleCenter.y;
                BOOL isLeftOfCenter = (portionImageView.center.x < circleCenter.x);
                if (isLeftOfCenter) {
                    projectionPoint.x = -self.radius + circleCenter.x;
                }
                else{
                    projectionPoint.x = self.radius + circleCenter.x;
                }
                
                
            }
            /// line equation x = b
            else if (circleCenter.x == portionImageView.center.x){
                projectionPoint.x = circleCenter.x;
                BOOL isAboveTheCenter = (portionImageView.center.y < circleCenter.y);
                if (isAboveTheCenter) {
                    projectionPoint.y = -self.radius + circleCenter.y;
                }
                else{
                    projectionPoint.y = self.radius + circleCenter.y;
                }
            }
            /// line equation y = ax + b
            else{
                /// compute a & b
                CGFloat a = (portionImageView.center.y - circleCenter.y) / (portionImageView.center.x - circleCenter.x);
                CGFloat b = portionImageView.center.y - a * portionImageView.center.x;
                
                /// compute x & y from the system:
                /// (x-h)^2 + (y-k)^2 = r^2
                /// y = ax+b
                ///
                /// We get: (1+a^2)x^2 + (2ab - 2h - 2ak)x + (h^2+b^2-2b+k^2-r^2) = 0
                /// A = 1+a^2
                /// B = 2ab - 2h - 2ak
                /// C = (h^2+b^2-2b+k^2-r^2)
                ///
                /// => Ax^2+Bx+C=0
                /// △ = B^2 - 4AC
                /// Cases:
                /// 1) △ > 0 - 2  roots
                /// 2) △ = 0 - 1 real root
                /// 3) △ < 0 - no root
                CGFloat A = 1 + a * a;
                CGFloat B = 2 * a * b - 2 * circleCenter.x - 2 * a * circleCenter.y;
                CGFloat C = circleCenter.x * circleCenter.x + b * b - 2 * b * circleCenter.y + circleCenter.y * circleCenter.y - self.radius * self.radius;
                CGFloat discriminant = B * B - 4 * A * C;
                NSAssert(discriminant >= 0, @"The discriminant is negative, there aren't any root");
                /// there are2 roots
                if (discriminant > 0) {
                    CGFloat root1 =  (-B + sqrtf(B * B - 4 * A * C)) / (2 * A);
                    CGFloat root2 =  (-B - sqrtf(B * B - 4 * A * C)) / (2 * A);
                    BOOL isLeftOfCenter = (portionImageView.center.x < circleCenter.x);
                    if (isLeftOfCenter) {
                        projectionPoint.x = MIN(root1, root2);
                    }
                    else{
                        projectionPoint.x = MAX(root1, root2);
                    }
                    
                    projectionPoint.y = a * projectionPoint.x + b;
                }
            }
            
            [coordinatesArray addObject:[NSValue valueWithCGPoint:projectionPoint]];
        }
    }
    
    
    if (hide) {
        self.hidden = YES;
    }
    
    
    /// smash into pieces
    [UIView animateWithDuration:self.animationDuration
                          delay:0
         usingSpringWithDamping:1
          initialSpringVelocity:0
                        options:UIViewAnimationOptionBeginFromCurrentState|UIViewAnimationOptionAllowUserInteraction
                     animations:^{
                         for (NSUInteger i = 0; i < coordinatesArray.count; ++i) {
                             NSValue *coordinateValue = coordinatesArray[i];
                             CGPoint projectionCoordinate = coordinateValue.CGPointValue;
                             UIImageView *portionImageView = portionsArray[i];
                             portionImageView.center = projectionCoordinate;
                             portionImageView.transform = CGAffineTransformMakeScale(0.3, 0.3);
                             portionImageView.alpha = 0.0f;
                         }
                     } completion:^(BOOL finished) {
                         for (NSUInteger i = 0; i < coordinatesArray.count; ++i) {
                             UIImageView *portionImageView = portionsArray[i];
                             [portionImageView removeFromSuperview];
                             portionImageView = nil;
                         }
                             
                         if (completion) {
                             completion(finished);
                         }
                     }];
    
}


#pragma mark - PRIVATE -

- (void) setRows:(NSUInteger)rows{
    NSAssert(rows >= 2, @"The lower bound of rows is less than %lu", (unsigned long)defaultRows);
    _rows = rows;
}

- (void) setCols:(NSUInteger)cols{
    NSAssert(cols >= 2, @"The lower bound of cols is less than %lu", (unsigned long) defaultRows);
    _cols = cols;
}

- (void) setRadius:(CGFloat)radius{
    CGFloat minRadius = MAX(self.bounds.size.width, self.bounds.size.height);
    NSAssert(radius >= minRadius, @"The lower bound of radius is less than %f", minRadius);
    _radius = radius;
}

- (void) setRadiusMultiplier:(CGFloat)radiusMultiplier{
//    NSAssert(radiusMultiplier >= 1, @"The multiplier cannot be less than 1");
    _radiusMultiplier = radiusMultiplier;
}


- (void) _setupDefaultValues{
    _rows = defaultRows;
    _cols = defaultCols;
    _radiusMultiplier = defaultRadiusMultiplier;
    _radius = MAX(self.bounds.size.width, self.bounds.size.height) * _radiusMultiplier;
    _animationDuration = defaultAnimationDuration;
}

@end
