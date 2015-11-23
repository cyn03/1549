//
//  TwoViewController.m
//  HeartPro
//
//  Created by qianfeng on 15/11/12.
//  Copyright (c) 2015年 xiaoxiao. All rights reserved.
//

#import "TwoViewController.h"
#import "TwoTableViewCell.h"
@interface TwoViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *_dataArray;
}
@end

@implementation TwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor yellowColor];
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
    
    [manager GET:MESSAGE_URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        
        for (NSDictionary *dic in dict[@"topLists"]) {
            
            if ([[NSString stringWithFormat:@"%@",dic[@"type"]]isEqualToString:@"0"]) {
                [_dataArray addObject:dic];
            }
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
    
    TwoTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"TwoCell"];
    
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"TwoCell" owner:self options:nil] firstObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.titleLabel.text = _dataArray[indexPath.row][@"topListNameCn"];
    cell.summaryLabel.text = _dataArray[indexPath.row][@"summary"];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"ZX" object:_dataArray[indexPath.row][@"id"]];
}

@end
