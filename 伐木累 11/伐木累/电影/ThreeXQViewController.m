//
//  ThreeXQViewController.m
//  伐木累
//
//  Created by qianfeng on 15/11/14.
//  Copyright (c) 2015年 xiaoxiao. All rights reserved.
//

#import "ThreeXQViewController.h"
#import "OneXQTCell.h"
#import "CastsCell.h"
#import "CommentCell.h"
#import "OneDisplayViewController.h"
@interface ThreeXQViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *_dataArray;
    NSDictionary *_dic;
}

@end

@implementation ThreeXQViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    _dataArray = [[NSMutableArray alloc]init];
    self.tv.separatorStyle = UITableViewCellAccessoryNone;
    
    [self createData];
    
    [self createNavBtn];
}

-(void)createNavBtn{
    
    UIButton * collect = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, 30)];
    [collect setTitle:@"收藏" forState:UIControlStateNormal];
//    [button setImage:<#(UIImage *)#> forState:UIControlStateNormal];
    [collect addTarget:self action:@selector(collectClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *collectItem = [[UIBarButtonItem alloc]initWithCustomView:collect];
    
    UIButton * share = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, 30)];
    [share setTitle:@"分享" forState:UIControlStateNormal];
    //    [button setImage:<#(UIImage *)#> forState:UIControlStateNormal];
    [share addTarget:self action:@selector(shareClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *shareItem = [[UIBarButtonItem alloc]initWithCustomView:share];
    self.navigationItem.rightBarButtonItems = @[shareItem,collectItem];
}

-(void)collectClick{
    
    
}

-(void)shareClick{
    
    
}

-(void)createData{
    
    MBProgressHUD *hud = [[MBProgressHUD alloc]initWithView:self.view];
    hud.labelText = @"加载中...";
    [self.view addSubview:hud];
    [hud show:YES];
    
    NSString *url = [NSString stringWithFormat:SHOWING_DETAIL_FRONT_URL,self.str];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:[NSString stringWithFormat:@"%@%@",url,SHOWING_DETAIL_BEHIND_URL] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        _dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        if ([_dic[@"directors"]count]>0) {
            [_dataArray addObject:_dic[@"directors"][0]];
        }
        
        for (int i = 0; i < [_dic[@"casts"]count]; i ++) {
            [_dataArray addObject:_dic[@"casts"][i]];
        }
        
        [hud hide:YES];
        [self.tv reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else if(section == 1){
        return [_dic[@"casts"]count]+1;
    }else{
        return 1;
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        OneXQTCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (!cell) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"OneXQCell" owner:self options:nil]firstObject];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [cell.Image sd_setImageWithURL:[NSURL URLWithString:_dic[@"images"][@"medium"]] placeholderImage:[UIImage imageNamed:@"default_pic_big"]];
        cell.TitleLabel.text = _dic[@"title"];
        if ([_dic[@"writers"]count]>0) {
            NSArray *arr = _dic[@"writers"];
            NSMutableString *strName = [[NSMutableString alloc]init];
            for (int i = 0; i < arr.count; i ++) {
                [strName appendString:arr[i][@"name"]];
                if (i == arr.count-1) {
                    continue;
                }
                [strName appendString:@"/"];
            }
            if ([_dic[@"directors"]count]>0) {
                cell.Label1.text = [NSString stringWithFormat:@"导演: %@",_dic[@"directors"][0][@"name"]];
                cell.Label2.text = [NSString stringWithFormat:@"编剧: %@",strName];
            }
        }
        
        if ([_dic[@"casts"]count]>0) {
            NSArray *arr3 = _dic[@"casts"];
            NSMutableString *strName3 = [[NSMutableString alloc]init];
            for (int i = 0; i < arr3.count; i ++) {
                [strName3 appendString:arr3[i][@"name"]];
                if (i == arr3.count-1) {
                    continue;
                }
                [strName3 appendString:@"/"];
            }
            cell.Label3.text = [NSString stringWithFormat:@"主演: %@",strName3];
        }
        
        if ([_dic[@"genres"]count]>0) {
            NSArray *arr4 = _dic[@"genres"];
            NSMutableString *strName4 = [[NSMutableString alloc]init];
            for (int i = 0; i < arr4.count; i ++) {
                [strName4 appendString:arr4[i]];
                if (i == arr4.count-1) {
                    continue;
                }
                [strName4 appendString:@"/"];
            }
            cell.Label4.text = [NSString stringWithFormat:@"类型: %@",strName4];
        }
        
        if ([_dic[@"countries"]count]>0) {
            NSArray *arr5 = _dic[@"countries"];
            NSMutableString *strName5 = [[NSMutableString alloc]init];
            for (int i = 0; i < arr5.count; i ++) {
                [strName5 appendString:arr5[i]];
                if (i == arr5.count-1) {
                    continue;
                }
                [strName5 appendString:@"/"];
            }
            cell.Label5.text = [NSString stringWithFormat:@"制片国家/地区: %@",strName5];
        }
        
        if ([_dic[@"languages"]count]>0) {
            cell.Label6.text = [NSString stringWithFormat:@"语言: %@",_dic[@"languages"][0]];
        }
        
        if ([_dic[@"pubdates"]count]>0) {
            cell.Label7.text = [NSString stringWithFormat:@"上映时间: %@",_dic[@"pubdates"][0]];
        }
        
        if ([_dic[@"durations"]count]!=0) {
            cell.Label8.text = [NSString stringWithFormat:@"片长: %@",_dic[@"durations"][0]];
        }else{
            cell.Label8.text = [NSString stringWithFormat:@"片长: nil"];
        }
        
        
        NSArray *arr9 = _dic[@"aka"];
        NSMutableString *strName9 = [[NSMutableString alloc]init];
        for (int i = 0; i < arr9.count; i ++) {
            [strName9 appendString:arr9[i]];
            if (i == arr9.count-1) {
                continue;
            }
            [strName9 appendString:@"/"];
        }
        cell.Label9.text = [NSString stringWithFormat:@"又名: %@",strName9];
        
        cell.xqLabel.text = [NSString stringWithFormat:@"       %@",_dic[@"summary"]];
        
        NSArray *photos = _dic[@"photos"];
        for (int i = 0; i < photos.count; i ++) {
            
            UIImageView * image = [[UIImageView alloc]initWithFrame:CGRectMake(((SWIDTH-2)/4+2)*i+2, 0, (SWIDTH-2)/4, CGRectGetHeight(cell.sc.frame))];
            [image sd_setImageWithURL:[NSURL URLWithString:photos[i][@"cover"]] placeholderImage:[UIImage imageNamed:@"default_pic_big"]];
            image.userInteractionEnabled = YES;
            image.tag = 200+i;
            [cell.sc addSubview:image];
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ClickTp:)];
            [image addGestureRecognizer:tap];
        }
        cell.sc.showsHorizontalScrollIndicator = NO;
        cell.sc.contentSize = CGSizeMake(((SWIDTH-2)/4+2)*photos.count+2, 0);
        
        
        
        UITapGestureRecognizer *Movietap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ClickPlayer)];
        cell.PlayerImage.userInteractionEnabled = YES;
        [cell.PlayerImage addGestureRecognizer:Movietap];
        
        
        return cell;
        
    }else if(indexPath.section == 1){
        CastsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CastsCell"];
        if (!cell) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"CastsCell" owner:self options:nil]firstObject];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        NSMutableArray *arr = _dic[@"casts"];
        
        if (arr.count>0) {
            
            if (indexPath.row == 0) {
                
                if ([_dic[@"directors"]count]>0) {
                    if (_dic[@"directors"][0][@"avatars"] != nil) {
                        
                        [cell.castsImage sd_setImageWithURL:[NSURL URLWithString:_dic[@"directors"][0][@"avatars"][@"medium"]] placeholderImage:[UIImage imageNamed:@"default_pic_big"]];
                        cell.Name1Label.text = _dic[@"directors"][0][@"name"];
                        cell.Name2Label.text = _dic[@"directors"][0][@"name_en"];
                    }
                }
            }else{
                if ([_dic[@"directors"]count]>0) {
                    if (_dic[@"directors"][0][@"avatars"] != nil) {
                        [cell.castsImage sd_setImageWithURL:[NSURL URLWithString:arr[indexPath.row-1][@"avatars"][@"medium"]] placeholderImage:[UIImage imageNamed:@"default_pic_big"]];
                        cell.Name1Label.text = arr[indexPath.row-1][@"name"];
                        cell.Name2Label.text = arr[indexPath.row-1][@"name_en"];
                    }
                }
            }
        }
        
        return cell;
        
    }else{
        CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CommentCell"];
        if (!cell) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"CommentCell" owner:self options:nil]firstObject];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        NSArray *arr = _dic[@"popular_reviews"];
        
        if (arr.count>0) {
            
            [cell.userImage sd_setImageWithURL:[NSURL URLWithString:arr[0][@"author"][@"avatar"]] placeholderImage:[UIImage imageNamed:@"default_pic_big"]];
            cell.userLabel.text = arr[0][@"author"][@"name"];
            cell.commentLabel.text = [NSString stringWithFormat:@"       %@",arr[0][@"summary"]];
        }
        
        [cell.MoreBtn addTarget:self action:@selector(ClcikMore) forControlEvents:UIControlEventTouchUpInside];
        
        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 450;
    }else if(indexPath.section == 1){
        return 120;
    }else{
        return 205;
    }
}

-(void)ClickPlayer{
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"很抱歉，此电影不可观看" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
}

-(void)ClickTp:(UITapGestureRecognizer *)tap{
    
    OneDisplayViewController *oneDisplay = [[OneDisplayViewController alloc]init];
    
    oneDisplay.photosArray = _dic[@"photos"];
    oneDisplay.zsStr = @"TP";
    oneDisplay.k = tap.view.tag-200;
    
    [self.navigationController pushViewController:oneDisplay animated:YES];
}

-(void)ClcikMore{
    
    OneDisplayViewController *oneDisplay = [[OneDisplayViewController alloc]init];
    
    oneDisplay.zsStr = @"Pinglun";
    oneDisplay.commentArray = _dic[@"popular_reviews"];
    
    [self.navigationController pushViewController:oneDisplay animated:YES];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 1) {
        
        OneDisplayViewController *oneDisplay = [[OneDisplayViewController alloc]init];
        
        oneDisplay.zsStr = [NSString stringWithFormat:@"%@",_dataArray[indexPath.row][@"id"]];
        
        [self.navigationController pushViewController:oneDisplay animated:YES];
    }
}

@end
