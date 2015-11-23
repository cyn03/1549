//
//  DetailTableViewCell.m
//  HeartPro
//
//  Created by qianfeng on 15/11/9.
//  Copyright (c) 2015年 xiaoxiao. All rights reserved.
//

#import "DetailTableViewCell.h"

@implementation DetailTableViewCell

-(void)createCell:(NSDictionary *)dic height:(CGFloat)height titleheight:(CGFloat)titleheight{
    
    self.cover_image = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SWIDTH, 200)];
    [self.cover_image sd_setImageWithURL:[NSURL URLWithString:dic[@"cover_image_url"]] placeholderImage:[UIImage imageNamed:@"default_pic_big"]];
    
    [self.contentView addSubview:self.cover_image];
    
    self.titleLable = [[UILabel alloc]initWithFrame:CGRectMake(15, 205, SWIDTH-30, titleheight)];
    self.titleLable.text = dic[@"title"];
    self.titleLable.font = [UIFont systemFontOfSize:23];
    self.titleLable.numberOfLines = 0;
    [self.contentView addSubview:self.titleLable];
    
    self.shareLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 215+titleheight-20, SWIDTH-20, height)];
    self.shareLabel.text = dic[@"share_msg"];
    
    self.shareLabel.numberOfLines = 0;
    self.shareLabel.font = [UIFont systemFontOfSize:17];
    [self.contentView addSubview:self.shareLabel];


}

@end
