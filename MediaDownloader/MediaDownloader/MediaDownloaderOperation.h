//
//  MediaDownloaderOperation.h
//  MediaDownloader
//
//  Created by Ivan on 2016/11/26.
//  Copyright © 2016年 Ivan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MediaDownloader.h"
#import "MediaOperation.h"

extern NSString *const MediaDownloadStartNotification;
extern NSString *const MediaDownloadReceiveResponseNotification;
extern NSString *const MediaDownloadStopNotification;
extern NSString *const MediaDownloadFinishNotification;

@interface MediaDownloaderOperation : NSOperation <MediaOperation, NSURLSessionTaskDelegate, NSURLSessionDataDelegate>

/**
 * The request used by the operation's task.
 */
@property (strong, nonatomic, readonly) NSURLRequest *request;

/**
 * The operation's task
 */
@property (strong, nonatomic, readonly) NSURLSessionTask *dataTask;

/**
 * The MediaDownloaderOptions for the receiver.
 */
@property (assign, nonatomic, readonly) MediaDownloaderOptions options;

/**
 * The expected size of data.
 */
@property (assign, nonatomic) NSInteger expectedSize;

/**
 * The response returned by the operation's connection.
 */
@property (strong, nonatomic) NSURLResponse *response;

/**
 *  Initializes a `MediaDownloaderOperation` object
 *
 *  @see MediaDownloaderOperation
 *
 *  @param request        the URL request
 *  @param session        the URL session in which this operation will run
 *  @param options        downloader options
 *  @param progressBlock  the block executed when a new chunk of data arrives.
 *                        @note the progress block is executed on a background queue
 *  @param completedBlock the block executed when the download is done.
 *                        @note the completed block is executed on the main queue for success. If errors are found, there is a chance the block will be executed on a background queue
 *  @param cancelBlock    the block executed if the download (operation) is cancelled
 *
 *  @return the initialized instance
 */
- (id)initWithRequest:(NSURLRequest *)request
            inSession:(NSURLSession *)session
              options:(MediaDownloaderOptions)options
             progress:(MediaDownloaderProgressBlock)progressBlock
            completed:(MediaDownloaderCompletedBlock)completedBlock
            cancelled:(MediaNoParamsBlock)cancelBlock;

@end
