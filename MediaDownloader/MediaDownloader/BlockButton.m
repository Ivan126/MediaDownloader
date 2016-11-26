//
//  BlockButton.m
//  ZOSDKDemo
//
//  Created by wyw on 16/10/14.
//  Copyright © 2016年 ZeroTech. All rights reserved.
//

#import "BlockButton.h"

@implementation BlockButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        
        
        [self setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:60/255.f green:140/255.f blue:250/255.f alpha:1]] forState:UIControlStateNormal];
        
        [self setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:0/255.f green:100/255.f blue:200/255.f alpha:1]] forState:UIControlStateHighlighted];
        
        
        [self addTarget:self action:@selector(touchAction:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return self;
}


- (void)touchAction:(id)sender
{
    _block(self);
}


- (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
