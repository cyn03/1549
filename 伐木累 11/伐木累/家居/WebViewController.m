//
//  WebViewController.m
//  HeartPro
//
//  Created by qianfeng on 15/11/10.
//  Copyright (c) 2015年 xiaoxiao. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"更多详情";
    
    [self createWebView];
}

-(void)createWebView{
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"加载中...";
    [hud show:YES];
    
    UIWebView *view = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, SWIDTH, HEIGHT)];
    view.scalesPageToFit = YES;
    [view loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
    [hud hide:YES];
    [self.view addSubview:view];
}

@end
