//
//  SAHTableViewCell.h
//  HeartPro
//
//  Created by qianfeng on 15/11/8.
//  Copyright (c) 2015年 xiaoxiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SAHTableViewCell : UITableViewCell

@property(nonatomic, strong)UIImageView *kitchenImage;
@property(nonatomic, strong)UILabel *kitchenLb;
@property(nonatomic, strong)UIImageView *bedroomImage;
@property(nonatomic, strong)UILabel *bedroomLb;
@property(nonatomic, strong)UIImageView *sanitationImage;
@property(nonatomic, strong)UILabel *sanitationLb;
@property(nonatomic, strong)UIImageView *LVImage;
@property(nonatomic, strong)UILabel *LVLb;
@property(nonatomic, strong)UIImageView *studyImage;
@property(nonatomic, strong)UILabel *studyLb;

@property(nonatomic, strong)void(^KitchenBlock)(int);

@property(nonatomic, strong)NSArray *array;
-(void)createCell;

@end
