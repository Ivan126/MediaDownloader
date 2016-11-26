//
//  DownLoadTaskCell.m
//  MediaDownloader
//
//  Created by Ivan on 2016/11/26.
//  Copyright © 2016年 Ivan. All rights reserved.
//

#import "DownLoadTaskCell.h"

@interface DownLoadTaskCell ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIProgressView *progressView;
@property (nonatomic, strong) UILabel *progressTextLabel;
@property (nonatomic, strong) NSString *url;

@end

@implementation DownLoadTaskCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor clearColor];
        
        
        self.titleLabel = [[UILabel alloc] init];
        [self.contentView addSubview:self.titleLabel];
        self.titleLabel.textColor = [UIColor whiteColor];
        self.titleLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:self.titleLabel];
        
        
        self.progressView = [[UIProgressView alloc] init];
        self.progressView.trackTintColor = [UIColor whiteColor];
        self.progressView.progressTintColor = [UIColor greenColor];
        [self.contentView addSubview:self.progressView];
        
        
        self.progressTextLabel = [[UILabel alloc] init];
        self.progressTextLabel.textColor = [UIColor whiteColor];
        self.progressTextLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:self.progressTextLabel];
        
        [self.progressTextLabel setTextAlignment:NSTextAlignmentRight];
        
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(setProgressFromNotification:)
                                                     name:@"MEDIA_PROGRESS_NOTIFICATION"
                                                   object:nil];

    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [_titleLabel setFrame:CGRectMake(10, 10, self.frame.size.width - 20, 20)];
    [_progressView setFrame:CGRectMake(10, 30, self.frame.size.width - 20, 5)];
    [_progressTextLabel setFrame:CGRectMake(10, 40, self.frame.size.width - 20, 20)];
    
}

-(void)setUrl:(NSString *)url
{
    _url = url;
    NSURL *theUrl = [NSURL URLWithString:url];
    [self.titleLabel setText:[theUrl lastPathComponent]];
}

- (void)setProgress:(float)progress
{
    NSLog(@"%f",progress);
    self.progressView.progress = MAX(MIN(1, progress), 0);
    self.progressTextLabel.text = [NSString stringWithFormat:@"%4.2f%%",self.progressView.progress*100];
}

- (void)setProgressFromNotification:(NSNotification *)notification {
    NSDictionary *dict = [notification object];
    NSString *url = [dict objectForKey:@"url"];
    if ([url isEqualToString:_url]) {
        float progress = [[dict valueForKey:@"progress"] floatValue];
        [self setProgress:progress];
    }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
