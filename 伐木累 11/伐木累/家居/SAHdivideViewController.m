//
//  SAHdivideViewController.m
//  HeartPro
//
//  Created by qianfeng on 15/11/7.
//  Copyright (c) 2015年 xiaoxiao. All rights reserved.
//

#import "SAHdivideViewController.h"
#import "SAHdivideTableViewCell.h"
#import "DetailViewController.h"
@interface SAHdivideViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *imageArray;
    UITableView *_tableView;
    NSMutableArray *_dataArray;
    int _offset;
}
@property(nonatomic,strong)MYHeaderView *header;
@end

@implementation SAHdivideViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    if (![self.special isEqualToString:@"special"]) {
        _tableView.tableHeaderView = self.header;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _offset = 0;
    _dataArray = [[NSMutableArray alloc]init];
    
    if ([self.special isEqualToString:@"special"]) {
        [self createSpecialData];
    }
    else if ([self.special isEqualToString:@"place"]){
        [self createPlaceData];
    }
    else{
        [self createOwnerData];
    }
    [self createAdvertisementData];
    
    [self creatTableView];
    self.title = self.Specialtitle;
}

-(void)creatRefresh{
    
    [_tableView addFooterWithTarget:self action:@selector(add)];
}

-(void)add{
    
    _offset = (int)_dataArray.count;
    _offset += 20;
    [self createOwnerData];
    [_tableView footerEndRefreshing];
}

-(MYHeaderView *)header{
    
    if (!_header) {
        _header = [MYHeaderView HeaderView];
    }
    return _header;
}

-(void)createAdvertisementData{
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"加载中...";
    [hud show:YES];
    
    imageArray = [[NSMutableArray alloc]init];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:URL_Advertisement parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        
        NSDictionary *Dic = dict[@"data"];
        
        for (NSDictionary *dic in Dic[@"banners"]) {
            
            [imageArray addObject:dic[@"image_url"]];
        }
        [hud hide:YES];
        self.header.images = imageArray;
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

-(void)createOwnerData{
    
    MBProgressHUD *hud = [[MBProgressHUD alloc]initWithView:self.view];
    hud.labelText = @"加载中...";
    [self.view addSubview:hud];
    [hud show:YES];
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:[NSString stringWithFormat:URL_Head,_offset] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
       
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        
        NSDictionary *Dic = dict[@"data"];
        
        for (NSDictionary *dic in Dic[@"items"]) {
            
            [_dataArray addObject:dic];
        }
        
        [hud hide:YES];
        
        [self performSelectorOnMainThread:@selector(refresh) withObject:nil waitUntilDone:YES];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

-(void)refresh{
    [self creatRefresh];
    [_tableView reloadData];
}

-(void)createSpecialData{
    
    MBProgressHUD *hud = [[MBProgressHUD alloc]initWithView:self.view];
    hud.labelText = @"加载中...";
    [self.view addSubview:hud];
    [hud show:YES];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:[NSString stringWithFormat:URL_Special,self.k,_offset] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [hud hide:YES];
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        
        NSDictionary *Dic = dict[@"data"];
        
        for (NSDictionary *dic in Dic[@"posts"]) {
            
            [_dataArray addObject:dic];
        }
        [self performSelectorOnMainThread:@selector(refreshSpecial) withObject:nil waitUntilDone:YES];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

-(void)refreshSpecial{
    [_tableView reloadData];
}

-(void)createPlaceData{
    
    MBProgressHUD *hud = [[MBProgressHUD alloc]initWithView:self.view];
    hud.labelText = @"加载中...";
    [self.view addSubview:hud];
    [hud show:YES];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:[NSString stringWithFormat:URL_Placeurl,self.p,_offset] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [hud hide:YES];
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        
        NSDictionary *Dic = dict[@"data"];
        
        for (NSDictionary *dic in Dic[@"items"]) {
            
            [_dataArray addObject:dic];
        }
        [self performSelectorOnMainThread:@selector(refreshPlace) withObject:nil waitUntilDone:YES];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

-(void)refreshPlace{
    [_tableView reloadData];
}

-(void)creatTableView{
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SWIDTH, HEIGHT-105) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellAccessoryNone;
    [self.view addSubview:_tableView];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SAHdivideTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ID"];
    
    if (!cell) {
        cell = [[SAHdivideTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ID"];
    }
    NSDictionary *dict = _dataArray[indexPath.row];
    
    [cell.Image sd_setImageWithURL:[NSURL URLWithString:dict[@"cover_image_url"]] placeholderImage:[UIImage imageNamed:@"default_pic_big"]];
    cell.titleLabel.text = dict[@"title"];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 8;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 208;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DetailViewController *detail = [[DetailViewController alloc]init];
    
    detail.url = _dataArray[indexPath.row][@"id"];
    
    [self.navigationController pushViewController:detail animated:YES];
}


@end
