//
//  MineMoreViewController.m
//  伐木累
//
//  Created by qianfeng on 15/11/18.
//  Copyright (c) 2015年 xiaoxiao. All rights reserved.
//

#import "MineMoreViewController.h"
#import "MYButton.h"
@interface MineMoreViewController ()
{
    UITextField *field;
}
@end

@implementation MineMoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([self.str isEqualToString:@"city"]) {
        [self createCity];
        [self createCityName];
    }else{
        [self createPlace];
        self.title = @"更多";
    }
}

-(void)createCityName{
    
    self.sc.contentSize = CGSizeMake(0, 85*6);
    
    NSArray *arr1 = @[@"北京",@"天津",@"重庆",@"湖南",@"湖北",@"浙江",@"江苏",@"河南"];
    NSArray *arr2 = @[@"河北",@"甘肃",@"辽宁",@"吉林",@"贵州",@"福建",@"黑龙江",@"青海"];
    NSArray *arr3 = @[@"安徽",@"山西",@"山东",@"陕西",@"云南",@"江西",@"四川",@"西藏"];
    NSArray *arr4 = @[@"广西",@"广东",@"海南",@"台湾",@"新疆",@"内蒙古",@"上海",@"香港"];
    NSArray *arr5 = @[@"澳门",@"郑州",@"长春",@"长沙",@"南京",@"南昌",@"沈阳",@"济南",@"西安"];
    NSArray *arr6 = @[@"南宁",@"广州",@"杭州",@"昆明",@"洛阳",@"兰州",@"贵阳",@"石家庄"];
    NSArray *arr = @[arr1,arr2,arr3,arr4,arr5,arr6];
    
    for (int j = 0; j < 6; j ++) {
        
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(5, j*85-59, SWIDTH-10, 80)];
        view.backgroundColor = [UIColor groupTableViewBackgroundColor];
        view.userInteractionEnabled = YES;
        [self.sc addSubview:view];
        
        for (int i = 0; i <8; i ++) {
            
            [view addSubview:[MYButton buttonWithFrame:CGRectMake(i%4*(SWIDTH-10)/4, i/4*40, (SWIDTH-10)/4, 40) title:arr[j][i] backgroundImage:nil clickCallBack:^(MYButton *button) {
                self.Block(button.titleLabel.text);
            }]];
        }
    }
}

-(void)createCity{
    
    field = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, SWIDTH-85, 28)];
    field.backgroundColor = [UIColor whiteColor];
    field.font = [UIFont systemFontOfSize:14];
    field.placeholder = @"搜索你想要查找的城市";
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
    [button addTarget:self action:@selector(searchCityClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
}

-(void)searchCityClick{
    
    if (field.text.length>0) {
        self.Block(field.text);
    }
}

-(void)createPlace{
    
    self.sc.contentSize = CGSizeMake(0, 85*6);
    
    NSArray *arr1 = @[@"美食",@"景点",@"酒店",@"超市",@"银行",@"公交站",@"加油站",@"电影院"];
    NSArray *arr2 = @[@"美食",@"中餐",@"小吃快餐",@"川菜",@"西餐",@"火锅",@"肯德基",@"餐馆"];
    NSArray *arr3 = @[@"酒店",@"快捷酒店",@"星际酒店",@"青年旅社",@"旅馆",@"招待所",@"特价酒店",@"度假村"];
    NSArray *arr4 = @[@"休闲",@"电影院",@"KTV",@"酒吧",@"咖啡厅",@"网吧",@"丽人",@"景点"];
    NSArray *arr5 = @[@"交通设施",@"公交站",@"加油站",@"停车场",@"火车票代售点",@"汽车票代售点",@"火车站",@"长途车站"];
    NSArray *arr6 = @[@"生活服务",@"超市",@"药店",@"ATM",@"银行",@"医院",@"厕所",@"商场"];
    NSArray *arr = @[arr1,arr2,arr3,arr4,arr5,arr6];
    
    for (int j = 0; j < 6; j ++) {
        
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(5, j*85-59, SWIDTH-10, 80)];
        view.backgroundColor = [UIColor groupTableViewBackgroundColor];
        view.userInteractionEnabled = YES;
        [self.sc addSubview:view];

        for (int i = 0; i <8; i ++) {
            
            if (j==4&&i==4) {
                [view addSubview:[MYButton buttonWithFrame:CGRectMake(i%4*(SWIDTH-10)/4, i/4*40, (SWIDTH-10)/4*2, 40) title:arr[j][i] backgroundImage:nil clickCallBack:^(MYButton *button) {
                    self.Block(button.titleLabel.text);
                }]];
                i++;
            }else{
                [view addSubview:[MYButton buttonWithFrame:CGRectMake(i%4*(SWIDTH-10)/4, i/4*40, (SWIDTH-10)/4, 40) title:arr[j][i] backgroundImage:nil clickCallBack:^(MYButton *button) {
                    self.Block(button.titleLabel.text);
                }]];
            }
        }
    }
}



@end
