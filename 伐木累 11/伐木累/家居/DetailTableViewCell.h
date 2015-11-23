//
//  DetailTableViewCell.h
//  HeartPro
//
//  Created by qianfeng on 15/11/9.
//  Copyright (c) 2015年 xiaoxiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailTableViewCell : UITableViewCell

@property(nonatomic, strong)UIImageView *cover_image;
@property(nonatomic, strong)UILabel *shareLabel;
@property(nonatomic, strong)UILabel *titleLable;

-(void)createCell:(NSDictionary *)dic height:(CGFloat)height titleheight:(CGFloat)titleheight;

@end
