//
//  MainTabBarViewController.m
//  HeartPro
//
//  Created by qianfeng on 15/11/7.
//  Copyright (c) 2015年 xiaoxiao. All rights reserved.
//

#import "MainTabBarViewController.h"
#import "SAHViewController.h"
#import "AppDelegate.h"
#import "MainViewController.h"
#import "MineViewController.h"
@interface MainTabBarViewController ()
{
    //记录上一次被点击的按钮
    UINavigationController *_perNav;
    UILabel *_perLb;
    UIImageView *_perImgV;
}
@end

@implementation MainTabBarViewController

/** ---创建TabNav--- **/
+(instancetype)TabNav{
    
    MainTabBarViewController *main = [[MainTabBarViewController alloc]init];
    
    [main creatNav];
    [main creatTab];
    
    return main;
}

/** ---隐藏系统的Tab--- **/
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    for (UIView *view in self.tabBar.subviews) {
        view.hidden = YES;
    }
}

/** ---创建系统的TabNav--- **/
-(void)creatNav{
    
    //获取AppDelegate对象并创建window
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    delegate.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    SAHViewController *sah = [[SAHViewController alloc]init];
    UINavigationController *sahNav = [[UINavigationController alloc]initWithRootViewController:sah];
    sahNav.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"家居" image:[UIImage imageNamed:@"icon_tab1_normal@2x"] selectedImage:[UIImage imageNamed:@"icon_tab1_selected@2x"]];
    
    MainViewController * movie = [[MainViewController alloc]init];
    UINavigationController *movieNav = [[UINavigationController alloc]initWithRootViewController:movie];
    movieNav.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"电影" image:[UIImage imageNamed:@"icon_tab3_normal@2x"] selectedImage:[UIImage imageNamed:@"icon_tab3_selected@2x"]];
    
    MineViewController * mine = [[MineViewController alloc]init];
    UINavigationController *mineNav = [[UINavigationController alloc]initWithRootViewController:mine];
    mineNav.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"我的" image:[UIImage imageNamed:@"icon_tab4_normal@2x"] selectedImage:[UIImage imageNamed:@"icon_tab4_selected@2x"]];
    
    //把nav添加到tab上
    self.viewControllers = @[sahNav,movieNav,mineNav];
    
    //把tab添加到window上
    delegate.window.rootViewController = self;
    [delegate.window makeKeyAndVisible];
}

/** ---创建自定义的TabNav--- **/
-(void)creatTab{
    
    //获取系统的nav视图
    NSArray *array = self.viewControllers;
    
    for (int i = 0; i < array.count; i ++) {
        //获得标签控制器中每一个子视图控制器
        UINavigationController *nav = array[i];
        
        //创建UIView对象
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(SWIDTH/array.count*i, 0, SWIDTH/array.count, 49)];
        view.backgroundColor = [UIColor blackColor];
        [self.tabBar addSubview:view];
        view.userInteractionEnabled = YES;
        view.tag = 100+i;
        //给每个view添加点击手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick:)];
        [view addGestureRecognizer:tap];
        
        UIImageView *imgV = [[UIImageView alloc]initWithFrame:CGRectMake((view.frame.size.width-30)/2, 2, 30, 30)];
        [view addSubview:imgV];
        imgV.image = nav.tabBarItem.image;
        
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake((view.frame.size.width-65)/2, 36, 65, 9)];
        label.text = nav.tabBarItem.title;
        label.textColor = UIColorRGB(130, 130, 130);
        label.font = [UIFont boldSystemFontOfSize:14];
        label.textAlignment = YES;
        [view addSubview:label];
        
        //记录第一次进来状态
        if (i == 0) {
            imgV.image = nav.tabBarItem.selectedImage;
            label.textColor = [UIColor redColor];
            _perImgV = imgV;
            _perLb = label;
            _perNav = nav;
        }
    }
}

-(void)tapClick:(UITapGestureRecognizer *)tap{
    
    UIView *view = (UIView *)tap.view;
    //获得点击按钮对应的视图控制器
    UINavigationController *nav = self.viewControllers[view.tag-100];
    UIImageView *imgV = [[view subviews]firstObject];
    imgV.image = nav.tabBarItem.selectedImage;
    
    UILabel *lable = [[view subviews]lastObject];
    lable.textColor = [UIColor redColor];
    
    //判断两次点击是否为想同的按钮
    if (_perImgV == imgV) {
        return;
    }
    _perImgV.image = _perNav.tabBarItem.image;
    _perLb.textColor = UIColorRGB(130, 130, 130);;
    
    //重新设置pre按钮
    _perImgV = imgV;
    _perLb = lable;
    _perNav = nav;
    
    //切换标签控制器的页面
    self.selectedIndex = view.tag-100;
}

@end
