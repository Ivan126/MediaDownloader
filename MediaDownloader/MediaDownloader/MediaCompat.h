//
//  MediaCompat.h
//  MediaDownloader
//
//  Created by Ivan on 2016/11/26.
//  Copyright © 2016年 Ivan. All rights reserved.
//


#import <UIKit/UIKit.h>


typedef void(^MediaNoParamsBlock)();

extern NSString *const MediaErrorDomain;

#define dispatch_main_sync_safe(block)\
if ([NSThread isMainThread]) {\
block();\
} else {\
dispatch_sync(dispatch_get_main_queue(), block);\
}
