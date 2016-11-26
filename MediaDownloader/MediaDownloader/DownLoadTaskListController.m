//
//  DownLoadTaskListController.m
//  MediaDownloader
//
//  Created by Ivan on 2016/11/26.
//  Copyright © 2016年 Ivan. All rights reserved.
//

#import "DownLoadTaskListController.h"
#import "DownLoadTaskCell.h"

@interface DownLoadTaskListController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation DownLoadTaskListController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor clearColor]];
    
    self.tableView = [[UITableView alloc] init];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.8]];
    [self.tableView registerClass:[DownLoadTaskCell class] forCellReuseIdentifier:NSStringFromClass([DownLoadTaskCell class])];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleMediaLoadingDidEndNotification:)
                                                 name:@"MEDIA_LOADING_DID_END_NOTIFICATION"
                                               object:nil];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.tableView.frame = CGRectMake(50, 100, self.view.bounds.size.width-100, self.view.bounds.size.height - 200);
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self dismissViewControllerAnimated:NO completion:^{
        
    }];
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 40)];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, tableView.frame.size.width, 20)];
    label.font = [UIFont systemFontOfSize:16.0f];
    label.numberOfLines = 0;
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentLeft;
    [label setBackgroundColor:[UIColor clearColor]];
    label.text = @"下载列表";
    [headerView addSubview:label];
    return  headerView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DownLoadTaskCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([DownLoadTaskCell class])
                                                       forIndexPath:indexPath];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSString *url = self.data[indexPath.row];
    [cell setUrl:url];
    if(self.progressDict[url])
    {
        [cell setProgress:[self.progressDict[url] floatValue]];
    }
    else
    {
        [cell setProgress:0];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}

- (void)handleMediaLoadingDidEndNotification:(NSNotification *)notification {
    NSString *url = [notification object];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.data removeObject:url];
        [self.tableView reloadData];
        
        if([self.data count] == 0)
        {
            [self dismissViewControllerAnimated:NO completion:^{
                
            }];
        }
    });

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
