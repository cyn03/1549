
//  SAHViewController.m
//  HeartPro
//
//  Created by qianfeng on 15/11/7.
//  Copyright (c) 2015年 xiaoxiao. All rights reserved.
//

#import "SAHViewController.h"
#import "SAHdivideViewController.h"
#import "SAHTableViewCell.h"
#import "SAHSVTableViewCell.h"
#import "SAHModel.h"
@interface SAHViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
    NSMutableArray *_SAHSVArray;
    NSMutableArray *_PlaceIconArray;
    NSMutableArray *_PlaceNameArray;
}
@end

@implementation SAHViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"家居";
    self.automaticallyAdjustsScrollViewInsets=NO;
    self.navigationController.navigationBar.barStyle=UIBarStyleBlack;
    _SAHSVArray = [[NSMutableArray alloc]init];
    _PlaceIconArray = [[NSMutableArray alloc]init];
    _PlaceNameArray = [[NSMutableArray alloc]init];
    [self createSVData];
    [self createPlaceData];
    [self createTableVlew];
    [self prepareTotoRefinedControllerNotification];
}

//通过通知中心，监听是否要跳转到视频页面
-(void)prepareTotoRefinedControllerNotification{
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(toRefined:) name:@"refined" object:nil];
}

-(void)toRefined:(NSNotification *)n{
    
    SAHdivideViewController *sah = [[SAHdivideViewController alloc]init];
    
    sah.Specialtitle = @"精选";
    
    [self.navigationController pushViewController:sah animated:YES];
}

-(void)createSVData{
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"加载中...";
    [hud show:YES];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:URL_SVClose parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *rootDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        
        NSDictionary *dict = rootDic[@"data"];
        
        for (NSDictionary *dic in dict[@"collections"]) {
            
            SAHModel *model = [[SAHModel alloc]init];
            model.title = dic[@"title"];
            model.cover_image_url = dic[@"cover_image_url"];
            
            [_SAHSVArray addObject:model];
        }
        [hud hide:YES];
        [_tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

-(void)createPlaceData{
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"加载中...";
    [hud show:YES];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:URL_Place parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *rootDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        
        NSDictionary *dict = rootDic[@"data"];
        
        for (NSDictionary *dic in [dict[@"channel_groups"]firstObject][@"channels"]) {
            
            [_PlaceNameArray addObject:dic[@"name"]];
            [_PlaceIconArray addObject:dic[@"icon_url"]];
            
        }
        [hud hide:YES];
        [_tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

-(void)createTableVlew{
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SWIDTH, HEIGHT-64-49) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.separatorStyle = UITableViewCellAccessoryNone;
    [self.view addSubview:_tableView];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        SAHSVTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SVcell"];
        cell.selectionStyle = UITableViewCellAccessoryNone;
        if (!cell) {
            cell = [[SAHSVTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SVcell"];
        }
        
        for (UIView *view in cell.contentView.subviews) {
            [view removeFromSuperview];
        }
        
        cell.SVArray = _SAHSVArray;
        
        [cell createCell];
        
        cell.Block = ^(int block){
            
            SAHdivideViewController *sah = [[SAHdivideViewController alloc]init];
            
            sah.k = block;
            sah.special = @"special";
            sah.Specialtitle = @"详情";
            
            [self.navigationController pushViewController:sah animated:YES];
        };
        
        return cell;
    }
    else{
        SAHTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SAHcell"];
        cell.selectionStyle = UITableViewCellAccessoryNone;
        if (!cell) {
            cell = [[SAHTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SAHcell"];
        }
        for (int i = 0; i < _PlaceIconArray.count; i ++) {
            
            [cell.kitchenImage sd_setImageWithURL:[NSURL URLWithString:_PlaceIconArray[0]] placeholderImage:[UIImage imageNamed:@"default_pic_big"]];
            cell.kitchenLb.text = _PlaceNameArray[0];
            
            [cell.bedroomImage sd_setImageWithURL:[NSURL URLWithString:_PlaceIconArray[1]] placeholderImage:[UIImage imageNamed:@"default_pic_big"]];
            cell.bedroomLb.text = _PlaceNameArray[1];
            
            [cell.sanitationImage sd_setImageWithURL:[NSURL URLWithString:_PlaceIconArray[2]] placeholderImage:[UIImage imageNamed:@"default_pic_big"]];
            cell.sanitationLb.text = _PlaceNameArray[2];
            
            [cell.LVImage sd_setImageWithURL:[NSURL URLWithString:_PlaceIconArray[3]] placeholderImage:[UIImage imageNamed:@"default_pic_big"]];
            cell.LVLb.text = _PlaceNameArray[3];
            
            [cell.studyImage sd_setImageWithURL:[NSURL URLWithString:_PlaceIconArray[4]] placeholderImage:[UIImage imageNamed:@"default_pic_big"]];
            cell.studyLb.text = _PlaceNameArray[4];
        }
        
        [cell createCell];
        
        cell.KitchenBlock = ^(int KitchenBlock){
            SAHdivideViewController *sah = [[SAHdivideViewController alloc]init];
            
            sah.p = KitchenBlock;
            sah.special = @"place";
            sah.Specialtitle = _PlaceNameArray[KitchenBlock-12];

            [self.navigationController pushViewController:sah animated:YES];
        };
        
        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        return 150;
    }else{
        return 450;
    }
}




@end
