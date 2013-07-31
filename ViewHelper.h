//
//  ViewHelper.h
//  
//
//  Created by Shane Gao on 5/14/13.
//  Copyright (c) 2013 touchmob.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

@interface UIView (Layout)
- (CGFloat)x;
- (void)setX:(CGFloat)xx;
- (CGFloat)y;
- (void)setY:(CGFloat)yy;
- (CGFloat)width;
- (void)setWidth:(CGFloat)w;
- (CGFloat)height;
- (void)setHeight:(CGFloat)h;
@end

@interface ViewHelper : NSObject
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
/**
 *	create a UIView
 */
+ (UIView *)viewWithFrame:(CGRect)frame contentColor:(UIColor *)contentColor borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth cornerRadius:(CGFloat)cornerRadius;
@end