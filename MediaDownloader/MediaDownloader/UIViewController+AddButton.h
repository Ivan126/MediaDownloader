//
//  UIViewController+AddButton.h
//  ZOSDKDemo
//
//  Created by wyw on 16/10/14.
//  Copyright © 2016年 ZeroTech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (AddButton)

-(void)addBt:(NSString *)title frame:(CGRect)frame autoresizing:(UIViewAutoresizing)autoresizing block:(void (^)(id BlockButton))block;

@end
