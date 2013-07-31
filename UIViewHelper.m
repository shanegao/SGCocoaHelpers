//
//  ViewHelper.m
//  
//
//  Created by Shane Gao on 5/14/13.
//  Copyright (c) 2013 touchmob.com. All rights reserved.
//

#import "UIViewHelper.h"
@implementation UIView (SG_Layout)
- (CGFloat)x
{
    return self.frame.origin.x;
}

- (void)setX:(CGFloat)xx
{
    CGRect viewFrame = self.frame;
    viewFrame.origin.x = xx;
    self.frame = viewFrame;
}
- (CGFloat)y
{
    return self.frame.origin.y;
}

- (void)setY:(CGFloat)yy
{
    CGRect viewFrame = self.frame;
    viewFrame.origin.y = yy;
    self.frame = viewFrame;
}

- (CGFloat)width
{
    return self.frame.size.width;
}
- (void)setWidth:(CGFloat)w
{
    CGRect viewFrame = self.frame;
    viewFrame.size.width = w;
    self.frame = viewFrame;
}

- (CGFloat)height
{
    return self.frame.size.height;
}
- (void)setHeight:(CGFloat)h
{
    CGRect viewFrame = self.frame;
    viewFrame.size.height = h;
    self.frame = viewFrame;
}
@end

@implementation UIViewHelper

+ (UIImageView *)imageViewWithFrame:(CGRect)frame image:(UIImage *)image
{
    UIImageView *iv = [[UIImageView alloc] initWithFrame:frame];
    iv.image = image;
    return iv;
}
+ (UILabel *)labelWithFrame:(CGRect)labelFrame labelTxt:(NSString *)labelText textFont:(UIFont *)font textColor:(UIColor *)color
{
    UILabel *label = [[UILabel alloc] initWithFrame:labelFrame];
    label.text = labelText;
    label.font = font;
    label.textColor = color;
    label.backgroundColor = [UIColor clearColor];
    return label;
}

+ (UIButton *)imageButtonWithFrame:(CGRect)buttonFrame image:(UIImage *)image target:(id)target action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:image forState:UIControlStateNormal];
    button.frame = buttonFrame;
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}

+ (UIButton *)textButtonWithFrame:(CGRect)buttonFrame title:(NSString *)buttonTitle font:(UIFont *)font titleColor:(UIColor *)color target:(id)target action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:buttonTitle forState:UIControlStateNormal];
    button.frame = buttonFrame;
    button.titleLabel.font = font;
    [button setTitleColor:color forState:UIControlStateNormal];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}
+ (UIButton *)buttonWithFrame:(CGRect)buttonFrame backgroundImage:(UIImage *)image title:(NSString *)buttonTitle font:(UIFont *)font titleColor:(UIColor *)color target:(id)target action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:image forState:UIControlStateNormal];
    [button setTitle:buttonTitle forState:UIControlStateNormal];
    button.frame = buttonFrame;
    button.titleLabel.font = font;
    [button setTitleColor:color forState:UIControlStateNormal];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}

+ (UIButton *)buttonWithFrame:(CGRect)buttonFrame backgroundImage:(UIImage *)image target:(id)target action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:image forState:UIControlStateNormal];
    button.frame = buttonFrame;
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}

+ (UIView *)viewWithFrame:(CGRect)frame contentColor:(UIColor *)contentColor borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth cornerRadius:(CGFloat)cornerRadius
{
    UIView *view = [[UIView alloc] initWithFrame:frame];
    view.backgroundColor = contentColor;
    view.layer.borderWidth = borderWidth;
    view.layer.borderColor = borderColor.CGColor;
    view.layer.cornerRadius = cornerRadius;
    return view;
}

@end
