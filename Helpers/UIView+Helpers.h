//
//  UIViewHelper.h
//  SGCocoaHelpers
//
//  Created by Shane Gao on 5/14/13.
//  Copyright (c) 2013 touchmob.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

@interface UIView (SG_Layout)
@property(nonatomic) CGFloat left;
@property(nonatomic) CGFloat right;
@property(nonatomic) CGFloat top;
@property(nonatomic) CGFloat bottom;
@property(nonatomic) CGFloat width;
@property(nonatomic) CGFloat height;
@property (nonatomic) CGPoint origin;
@property (nonatomic) CGSize size;
/**
 *	create a UIView
 */
+ (UIView *)viewWithFrame:(CGRect)frame
             contentColor:(UIColor *)contentColor
              borderColor:(UIColor *)borderColor
              borderWidth:(CGFloat)borderWidth
             cornerRadius:(CGFloat)cornerRadius;
@end

@interface UIView (Helpers)
- (void)removeAllSubviews;
- (UIView *)findSuperViewWithClass:(Class)superViewClass;
@end

@interface UIViewHelper : NSObject
/**
 *	create a UIImageView
 */
+ (UIImageView *)imageViewWithFrame:(CGRect)frame image:(UIImage *)image;
/**
 *	create a UILabel
 */
+ (UILabel *)labelWithFrame:(CGRect)labelFrame labelTxt:(NSString *)labelText textFont:(UIFont *)font textColor:(UIColor *)color;

/**
 *	create a UIButton
 */
+ (UIButton *)imageButtonWithFrame:(CGRect)buttonFrame image:(UIImage *)image target:(id)target action:(SEL)action;

/**
 *	create a UIButton just as Link Text
 */
+ (UIButton *)textButtonWithFrame:(CGRect)buttonFrame title:(NSString *)buttonTitle font:(UIFont *)font titleColor:(UIColor *)color target:(id)target action:(SEL)action;

+ (UIButton *)buttonWithFrame:(CGRect)buttonFrame backgroundImage:(UIImage *)image title:(NSString *)buttonTitle font:(UIFont *)font titleColor:(UIColor *)color target:(id)target action:(SEL)action;

+ (UIButton *)buttonWithFrame:(CGRect)buttonFrame backgroundImage:(UIImage *)image target:(id)target action:(SEL)action;
@end