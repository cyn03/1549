//
//  OneXQViewController.m
//  HeartPro
//
//  Created by qianfeng on 15/11/13.
//  Copyright (c) 2015年 xiaoxiao. All rights reserved.
//

#import "OneXQViewController.h"
#import "OneXQTCell.h"
#import "CastsCell.h"
#import "CommentCell.h"
#import "OneDisplayViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import "MYButton.h"
#import "UMSocialQQHandler.h"
@interface OneXQViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    //声明视频播放器
    MPMoviePlayerViewController *_movieController;
    //声明加载控件
    UIActivityIndicatorView *_act;
    NSMutableArray *_dataArray;
    NSDictionary *_dic;
    UIButton * collect;
    UIButton * share;
    UIButton *but;
    UIView *view;
    UIView * sharesView;
    BOOL isNot;
}
@end

@implementation OneXQViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    isNot = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    _dataArray = [[NSMutableArray alloc]init];
    self.tv.separatorStyle = UITableViewCellAccessoryNone;
    
    [self createData];
    [self createNavBtn];
    self.navigationItem.backBarButtonItem.style = UIBarStyleDefault;
    
    
}

-(void)createNavBtn{
    
    collect = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 25, 25)];
    [collect addTarget:self action:@selector(collectsClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *collectItem = [[UIBarButtonItem alloc]initWithCustomView:collect];
    
    share = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 25, 25)];
    [share setImage:[UIImage imageNamed:@"share"] forState:UIControlStateNormal];
    [share addTarget:self action:@selector(sharesClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *shareItem = [[UIBarButtonItem alloc]initWithCustomView:share];
    self.navigationItem.rightBarButtonItems = @[shareItem,collectItem];
}

-(void)collectsClick{
    
    collect.userInteractionEnabled = NO;
    share.userInteractionEnabled = NO;
    if ([[MYDataBaseManager sharedManager]isCollectionedWithID:_dic[@"id"]]) {
        [collect setImage:[UIImage imageNamed:@"fav"] forState:UIControlStateNormal];
        [[MYDataBaseManager sharedManager]deleteDic:_dic[@"id"]];
        
        view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SWIDTH, HEIGHT)];
        view.backgroundColor = [UIColor grayColor];
        view.alpha = 0.6;
        [self.view addSubview:view];
        
        [UIView animateWithDuration:2 animations:^{
            
            but = [[UIButton alloc]initWithFrame:CGRectMake((SWIDTH-200)/2, (HEIGHT-60)/2, 200/375.f*SWIDTH, 60)];
            [but setTitle:@"已取消收藏" forState:UIControlStateNormal];
            but.backgroundColor = [UIColor orangeColor];
            but.layer.masksToBounds = YES;
            but.layer.cornerRadius = 10;
            [self.view addSubview:but];
 
            [UIView setAnimationDelegate:self];
            [UIView setAnimationDidStopSelector:@selector(Danhua)];
        }];
    }else{
        [collect setImage:[UIImage imageNamed:@"fav2"] forState:UIControlStateNormal];
        [[MYDataBaseManager sharedManager]addDic:_dic];
        
        view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SWIDTH, HEIGHT)];
        view.backgroundColor = [UIColor grayColor];
        view.alpha = 0.6;
        [self.view addSubview:view];
        
        [UIView animateWithDuration:2 animations:^{
           
            but = [[UIButton alloc]initWithFrame:CGRectMake((SWIDTH-200)/2, (HEIGHT-60)/2, 200/375.f*SWIDTH, 60)];
            [but setTitle:@"收藏成功" forState:UIControlStateNormal];
            but.layer.masksToBounds = YES;
            but.layer.cornerRadius = 10;
            but.backgroundColor = [UIColor orangeColor];
            [self.view addSubview:but];
            
            [UIView setAnimationDelegate:self];
            [UIView setAnimationDidStopSelector:@selector(Danhua)];
        }];
    }
}

-(void)Danhua{
    
    collect.userInteractionEnabled = YES;
    share.userInteractionEnabled = YES;
    [UIView animateWithDuration:1 animations:^{
        
        [but removeFromSuperview];
        [view removeFromSuperview];
    }];
}

-(void)sharesClick{
    
    share.userInteractionEnabled = NO;
    collect.userInteractionEnabled = NO;
    sharesView = [[UIView alloc]initWithFrame:CGRectMake(0, HEIGHT, SWIDTH, 150/375.f*SWIDTH)];
    sharesView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:sharesView];
    
    //添加分享按钮
    [sharesView addSubview:[MYButton buttonWithFrame:CGRectMake(10, (150-80)/3/375.f*SWIDTH, (SWIDTH-40)/3, 40) title:@"腾讯微博" backgroundImage:nil clickCallBack:^(MYButton *button) {
        
        [[UMSocialDataService defaultDataService]postSNSWithTypes:@[UMShareToTencent] content:_dic[@"title"] image:[UIImage imageNamed:@"a"] location:nil urlResource:nil presentedController:self completion:^(UMSocialResponseEntity *response) {
            NSLog(@"分享成功");
        }];
    }]];
    
    //添加人人网分享
    [sharesView addSubview:[MYButton buttonWithFrame:CGRectMake((SWIDTH-40)/3+20, (150-80)/3/375.f*SWIDTH, (SWIDTH-40)/3, 40) title:@"人人网" backgroundImage:nil clickCallBack:^(MYButton *button) {
        
        [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToRenren] content:_dic[@"title"] image:nil location:nil urlResource:nil presentedController:self completion:^(UMSocialResponseEntity *response){
            if (response.responseCode == UMSResponseCodeSuccess) {
                NSLog(@"分享成功！");
            }
        }];
    }]];
    
    //添加新浪微博分享
    [sharesView addSubview:[MYButton buttonWithFrame:CGRectMake((SWIDTH-40)/3*2+30, (150-80)/3/375.f*SWIDTH, (SWIDTH-40)/3, 40) title:@"新浪微博" backgroundImage:nil clickCallBack:^(MYButton *button) {
        
        [[UMSocialDataService defaultDataService]postSNSWithTypes:@[UMShareToSina] content:_dic[@"title"] image:[UIImage imageNamed:@"a"] location:nil urlResource:nil presentedController:self completion:^(UMSocialResponseEntity *response) {
            NSLog(@"分享成功");
        }];
    }]];
    
    //添加QQ分享
    [sharesView addSubview:[MYButton buttonWithFrame:CGRectMake(10, ((150-80)/3*2+40)/375.f*SWIDTH, (SWIDTH-40)/3, 40) title:@"QQ" backgroundImage:nil clickCallBack:^(MYButton *button) {
        
        UMSocialUrlResource *urlResource = [[UMSocialUrlResource alloc] initWithSnsResourceType:UMSocialUrlResourceTypeImage url:
                                            _dic[@"images"][@"medium"]];
        [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToQQ] content:_dic[@"title"] image:nil location:nil urlResource:urlResource presentedController:self completion:^(UMSocialResponseEntity *response){
            if (response.responseCode == UMSResponseCodeSuccess) {
                NSLog(@"分享成功！");
            }
        }];
    }]];
    
    //添加QQ空间分享
    [sharesView addSubview:[MYButton buttonWithFrame:CGRectMake((SWIDTH-40)/3+20, ((150-80)/3*2+40)/375.f*SWIDTH, (SWIDTH-40)/3, 40) title:@"QQ空间" backgroundImage:nil clickCallBack:^(MYButton *button) {
        
        UMSocialUrlResource *urlResource = [[UMSocialUrlResource alloc] initWithSnsResourceType:UMSocialUrlResourceTypeImage url:
                                            _dic[@"images"][@"medium"]];
        [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToQzone] content:_dic[@"title"] image:nil location:nil urlResource:urlResource presentedController:self completion:^(UMSocialResponseEntity *response){
            if (response.responseCode == UMSResponseCodeSuccess) {
                NSLog(@"分享成功！");
            }
        }];
    }]];
    
    view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SWIDTH, HEIGHT)];
    view.backgroundColor = [UIColor grayColor];
    view.alpha = 0.6;
    [self.view addSubview:view];
    
    [UIView animateWithDuration:0.4 animations:^{
        
        sharesView.frame =CGRectMake(0, HEIGHT-150/375.f*SWIDTH, SWIDTH, 150/375.f*SWIDTH);
        view.frame = CGRectMake(0, 0, SWIDTH, HEIGHT-150/375.f*SWIDTH);
    }];
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    share.userInteractionEnabled = YES;
    collect.userInteractionEnabled = YES;
    [UIView animateWithDuration:0.3 animations:^{
        [view removeFromSuperview];
        sharesView.frame =CGRectMake(0, HEIGHT, SWIDTH, 150/375.f*SWIDTH);
    }];
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
        
        [_dataArray addObject:_dic[@"directors"][0]];
        for (int i = 0; i < [_dic[@"casts"]count]; i ++) {
            [_dataArray addObject:_dic[@"casts"][i]];
        }
        [UMSocialQQHandler setQQWithAppId:@"100424468" appKey:@"564ec06d67e58ecccf002caf" url:_dic[@"share_url"]];
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
        
        if ([[MYDataBaseManager sharedManager]isCollectionedWithID:_dic[@"id"]]) {
            [collect setImage:[UIImage imageNamed:@"fav2"] forState:UIControlStateNormal];
        }else{
            [collect setImage:[UIImage imageNamed:@"fav"] forState:UIControlStateNormal];
        }
        
        [cell.Image sd_setImageWithURL:[NSURL URLWithString:_dic[@"images"][@"medium"]] placeholderImage:[UIImage imageNamed:@"default_pic_big"]];
        cell.TitleLabel.text = _dic[@"title"];
        NSArray *arr = _dic[@"writers"];
        NSMutableString *strName = [[NSMutableString alloc]init];
        for (int i = 0; i < arr.count; i ++) {
            [strName appendString:arr[i][@"name"]];
            if (i == arr.count-1) {
                continue;
            }
            [strName appendString:@"/"];
        }
        cell.Label1.text = [NSString stringWithFormat:@"导演: %@",_dic[@"directors"][0][@"name"]];
        cell.Label2.text = [NSString stringWithFormat:@"编剧: %@",strName];
        
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
        
        cell.Label6.text = [NSString stringWithFormat:@"语言: %@",_dic[@"languages"][0]];
        
        cell.Label7.text = [NSString stringWithFormat:@"上映时间: %@",_dic[@"pubdates"][0]];
        
        cell.Label8.text = [NSString stringWithFormat:@"片长: %@",_dic[@"durations"][0]];
        
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
        cell.xqLabel.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapxq = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(xqClick)];
        [cell.contentView addGestureRecognizer:tapxq];
        
        
        
        
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

        if (indexPath.row == 0) {
            [cell.castsImage sd_setImageWithURL:[NSURL URLWithString:_dic[@"directors"][0][@"avatars"][@"medium"]] placeholderImage:[UIImage imageNamed:@"default_pic_big"]];
            cell.Name1Label.text = _dic[@"directors"][0][@"name"];
            cell.Name2Label.text = _dic[@"directors"][0][@"name_en"];
        }else{
            [cell.castsImage sd_setImageWithURL:[NSURL URLWithString:arr[indexPath.row-1][@"avatars"][@"medium"]] placeholderImage:[UIImage imageNamed:@"default_pic_big"]];
            cell.Name1Label.text = arr[indexPath.row-1][@"name"];
            cell.Name2Label.text = arr[indexPath.row-1][@"name_en"];
        }
        return cell;
        
    }else{
        CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CommentCell"];
        if (!cell) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"CommentCell" owner:self options:nil]firstObject];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        NSArray *arr = _dic[@"popular_reviews"];
        
        [cell.userImage sd_setImageWithURL:[NSURL URLWithString:arr[0][@"author"][@"avatar"]] placeholderImage:[UIImage imageNamed:@"default_pic_big"]];
        cell.userLabel.text = arr[0][@"author"][@"name"];
        cell.commentLabel.text = [NSString stringWithFormat:@"       %@",arr[0][@"summary"]];
        
        [cell.MoreBtn addTarget:self action:@selector(ClcikMore) forControlEvents:UIControlEventTouchUpInside];
        
        return cell;
    }
}

-(void)xqClick{
    
    isNot = !isNot;
    [self.tv reloadData];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (isNot) {
            NSString *str = _dic[@"summary"];
            float height = [str boundingRectWithSize:CGSizeMake(SWIDTH-20, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size.height;
            
            return 450+height-68;
        }else{
            return 450;
        }
        
    }else if(indexPath.section == 1){
        return 130;
    }else{
        return 205;
    }
}

-(void)ClickPlayer{
    
    UIAlertView *AlertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"很抱歉，此视频不可播放" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [AlertView show];
    
//    NSURL *url=[NSURL URLWithString:_dic[@"blooper_urls"][0]];
//
//    //创始视频播放器对象
//    _movieController=[[MPMoviePlayerViewController alloc]initWithContentURL:url];
//    //设置播放器样式
//    _movieController.moviePlayer.controlStyle=MPMovieControlStyleEmbedded;
//    //设置视频视频播放器的坐标和大小
//    _movieController.moviePlayer.view.frame=self.view.frame;
//    //设置数据源
//    _movieController.moviePlayer.movieSourceType=MPMovieSourceTypeFile;
//    //将视频播放器的视图，添加到self.view
//    [self.view addSubview:_movieController.moviePlayer.view];
//    //播放视频
//    [_movieController.moviePlayer prepareToPlay];
//    [_movieController.moviePlayer play];
//    
//    //Loading...
//    _act=[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
//    _act.frame=CGRectMake(SWIDTH/2-20, (HEIGHT-64)/2, 30, 30);
//    [self.view addSubview:_act];
//    [_act startAnimating];
//    
//    [self movieControllerNotification];
}

//监听视频是否播放结束
-(void)movieControllerNotification
{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(endMovie) name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(startPlay) name:MPMoviePlayerReadyForDisplayDidChangeNotification object:nil];
}

//当正式开始播放视频时，调用该方法
-(void)startPlay
{
    //停止loading
    [_act stopAnimating];
}
//当播放结束时，移除播放视图
-(void)endMovie
{
    [_movieController.moviePlayer.view removeFromSuperview];
    [self.navigationController popViewControllerAnimated:YES];
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
