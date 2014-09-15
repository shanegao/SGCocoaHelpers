//
//  UIViewHelper.m
//  SGCocoaHelpers
//
//  Created by Shane Gao on 5/14/13.
//  Copyright (c) 2013 touchmob.com. All rights reserved.
//

#import "UIView+Helpers.h"
@implementation UIView (SG_Layout)
- (CGFloat)left
{
    return CGRectGetMinX(self.frame);
}

- (void)setLeft:(CGFloat)l
{
    CGRect viewFrame = self.frame;
    viewFrame.origin.x = l;
    self.frame = viewFrame;
}

- (CGFloat)right
{
    return CGRectGetMaxX(self.frame);
}

- (void)setRight:(CGFloat)r
{
    self.left = r - self.width;
}

- (CGFloat)top
{
    return CGRectGetMinY(self.frame);
}

- (void)setTop:(CGFloat)t
{
    CGRect viewFrame = self.frame;
    viewFrame.origin.y = t;
    self.frame = viewFrame;
}

- (CGFloat)bottom
{
    return CGRectGetMaxY(self.frame);
}

- (void)setBottom:(CGFloat)b
{
    self.top = b - self.height;
}
- (CGFloat)width
{
    return CGRectGetWidth(self.frame);
}
- (void)setWidth:(CGFloat)w
{
    CGRect viewFrame = self.frame;
    viewFrame.size.width = w;
    self.frame = viewFrame;
}

- (CGFloat)height
{
    return CGRectGetHeight(self.frame);
}
- (void)setHeight:(CGFloat)h
{
    CGRect viewFrame = self.frame;
    viewFrame.size.height = h;
    self.frame = viewFrame;
}

- (CGPoint)origin {
    return self.frame.origin;
}


- (void)setOrigin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}


- (CGSize)size {
    return self.frame.size;
}


- (void)setSize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
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

@implementation UIView (Helpers)

- (void)removeAllSubviews
{
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
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



@end
