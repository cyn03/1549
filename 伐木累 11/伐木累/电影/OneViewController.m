//
//  OneViewController.m
//  HeartPro
//
//  Created by qianfeng on 15/11/12.
//  Copyright (c) 2015年 xiaoxiao. All rights reserved.
//

#import "OneViewController.h"
#import "OneTableViewCell.h"
#import "OneXQViewController.h"
@interface OneViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *_dataArray;
}
@end

@implementation OneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    _dataArray = [[NSMutableArray alloc]init];
    self.navigationController.navigationBarHidden = YES;

    [self setData];
}

-(void)setData{
    
    MBProgressHUD *hud = [[MBProgressHUD alloc]initWithView:self.view];
    hud.labelText = @"加载中...";
    [self.view addSubview:hud];
    [hud show:YES];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:SHOWING_URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        
        for (NSDictionary *dic in dict[@"entries"]) {
            
            [_dataArray addObject:dic];
        }
        [hud hide:YES];
        [self.tv reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    OneTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"OneCell"];
    
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"OneCell" owner:self options:nil] firstObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [cell.oneImage sd_setImageWithURL:[NSURL URLWithString:_dataArray[indexPath.row][@"images"][@"large"]] placeholderImage:[UIImage imageNamed:@"default_pic_big"]];
    cell.titleLabel.text = _dataArray[indexPath.row][@"title"];
    cell.orignalLabel.text = _dataArray[indexPath.row][@"original_title"];
    cell.markLabel.text = [NSString stringWithFormat:@"%@分",_dataArray[indexPath.row][@"rating"]];
    cell.dayLabel.text = _dataArray[indexPath.row][@"pubdate"];
    cell.collectionLabel.text = [NSString stringWithFormat:@"收藏：%@",_dataArray[indexPath.row][@"collection"]];
    
    
    cell.view = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(cell.tuijianLabel.frame)+15, CGRectGetMaxY(cell.tuijianLabel.frame)-20, 65, 23)];
    cell.view.image = [UIImage imageNamed:@"StarsForeground"];
    [cell.contentView addSubview:cell.view];
    CGRect rect = cell.view.frame;
    CGFloat score = [_dataArray[indexPath.row][@"stars"]floatValue]/10;
    cell.view.frame = CGRectMake(rect.origin.x, rect.origin.y, (rect.size.width/5)*score, rect.size.height);
    //切割
    cell.view.clipsToBounds = YES;
    cell.view.contentMode = UIViewContentModeLeft;
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 160;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"MOVIE" object:_dataArray[indexPath.row][@"id"]];
}


@end
