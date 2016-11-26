//
//  ViewController.m
//  MediaDownloader
//
//  Created by Ivan on 2016/11/26.
//  Copyright © 2016年 Ivan. All rights reserved.
//

#import "ViewController.h"
#import "MediaDownloader.h"
#import "UIViewController+AddButton.h"
#import "DownLoadTaskListController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    __weak __typeof(self)weakSelf = self;
    
    [self addBt:@"开始下载" frame:CGRectMake(20, 40, 120, 40)
   autoresizing:UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin
          block:^(id BlockButton) {
              [weakSelf startDownLoad];
          }];

}


-(void)startDownLoad
{

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
    
    
    NSMutableDictionary *progressDict = [NSMutableDictionary dictionary];
    
    DownLoadTaskListController *vc = [[DownLoadTaskListController alloc] init];
    vc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    
    
    if(arr.count > 0)
    {
        vc.data = arr;
        vc.progressDict = progressDict;
        [self presentViewController:vc animated:YES completion:^{
            
        }];
    }
    
    
    MediaDownloader *downloader = [MediaDownloader sharedDownloader];
    
    [downloader cancelAllDownloads];
    
    [downloader setMaxConcurrentDownloads:2];
    
    
    
    for(int i = 0;i<[arr count];i++)
    {
        NSString *url = [arr objectAtIndex:i];
        [downloader downloadWithURL:[NSURL URLWithString:url] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
            
            if (expectedSize > 0)
            {
                float progress = receivedSize / (float)expectedSize;
                NSDictionary* dict = [NSDictionary dictionaryWithObjectsAndKeys:
                                      [NSNumber numberWithFloat:progress], @"progress",
                                      url, @"url", nil];
                
                progressDict[url] = [NSNumber numberWithFloat:progress];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"MEDIA_PROGRESS_NOTIFICATION" object:dict];
                
                
            }
        } completed:^(NSData *data, NSError *error, BOOL finished) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"MEDIA_LOADING_DID_END_NOTIFICATION" object:url];
            
        }];
    }
    
    

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
