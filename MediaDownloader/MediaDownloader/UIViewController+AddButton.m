//
//  UIViewController+AddButton.m
//  ZOSDKDemo
//
//  Created by wyw on 16/10/14.
//  Copyright © 2016年 ZeroTech. All rights reserved.
//

#import "UIViewController+AddButton.h"
#import "BlockButton.h"


@implementation UIViewController (AddButton)


-(void)addBt:(NSString *)title frame:(CGRect)frame autoresizing:(UIViewAutoresizing)autoresizing block:(void (^)(id BlockButton))block
{
    BlockButton *bt = [[BlockButton alloc] initWithFrame:frame];
    bt.autoresizingMask = autoresizing;
    bt.block  =block;
    
    [bt setTitle:title forState:UIControlStateNormal];
    
    [self.view addSubview:bt];
    
}



@end
