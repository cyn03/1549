//
//  MineViewController.m
//  HeartPro
//
//  Created by qianfeng on 15/11/14.
//  Copyright (c) 2015年 xiaoxiao. All rights reserved.
//

#import "MineViewController.h"
#import "MineShowViewController.h"
#import "SDImageCache.h"
#import "MineTableViewCell.h"
@interface MineViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_TableView;
    UIImageView *imageView;
}
@end

@implementation MineViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.tabBarController.tabBar.hidden = NO;
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets=NO;
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    self.title = @"我的";
    
    [self createtableview];
    
    imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SWIDTH, 250)];
    imageView.image = [UIImage imageNamed:@"屏幕快照 2015-11-19 下午8.38.34"];
    [self.view addSubview:imageView];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat y = scrollView.contentOffset.y;
   if (y<-250) {
        imageView.frame = CGRectMake((y+250)/2, 0, SWIDTH-(y+250), -y);
   }
   else{
        imageView.frame = CGRectMake(0, 0, SWIDTH, -y);
    }
}

-(void)createtableview{
    _TableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SWIDTH, HEIGHT) style:UITableViewStylePlain];
    _TableView.contentInset = UIEdgeInsetsMake(250, 0, 0, 0);
    _TableView.delegate = self;
    _TableView.dataSource = self;
    [self.view addSubview:_TableView];
    
    [self hideMoreLine];
}

-(void)hideMoreLine{
    
    UIView * view = [[UIView alloc]initWithFrame:CGRectZero];
    
    _TableView.tableFooterView = view;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MineTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ID"];
    
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"MineTableViewCell" owner:self options:nil]firstObject];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSArray *arr= @[@"我的收藏",@"附近",@"清除缓存"];
    NSArray *arrt = @[@"my_collectpng",@"ditu",@"clean"];
    
    cell.wodeLabel.text = arr[indexPath.row];
    cell.tubiaoImage.image = [UIImage imageNamed:arrt[indexPath.row]];
 
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 2) {
        [[SDImageCache sharedImageCache] cleanDisk];
        UIAlertView * al = [[UIAlertView alloc]initWithTitle:@"提示" message:@"清理缓存成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [al show];
    }else{
        MineShowViewController *mine = [[MineShowViewController alloc]init];
        
        mine.k = indexPath.row;
        
        [self.navigationController pushViewController:mine animated:YES];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}


@end
