//
//  DownLoadTaskCell.h
//  MediaDownloader
//
//  Created by weiyanwu on 2016/11/26.
//  Copyright © 2016年 Ivan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DownLoadTaskCell : UITableViewCell

- (void)setUrl:(NSString *)url;
- (void)setProgress:(float)progress;

@end
