//
//  SearchViewController.m
//  伐木累
//
//  Created by qianfeng on 15/11/15.
//  Copyright (c) 2015年 xiaoxiao. All rights reserved.
//

#import "SearchViewController.h"
#import "SearchCell.h"
@interface SearchViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *_dataArray;
    NSDictionary *_dict;
}
@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataArray = [[NSMutableArray alloc]init];
    
    [self createData];
    [self hideFoodView];
    [self createNav];
}

-(void)createNav{
    
    UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, 30)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
}

-(void)hideFoodView{
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectZero];
    self.tv.tableFooterView = view;
}

-(void)createData{
    
    MBProgressHUD *hud = [[MBProgressHUD alloc]initWithView:self.view];
    hud.labelText = @"加载中...";
    [self.view addSubview:hud];
    [hud show:YES];
    
    NSString *url = [NSString stringWithFormat:SEARCH_NAME_URL,self.str];
    NSString * Url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *NewURL = [NSString stringWithFormat:@"%@%@",SEARCH_URL,Url];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:NewURL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        _dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        
        for (NSDictionary *dic in _dict[@"subjects"]) {
            [_dataArray addObject:dic];
        }
        if (_dataArray.count == 0) {
            [self createUI];
        }
        
        [hud hide:YES];
        [self.tv reloadData];
        [self createNavTitle];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

-(void)createNavTitle{
    
    UIButton * but = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, SWIDTH-60, 28)];
    [but setTitle:_dict[@"title"] forState:UIControlStateNormal];
    self.navigationItem.titleView = but;
}

-(void)createUI{
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"搜索无结果!" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    
    [alert show];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SearchCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SearchCell"];
    
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"SearchCell" owner:self options:nil]firstObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSDictionary *dic = _dataArray[indexPath.row];
    
    [cell.SearchImage sd_setImageWithURL:[NSURL URLWithString:dic[@"images"][@"medium"]] placeholderImage:[UIImage imageNamed:@"default_pic_big"]];
    cell.SearchNameLabel.text = dic[@"title"];
    NSMutableString *str = [[NSMutableString alloc]init];
    for (int i = 0; i < [dic[@"casts"]count]; i ++) {
        [str appendString:dic[@"casts"][i][@"name"]];
        if (i == [dic[@"casts"]count]-1) {
            continue;
        }
        [str appendString:@"/"];
    }
    cell.SearchLabel1.text = [NSString stringWithFormat:@"主演: %@",str];
    
    NSMutableString *str1 = [[NSMutableString alloc]init];
    for (int i = 0; i < [dic[@"genres"]count]; i ++) {
        [str1 appendString:dic[@"genres"][i]];
        if (i == [dic[@"genres"]count]-1) {
            continue;
        }
        [str1 appendString:@"/"];
    }
    cell.SearchLabel2.text = [NSString stringWithFormat:@"类型: %@",str1];
    
    if ([dic[@"pubdates"]count]!=0) {
        cell.SearchLabel3.text = [NSString stringWithFormat:@"上映时间: %@",dic[@"pubdates"][0]];
    }else{
        cell.SearchLabel3.text = [NSString stringWithFormat:@"上映时间: nil"];
    }
    
    if ([dic[@"durations"]count]!=0) {
        cell.SearchLabel4.text = [NSString stringWithFormat:@"片长: %@",dic[@"durations"][0]];
    }else{
        cell.SearchLabel4.text = [NSString stringWithFormat:@"片长: nil"];
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 160;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    [[NSNotificationCenter defaultCenter]postNotificationName:@"THREE" object:_dataArray[indexPath.row][@"id"]];
}


@end
