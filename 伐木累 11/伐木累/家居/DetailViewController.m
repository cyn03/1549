//
//  DetailViewController.m
//  HeartPro
//
//  Created by qianfeng on 15/11/9.
//  Copyright (c) 2015年 xiaoxiao. All rights reserved.
//

#import "DetailViewController.h"
#import "DetailTableViewCell.h"
#import "WebViewController.h"
@interface DetailViewController ()<UITableViewDataSource,UITableViewDelegate,UIWebViewDelegate>
{
    NSDictionary *_detailDic;
    UITableView *_tableView;
    float titleheight;
    float height;
    NSString *_url;
}
@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _detailDic = [[NSDictionary alloc]init];
    
    [self createDetailData];
    self.title = @"专题详情";
    
    [self hideExtraTableViewCell];
}

-(void)hideExtraTableViewCell{
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectZero];
    
    [_tableView setTableFooterView:view];
}

-(void)createDetailData{
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"加载中...";
    [hud show:YES];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:[NSString stringWithFormat:URL_Detai,self.url] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        
        _detailDic = dict[@"data"];
        
        [hud hide:YES];
        
        [self performSelectorOnMainThread:@selector(refreshDetail) withObject:nil waitUntilDone:YES];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

-(void)refreshDetail{
    
    [self createTableView];
    [_tableView reloadData];
}

-(void)createTableView{
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SWIDTH, HEIGHT-64) style:UITableViewStylePlain];
    _tableView.contentInset = UIEdgeInsetsMake(0, 0, 50, 0);
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(SWIDTH-120, height+titleheight+220, 100, 30)];
    
    [button addTarget:self action:@selector(BtnClick) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"更多详情..." forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [_tableView addSubview:button];

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DetailTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ID"];
    if (!cell) {
        cell = [[DetailTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ID"];
    }
    
    [cell createCell:_detailDic height:height+20 titleheight:titleheight+20];
    _url = _detailDic[@"content_url"];
   
     return cell;
    
}


-(void)BtnClick{
    
    WebViewController *webview = [[WebViewController alloc]init];
    
    webview.url = _url;
    webview.hidesBottomBarWhenPushed = YES;

    [self.navigationController pushViewController:webview animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *strContent = _detailDic[@"share_msg"];
    height = [strContent boundingRectWithSize:CGSizeMake(SWIDTH-20, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil].size.height;
    
    NSString *titleContent = _detailDic[@"title"];
    titleheight = [titleContent boundingRectWithSize:CGSizeMake(SWIDTH-20, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:22]} context:nil].size.height;
    
    return height+200+20+titleheight+40;
}


@end
