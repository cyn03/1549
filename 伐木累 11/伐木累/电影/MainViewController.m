//
//  MainViewController.m
//  HeartPro
//
//  Created by qianfeng on 15/11/12.
//  Copyright (c) 2015年 xiaoxiao. All rights reserved.
//

#import "MainViewController.h"
#import "OneViewController.h"
#import "TwoViewController.h"
#import "ThreeViewController.h"
#import "OneXQViewController.h"
#import "ThreeXQViewController.h"
#import "ZXXQViewController.h"
#import "SearchViewController.h"
@interface MainViewController ()<ViewPagerDataSource,ViewPagerDelegate>
{
    UITextField *field;
}
@property(nonatomic,strong)NSArray * dataArr;
@end

@implementation MainViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [field removeFromSuperview];
    
    UIButton * button1 = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, SWIDTH-85, 28)];
    [button1 setTitle:@"电影" forState:UIControlStateNormal];
    self.navigationItem.titleView = button1;
    
    UIButton * leftbutton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 25, 25)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftbutton];
    
    
    UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 25, 25)];
    [button setImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
}

- (void)viewDidLoad {
    
    self.title=@"电影";
    [self hidenaviBar];
    self.delegate=self;
    self.dataSource=self;
    self.dataArr=[[NSArray alloc]init];
    self.dataArr=@[@"上映",@"推荐",@"资讯"];
    if (ios7_or_later) {
        self.edgesForExtendedLayout=UIRectEdgeNone;
    }
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(click:) name:@"MOVIE" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(clickThree:) name:@"THREE" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(clickZX:) name:@"ZX" object:nil];
}

-(void)click{
    
    field = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, SWIDTH-85, 28)];
    field.backgroundColor = [UIColor whiteColor];
    field.font = [UIFont systemFontOfSize:14];
    field.placeholder = @"搜索你想看的电影";
    field.layer.masksToBounds = YES;
    field.layer.cornerRadius = 4;
    self.navigationItem.titleView = field;
    
    //搜索图标
    UIImageView *view = [[UIImageView alloc] init];
    view.frame = CGRectMake(0, 0, 30, 28);
    //左边搜索图标的模式
    view.contentMode = UIViewContentModeCenter;
    //左边搜索图标总是显示
    field.leftViewMode = UITextFieldViewModeAlways;
    field.leftView = view;
    
    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(7, 7, 15, 15)];
    image.alpha = 0.5;
    image.image = [UIImage imageNamed:@"search2"];
    [view addSubview:image];
    
    UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(SWIDTH-(SWIDTH-70), 0, 45, 28)];
    [button setTitle:@"确定" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont boldSystemFontOfSize:17];
    [button addTarget:self action:@selector(searchBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    
}

-(void)searchBtnClick{
    
    if (field.text.length > 0) {
        SearchViewController *search = [[SearchViewController alloc]init];
        search.str = field.text;
        [self.navigationController pushViewController:search animated:YES];
    }else{
        [field removeFromSuperview];
        
        [self viewWillAppear:YES];
    }
}

-(void)click:(NSNotification *)n{
    
    OneXQViewController *onexq = [[OneXQViewController alloc]init];
    
    onexq.str = n.object;
    onexq.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:onexq animated:YES];
}

-(void)clickThree:(NSNotification *)n{
    
    ThreeXQViewController *threexq = [[ThreeXQViewController alloc]init];
    
    threexq.str = n.object;
    threexq.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:threexq animated:YES];
}

-(void)clickZX:(NSNotification *)n{
    
    ZXXQViewController *zxxq = [[ZXXQViewController alloc]init];
    
    zxxq.str = n.object;
    zxxq.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:zxxq animated:YES];
}

#pragma mark-------协议
-(NSUInteger)numberOfTabsForViewPager:(ViewPagerController *)viewPager{
    return self.dataArr.count;
}
-(UIView *)viewPager:(ViewPagerController *)viewPager viewForTabAtIndex:(NSUInteger)index{
    UILabel * label = [[UILabel alloc]init];
    label.backgroundColor=[UIColor whiteColor];
    label.font=[UIFont boldSystemFontOfSize:18];
    label.text=self.dataArr[index];
    label.textAlignment=NSTextAlignmentCenter;
    label.textColor=[UIColor blackColor];
    [label sizeToFit];
    return label;
}
-(UIViewController *)viewPager:(ViewPagerController *)viewPager contentViewControllerForTabAtIndex:(NSUInteger)index{
    if (index==0) {
        OneViewController * one=[[OneViewController alloc]init];
        UINavigationController *oneNav = [[UINavigationController alloc]initWithRootViewController:one];
        return oneNav;
    }else if (index==1){
        ThreeViewController * three=[[ThreeViewController alloc]init];
        UINavigationController *threeNav = [[UINavigationController alloc]initWithRootViewController:three];
        return threeNav;
    }else{
        TwoViewController * two=[[TwoViewController alloc]init];
        UINavigationController *twoNav = [[UINavigationController alloc]initWithRootViewController:two];
        return twoNav;
    }
}
-(CGFloat)viewPager:(ViewPagerController *)viewPager valueForOption:(ViewPagerOption)option withDefault:(CGFloat)value{
    switch (option) {
        case ViewPagerOptionStartFromSecondTab:
            return 0.0;
            break;
        case ViewPagerOptionCenterCurrentTab:
            return 0.0;
            break;
//        case ViewPagerOptionTabLocation:
//            return 1.0;
        default:
            break;
    }
    return value;
}
-(UIColor*)viewPager:(ViewPagerController *)viewPager colorForComponent:(ViewPagerComponent)component withDefault:(UIColor *)color{
    switch (component) {
        case ViewPagerIndicator:
            return [[UIColor orangeColor]colorWithAlphaComponent:0.64];
            break;
            
        default:
            break;
    }
    return color;
}

-(void)hidenaviBar{
    self.navigationController.navigationBar.barStyle=UIBarStyleBlack;
}


@end
