//
//  MineShowViewController.m
//  伐木累
//
//  Created by qianfeng on 15/11/17.
//  Copyright (c) 2015年 xiaoxiao. All rights reserved.
//

#import "MineShowViewController.h"
#import "MineMoreViewController.h"
#import "MYButton.h"
#import "MyModel.h"
#import "OneTableViewCell.h"
#import "OneXQViewController.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapSearchKit/AMapSearchAPI.h>
@interface MineShowViewController ()<UITableViewDataSource,UITableViewDelegate,MAMapViewDelegate,AMapSearchDelegate,UITextFieldDelegate,UIScrollViewDelegate>
{
    NSMutableArray *_dataArray;
    //声明地图变量
    MAMapView *_mapView;
    //声明POI搜索成员变量
    AMapSearchAPI *_search;
    UITextField *field;
    NSString *_city;
    CGFloat _latitude;
    CGFloat _longitude;
}
@end

@implementation MineShowViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _city = @"北京";
    _latitude = 39.904987;
    _longitude = 116.405281;
    
    [self judge];
}

-(void)judge{
    
    if (self.k == 0) {
        
        [self createData];
    }
    else if (self.k == 1){
        [self showMapView];
        [self creatNav];
        [self mapControl];
        self.tabBarController.tabBar.hidden = YES;
    }
    else{
        
    }
}

-(void)createData{
    
    [self hideFoodView];
    _dataArray = [[MYDataBaseManager sharedManager]insertIntoArray];
    if (_dataArray.count == 0) {
        UIImageView *view = [[UIImageView alloc]initWithFrame:CGRectMake(20, (HEIGHT-200)/2, SWIDTH-40, 200)];
        view.image = [UIImage imageNamed:@"favEmpty@2x 3.png"];
        view.layer.borderWidth = 2;
        view.layer.borderColor = [[UIColor orangeColor]CGColor];
        view.layer.masksToBounds = YES;
        view.layer.cornerRadius = 15;
        [self.view addSubview:view];
    }else{
        [self.tv reloadData];
        [self hideFoodView];
    }
}

//地理编码
-(void)geoCode{
    
    _search = [[AMapSearchAPI alloc]initWithSearchKey:@"dcdfc364d0368848aacc423d7e81bb94" Delegate:self];
    AMapGeocodeSearchRequest *request = [[AMapGeocodeSearchRequest alloc]init];
    //设置搜索的类型为地理编码
    request.searchType = AMapSearchType_Geocode;
    request.address = _city;
    request.city = @[_city];
    
    [_search AMapGeocodeSearch:request];
}
//当地理编码结束时，会调用该方法
-(void)onGeocodeSearchDone:(AMapGeocodeSearchRequest *)request response:(AMapGeocodeSearchResponse *)response{
    
    [response.geocodes enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        AMapGeocode *code = (AMapGeocode *)obj;
        NSLog(@"经度：%f   纬度：%f",code.location.longitude,code.location.latitude);
        _latitude = code.location.latitude;
        _longitude = code.location.longitude;
        [self Centre];
    }];
}

-(void)Centre
{
    [_mapView setCenterCoordinate:CLLocationCoordinate2DMake(_latitude, _longitude)];
}

-(void)creatNav{
    
    field = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, SWIDTH-85, 28)];
    field.backgroundColor = [UIColor whiteColor];
    field.font = [UIFont systemFontOfSize:14];
    field.placeholder = @"搜索你想要去的地方";
    field.layer.masksToBounds = YES;
    field.layer.cornerRadius = 4;
    field.delegate = self;
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

    [field resignFirstResponder];
    if (field.text.length>0) {
        [self showMapView];
        [self mapControl];
        [self Centre];
        [self searchByKeyWords];
    }
}

- (void)textFieldDidBeginEditing:(UITextField *)textField;{
    
    [self.view.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    self.tv.hidden = YES;
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(5, 69, SWIDTH-10, 80)];
    view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    view.userInteractionEnabled = YES;
    [self.view addSubview:view];
    
    UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(5, 154, SWIDTH-10, 40)];
    view1.backgroundColor = [UIColor groupTableViewBackgroundColor];
    view1.userInteractionEnabled = YES;
    [self.view addSubview:view1];
    
    NSArray *arr = @[@"美食",@"景点",@"酒店",@"超市",@"银行",@"公交站",@"加油站",@"更多>"];
    for (int i = 0; i <arr.count; i ++) {
        
        UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(i%4*(SWIDTH-10)/4, i/4*40, (SWIDTH-10)/4, 40)];
        [button setTitle:arr[i] forState:UIControlStateNormal];
        [view addSubview:button];
        button.tag = i+300;
        [button addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        if (i == arr.count-1) {
            [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        }else{
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
    }
    
    NSArray *arr1 = @[@"切换城市"];
    for (int i = 0; i < arr1.count; i ++) {
        
        [view1 addSubview:[MYButton buttonWithFrame:CGRectMake(0, i*40, SWIDTH-10, 40) title:arr1[i] backgroundImage:nil clickCallBack:^(MYButton *button) {
            if ([button.titleLabel.text isEqualToString:@"定位"]) {
                [field resignFirstResponder];
                [self showMapView];
                [self mapLocation];
                [self mapControl];
                [self Centre];
            }else{
                MineMoreViewController *city = [[MineMoreViewController alloc]init];
                
                city.str = @"city";
                city.Block = ^(NSString *city){
                    [self.navigationController popViewControllerAnimated:YES];
                    _city = city;
                    [self geoCode];
                    [self showMapView];
                    [self mapControl];
                };
                
                [self.navigationController pushViewController:city animated:NO];
            }
        }]];
    }
}

-(void)click:(UIButton *)but{
    
    if (but.tag == 307) {
        MineMoreViewController *more = [[MineMoreViewController alloc]init];
        
        more.Block = ^(NSString *block){
            [self.navigationController popViewControllerAnimated:YES];
            [self showMapView];
            [self Centre];
            field.text = block;
            [self searchByKeyWords];
            [self mapControl];
        };
        
        more.str = @"more";
        [self.navigationController pushViewController:more animated:NO];
    }else{
        NSArray *arr = @[@"美食",@"景点",@"酒店",@"超市",@"银行",@"公交站",@"加油站",@"更多>"];
        
        [self showMapView];
        [self Centre];
        [field resignFirstResponder];
        field.text = arr[but.tag-300];
        [self searchByKeyWords];
        [self mapControl];
    }
}

//关键字查询
-(void)searchByKeyWords{
    
    //创建搜索对象
    _search = [[AMapSearchAPI alloc]initWithSearchKey:@"dcdfc364d0368848aacc423d7e81bb94" Delegate:self];
    //创建准备搜索地点的对象
    AMapPlaceSearchRequest *request = [[AMapPlaceSearchRequest alloc]init];
    //设置搜索类型
    request.searchType = AMapSearchType_PlaceKeyword;
    //设置准备查询的关键字
    request.keywords = field.text;
    //设置准备查询的范围
    request.city = @[_city];
    //开始查询
    [_search AMapPlaceSearch:request];
}

-(void)onPlaceSearchDone:(AMapPlaceSearchRequest *)request response:(AMapPlaceSearchResponse *)response{
    
    if (response.pois == nil) {
        UIAlertView *AlertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"未搜到你想要得结果" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [AlertView show];
    }
    for (AMapPOI *poi in response.pois) {
        
        MAPointAnnotation *point = [[MAPointAnnotation alloc]init];
        
        point.coordinate = CLLocationCoordinate2DMake(poi.location.latitude, poi.location.longitude);
        point.title = poi.name;
        point.subtitle = poi.address;
        [_mapView addAnnotation:point];
    }
}

//地图定位
-(void)mapLocation{
    //开启地图定位
    _mapView.showsUserLocation = YES;
}

//当手机移动时调用该方法
- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation{
    
    if (updatingLocation) {
        NSLog(@"lon:%f   lat:%f",userLocation.coordinate.longitude,userLocation.coordinate.latitude);
        _latitude = userLocation.coordinate.latitude;
        _longitude = userLocation.coordinate.longitude;
    }
    NSLog(@"手机移动了");
}

//当向地图中添加覆盖物时，调用该方法，需要在这个方法中指定覆盖物的类型
- (MAAnnotationView*)mapView:(MAMapView *)mapView viewForAnnotation:(id <MAAnnotation>)annotation{
    
    static NSString *str = @"annotationId";
    //咋复用队列中获得大头针
    MAPinAnnotationView *pin = (MAPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:str];
    if (!pin) {
        pin = [[MAPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:str];
    }
    
    //设置大头针允许拖拽
        pin.draggable = YES;
    //设置大头针运行显示气泡
        pin.canShowCallout = YES;
    //设置大头针插入动画
        pin.animatesDrop = YES;
//    设置pin颜色
        pin.pinColor = MAPinAnnotationColorGreen;
    
    return pin;
}

//显示地图
-(void)showMapView{
    
    //设置APIKey
    [MAMapServices sharedServices].apiKey = @"dcdfc364d0368848aacc423d7e81bb94";
    
    //创建地图
    _mapView = [[MAMapView alloc]initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height-64)];
    
    //设置地图的回调
    _mapView.delegate = self;
    
    //将地图添加到self.view
    [self.view addSubview:_mapView];
}

//地图控件的使用
-(void)mapControl{
    
    //设置比例尺坐标
    _mapView.scaleOrigin = CGPointMake(100, 100);
    //隐藏比例尺
    _mapView.showsScale = NO;
    
    //设置指南针位置
    _mapView.compassOrigin = CGPointMake(100, 100);
    //隐藏指南针
    _mapView.showsCompass = NO;
}

-(void)hideFoodView{
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectZero];
    self.tv.tableFooterView = view;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyModel * model = _dataArray[indexPath.row];
    [[MYDataBaseManager sharedManager]deleteDic:model.id];//在数据库中删除当前的数据
    [_dataArray removeObjectAtIndex:indexPath.row];//在数据源中删除当前的数据
    [self.tv deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];//删除当前的_tableView
    [self createData];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    OneTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ID"];
    
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"OneCell" owner:self options:nil]firstObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    MyModel *model = _dataArray[indexPath.row];
    
    [cell.oneImage sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:[UIImage imageNamed:@"default_pic_big"]];
    cell.titleLabel.text = model.title;
    cell.orignalLabel.text = model.original_title;
    cell.markLabel.text = [NSString stringWithFormat:@"%@分",model.average];
    cell.dayLabel.text = model.pubdate;
    cell.collectionLabel.text = [NSString stringWithFormat:@"收藏：%@",model.collect_count];
    
    cell.view = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(cell.tuijianLabel.frame)+15, CGRectGetMaxY(cell.tuijianLabel.frame)-20, 65, 23)];
    cell.view.image = [UIImage imageNamed:@"StarsForeground"];
    [cell.contentView addSubview:cell.view];
    CGRect rect = cell.view.frame;
    CGFloat score = [model.stars floatValue]/10;
    cell.view.frame = CGRectMake(rect.origin.x, rect.origin.y, (rect.size.width/5)*score, rect.size.height);
    //切割
    cell.view.clipsToBounds = YES;
    cell.view.contentMode = UIViewContentModeLeft;
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 160;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MyModel *model = _dataArray[indexPath.row];
    
    OneXQViewController *onexq = [[OneXQViewController alloc]init];
    
    onexq.str = model.id;
    onexq.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:onexq animated:YES];
}


@end
