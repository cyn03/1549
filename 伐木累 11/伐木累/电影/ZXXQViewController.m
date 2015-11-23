//
//  ZXXQViewController.m
//  伐木累
//
//  Created by qianfeng on 15/11/14.
//  Copyright (c) 2015年 xiaoxiao. All rights reserved.
//

#import "ZXXQViewController.h"
#import "ShowZXXQCell.h"
#import "TOPCell.h"
@interface ZXXQViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSDictionary *_dic;
}
@end

@implementation ZXXQViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    
    [self setData];
}

-(void)setData{
    
    MBProgressHUD *hud = [[MBProgressHUD alloc]initWithView:self.view];
    hud.labelText = @"加载中...";
    [self.view addSubview:hud];
    [hud show:YES];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:[NSString stringWithFormat:ZXPJ_URL,self.str] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        _dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        
        [hud hide:YES];
        [self.tv reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_dic[@"movies"]count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        
        TOPCell * cell = [tableView dequeueReusableCellWithIdentifier:@"TOPCell"];
        
        if (!cell) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"TOPCell" owner:self options:nil] firstObject];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.TopTitleLabel.text = _dic[@"topList"][@"name"];
        cell.TopTitle2Label.text = _dic[@"topList"][@"summary"];
        [cell.TopImage sd_setImageWithURL:[NSURL URLWithString:_dic[@"movies"][indexPath.row][@"posterUrl"]] placeholderImage:[UIImage imageNamed:@"default_pic_big"]];
        cell.TopLabel1.text = _dic[@"movies"][indexPath.row][@"name"];
        cell.TopLabel2.text = _dic[@"movies"][indexPath.row][@"nameEn"];
        cell.TopLabel3.text = _dic[@"movies"][indexPath.row][@"director"];
        cell.TopLabel4.text = _dic[@"movies"][indexPath.row][@"actor"];
        cell.TopLabel5.text = [NSString stringWithFormat:@"%@   %@",_dic[@"movies"][indexPath.row][@"releaseDate"],_dic[@"movies"][indexPath.row][@"releaseLocation"]];
        
        return cell;
        
    }else{
        ShowZXXQCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ShowZXXQCell"];
        
        if (!cell) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"ShowZXXQCell" owner:self options:nil] firstObject];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [cell.movieImage sd_setImageWithURL:[NSURL URLWithString:_dic[@"movies"][indexPath.row][@"posterUrl"]] placeholderImage:[UIImage imageNamed:@"default_pic_big"]];
        cell.zxxqLabel1.text = _dic[@"movies"][indexPath.row][@"name"];
        cell.zxxqLabel2.text = _dic[@"movies"][indexPath.row][@"nameEn"];
        cell.zxxqLabel3.text = _dic[@"movies"][indexPath.row][@"director"];
        cell.zxxqLabel4.text = _dic[@"movies"][indexPath.row][@"actor"];
        cell.zxxqLabel5.text = [NSString stringWithFormat:@"%@   %@",_dic[@"movies"][indexPath.row][@"releaseDate"],_dic[@"movies"][indexPath.row][@"releaseLocation"]];
        
        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 228;
    }else{
        return 160;
    }
}

@end
