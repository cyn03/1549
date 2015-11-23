//
//  ThreeViewController.m
//  HeartPro
//
//  Created by qianfeng on 15/11/12.
//  Copyright (c) 2015年 xiaoxiao. All rights reserved.
//

#import "ThreeViewController.h"
#import "ThreeTableViewCell.h" 
@interface ThreeViewController ()
{
    NSMutableArray *_dataArray;
    NSMutableArray *leftArray;
    NSMutableArray *middleArray;
    NSMutableArray *rightArray;
}
@end

@implementation ThreeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor greenColor];
    self.navigationController.navigationBarHidden = YES;

    self.tv.separatorStyle = UITableViewCellAccessoryNone;
    
    [self setData];
    [self creatRefresh];
}

-(void)creatRefresh{
    
    [self.tv addHeaderWithTarget:self action:@selector(click)];
}

-(void)click{
    
    [self setData];
    [self.tv headerEndRefreshing];
}

-(void)setData{
    
    MBProgressHUD *hud = [[MBProgressHUD alloc]initWithView:self.view];
    hud.labelText = @"加载中...";
    [self.view addSubview:hud];
    [hud show:YES];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:RECOMMEND_RANDOM_URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        _dataArray = [[NSMutableArray alloc]init];
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        
        for (NSDictionary *dic in dict[@"subjects"]) {
            
            [_dataArray addObject:dic];
        }
        [hud hide:YES];
        [self.tv reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count/3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ThreeTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ThreeCell"];
    
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"ThreeCell" owner:self options:nil] firstObject];
    }
    
    leftArray = [[NSMutableArray alloc]init];
    middleArray = [[NSMutableArray alloc]init];
    rightArray = [[NSMutableArray alloc]init];
    for (int i = 0; i < _dataArray.count-1; i +=3) {
        [leftArray addObject:_dataArray[i]];
        [middleArray addObject:_dataArray[i+1]];
        [rightArray addObject:_dataArray[i+2]];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [cell.leftImage sd_setImageWithURL:[NSURL URLWithString:leftArray[indexPath.row][@"images"][@"small"]] placeholderImage:[UIImage imageNamed:@"default_pic_big"]];
    cell.leftLabel.text = leftArray[indexPath.row][@"title"];
    UITapGestureRecognizer *lefttap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(leftClick:)];
    cell.leftImage.userInteractionEnabled = YES;
    cell.leftImage.tag = indexPath.row;
    [cell.leftImage addGestureRecognizer:lefttap];
    
    [cell.middleImage sd_setImageWithURL:[NSURL URLWithString:middleArray[indexPath.row][@"images"][@"small"]] placeholderImage:[UIImage imageNamed:@"default_pic_big"]];
    cell.middleLabel.text = middleArray[indexPath.row][@"title"];
    UITapGestureRecognizer *middletap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(middleClick:)];
    cell.middleImage.userInteractionEnabled = YES;
    cell.middleImage.tag = indexPath.row;
    [cell.middleImage addGestureRecognizer:middletap];
    
    [cell.rightImage sd_setImageWithURL:[NSURL URLWithString:rightArray[indexPath.row][@"images"][@"small"]] placeholderImage:[UIImage imageNamed:@"default_pic_big"]];
    cell.righrLabel.text = rightArray[indexPath.row][@"title"];
    UITapGestureRecognizer *righttap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(rightClick:)];
    cell.rightImage.userInteractionEnabled = YES;
    cell.rightImage.tag = indexPath.row;
    [cell.rightImage addGestureRecognizer:righttap];
    
    return cell;
}

-(void)leftClick:(UITapGestureRecognizer *)tap{
    
//    [[NSNotificationCenter defaultCenter]postNotificationName:@"THREE" object:leftArray[tap.view.tag][@"id"]];
}

-(void)middleClick:(UITapGestureRecognizer *)tap{
    
//    [[NSNotificationCenter defaultCenter]postNotificationName:@"THREE" object:leftArray[tap.view.tag][@"id"]];
}

-(void)rightClick:(UITapGestureRecognizer *)tap{
    
//    [[NSNotificationCenter defaultCenter]postNotificationName:@"THREE" object:leftArray[tap.view.tag][@"id"]];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 190;
}

@end
