//
//  MediaDownloader.h
//  MediaDownloader
//
//  Created by Ivan on 2016/11/26.
//  Copyright © 2016年 Ivan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MediaCompat.h"
#import "MediaOperation.h"

typedef NS_OPTIONS(NSUInteger, MediaDownloaderOptions) {
    MediaDownloaderLowPriority = 1 << 0,
   
    /**
     * By default, request prevent the use of NSURLCache. With this flag, NSURLCache
     * is used with default policies.
     */
    MediaDownloaderUseNSURLCache = 1 << 1,
    
    /**
     * Call completion block with nil image/imageData if the image was read from NSURLCache
     * (to be combined with `MediaDownloaderUseNSURLCache`).
     */
    
    MediaDownloaderIgnoreCachedResponse = 1 << 2,
    /**
     * In iOS 4+, continue the download of the image if the app goes to background. This is achieved by asking the system for
     * extra time in background to let the request finish. If the background task expires the operation will be cancelled.
     */
    
    MediaDownloaderContinueInBackground = 1 << 3,
    
    /**
     * Handles cookies stored in NSHTTPCookieStore by setting
     * NSMutableURLRequest.HTTPShouldHandleCookies = YES;
     */
    MediaDownloaderHandleCookies = 1 << 4,
    
    /**
     * Enable to allow untrusted SSL certificates.
     * Useful for testing purposes. Use with caution in production.
     */
    MediaDownloaderHighPriority = 1 << 5,
};

typedef NS_ENUM(NSInteger, MediaDownloaderExecutionOrder) {
    /**
     * Default value. All download operations will execute in queue style (first-in-first-out).
     */
    MediaDownloaderFIFOExecutionOrder,
    
    /**
     * All download operations will execute in stack style (last-in-first-out).
     */
    MediaDownloaderLIFOExecutionOrder
};

extern NSString *const MediaDownloadStartNotification;
extern NSString *const MediaDownloadStopNotification;

typedef void(^MediaDownloaderProgressBlock)(NSInteger receivedSize, NSInteger expectedSize);

typedef void(^MediaDownloaderCompletedBlock)(NSData *data, NSError *error, BOOL finished);

typedef NSDictionary *(^MediaDownloaderHeadersFilterBlock)(NSURL *url, NSDictionary *headers);

/**
 * Asynchronous downloader dedicated and optimized for image loading.
 */
@interface MediaDownloader : NSObject

@property (assign, nonatomic) NSInteger maxConcurrentDownloads;

/**
 * Shows the current amount of downloads that still need to be downloaded
 */
@property (readonly, nonatomic) NSUInteger currentDownloadCount;


/**
 *  The timeout value (in seconds) for the download operation. Default: 15.0.
 */
@property (assign, nonatomic) NSTimeInterval downloadTimeout;


/**
 * Changes download operations execution order. Default value is `MediaDownloaderFIFOExecutionOrder`.
 */
@property (assign, nonatomic) MediaDownloaderExecutionOrder executionOrder;

/**
 *  Singleton method, returns the shared instance
 *
 *  @return global shared instance of downloader class
 */
+ (MediaDownloader *)sharedDownloader;

/**
 * Sets a subclass of `MediaDownloaderOperation` as the default
 * `NSOperation` to be used each time Media constructs a request
 * operation to download an image.
 *
 * @param operationClass The subclass of `MediaDownloaderOperation` to set
 *        as default. Passing `nil` will revert to `MediaDownloaderOperation`.
 */
- (void)setOperationClass:(Class)operationClass;

/**
 * Creates a MediaDownloader async downloader instance with a given URL
 *
 * The delegate will be informed when the image is finish downloaded or an error has happen.
 *
 * @see MediaDownloaderDelegate
 *
 * @param url            The URL to the image to download
 * @param options        The options to be used for this download
 * @param progressBlock  A block called repeatedly while the image is downloading
 * @param completedBlock A block called once the download is completed.
 *                       If the download succeeded, the image parameter is set, in case of error,
 *                       error parameter is set with the error. The last parameter is always YES
 *                       if MediaDownloaderProgressiveDownload isn't use. With the
 *                       MediaDownloaderProgressiveDownload option, this block is called
 *                       repeatedly with the partial image object and the finished argument set to NO
 *                       before to be called a last time with the full image and finished argument
 *                       set to YES. In case of error, the finished argument is always YES.
 *
 * @return A cancellable MediaOperation
 */
- (id <MediaOperation>)downloadWithURL:(NSURL *)url
                                         options:(MediaDownloaderOptions)options
                                        progress:(MediaDownloaderProgressBlock)progressBlock
                                       completed:(MediaDownloaderCompletedBlock)completedBlock;

/**
 * Sets the download queue suspension state
 */
- (void)setSuspended:(BOOL)suspended;

/**
 * Cancels all download operations in the queue
 */
- (void)cancelAllDownloads;

@end
