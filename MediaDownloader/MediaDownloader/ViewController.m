//
//  ViewController.m
//  MediaDownloader
//
//  Created by Ivan on 2016/11/26.
//  Copyright © 2016年 Ivan. All rights reserved.
//

#import "ViewController.h"
#import "MediaDownloader.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    MediaDownloader *downloader = [MediaDownloader sharedDownloader];
    [downloader setMaxConcurrentDownloads:4];
    
    NSMutableArray *arr = [NSMutableArray arrayWithObjects:@"http://mvvideo1.meitudata.com/55b447cb9f62a3176.mp4",
                           @"http://mvvideo1.meitudata.com/55b5c7bc9ca259064.mp4",
                           @"http://mvvideo2.meitudata.com/55b5c867884201037.mp4",
                           @"http://mvvideo2.meitudata.com/55b6cbd64b5435820.mp4",
                           @"http://mvvideo1.meitudata.com/55b87ef8a3fbc7100.mp4",
                           @"http://mvvideo1.meitudata.com/55b87f0ea0ebe3029.mp4",
                           @"http://mvvideo2.meitudata.com/55b99cc45712a4751.mp4",
                           @"http://mvvideo1.meitudata.com/55bc8e53540b05749.mp4",
                           @"http://mvvideo1.meitudata.com/55c3008b2ed3a1535.mp4",
                           @"http://mvvideo1.meitudata.com/55c42d2da0a177508.mp4",
                           @"http://mvvideo1.meitudata.com/55c7851b551fb7733.mp4",
                           @"http://mvvideo1.meitudata.com/55c99f2f9e5896016.mp4",
                           @"http://mvvideo2.meitudata.com/55cb2936864877299.mp4",
                           @"http://mvvideo1.meitudata.com/55cd3a7bd1bc99559.mp4",
                           @"http://mvvideo1.meitudata.com/55ce890ee4ec01443.mp4",
                           @"http://mvvideo2.meitudata.com/55d52473bec689521.mp4",
                           @"http://mvvideo1.meitudata.com/55d525029a9eb6084.mp4",
                           @"http://mvvideo2.meitudata.com/55d686deab3746588.mp4",
                           @"http://mvvideo1.meitudata.com/55de53e3c63ec917.mp4",
                           @"http://mvvideo2.meitudata.com/55dfb9c1e567d2755.mp4", nil];
    
    for(int i = 0;i<[arr count];i++)
    {
        __block int index = i;
        [downloader downloadWithURL:[NSURL URLWithString:arr[i]] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
            
            NSLog(@"%i----------%f",index,receivedSize*1.0/expectedSize);
        } completed:^(NSData *data, NSError *error, BOOL finished) {
            NSLog(@"%@",[NSThread currentThread]);
        }];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
