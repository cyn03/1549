//
//  OneDisplayViewController.m
//  HeartPro
//
//  Created by qianfeng on 15/11/14.
//  Copyright (c) 2015年 xiaoxiao. All rights reserved.
//

#import "OneDisplayViewController.h"
#import "ShowCommentCell.h"
@interface OneDisplayViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
}
@end

@implementation OneDisplayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    if([self.zsStr isEqualToString:@"TP"]){
        [self ShowPhotos];
    }else if([self.zsStr isEqualToString:@"Pinglun"]){
        [_tableView reloadData];
        [self createTableView];
    }else{
        [self ShowWebView];
    }
    
}

//演员信息
-(void)ShowWebView{
    
    NSString *url = [NSString stringWithFormat:ACTOR_URL,self.zsStr];
    
    UIWebView *web = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, SWIDTH, HEIGHT)];
    web.scalesPageToFit = YES;
    [web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
    [self.view addSubview:web];
}

//图片展示
-(void)ShowPhotos{
    
    UIScrollView *sc = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SWIDTH, HEIGHT)];
    [self.view addSubview:sc];
    
    for (int i = 0; i < self.photosArray.count; i ++) {

        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(SWIDTH*i, 0, SWIDTH, HEIGHT)];
        [imageView sd_setImageWithURL:[NSURL URLWithString:self.photosArray[i][@"cover"]] placeholderImage:[UIImage imageNamed:@"default_pic_big"]];
        [sc addSubview:imageView];
    }
    sc.pagingEnabled = YES;
    sc.contentSize = CGSizeMake(SWIDTH*self.photosArray.count, 0);
    [sc setContentOffset:CGPointMake(SWIDTH*self.k, 0) animated:YES];
}

//创建TableView
-(void)createTableView{
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SWIDTH, HEIGHT)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.commentArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ShowCommentCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ShowCommentCell"];
    
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"ShowCommentCell" owner:self options:nil]firstObject];
    }
    
    [cell.UserImage sd_setImageWithURL:[NSURL URLWithString:self.commentArray[indexPath.row][@"author"][@"avatar"]] placeholderImage:[UIImage imageNamed:@"default_pic_big"]];
    cell.UserLabel.text = self.commentArray[indexPath.row][@"author"][@"name"];
    cell.CommLabel.text = [NSString stringWithFormat:@"       %@",self.commentArray[indexPath.row][@"summary"]];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    //动态获得字符串的高度
    NSDictionary *dict = self.commentArray[indexPath.row];
    NSString *strContent = dict[@"summary"];
    
    float height = [strContent boundingRectWithSize:CGSizeMake(SWIDTH-20, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size.height;
    
    return height+60;
}

@end
