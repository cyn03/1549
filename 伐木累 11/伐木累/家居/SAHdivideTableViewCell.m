//
//  SAHdivideTableViewCell.m
//  HeartPro
//
//  Created by qianfeng on 15/11/7.
//  Copyright (c) 2015年 xiaoxiao. All rights reserved.
//

#import "SAHdivideTableViewCell.h"

@implementation SAHdivideTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createCell];
    }
    return self;
}

-(void)createCell{
    
    self.Image = [[UIImageView alloc]initWithFrame:CGRectMake(6, 0, SWIDTH-12, 200)];
    self.Image.layer.masksToBounds = YES;
    self.Image.layer.cornerRadius = 8;
    [self.contentView addSubview:self.Image];
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SWIDTH-12, 200)];
    view.backgroundColor = [UIColor blackColor];
    view.alpha = 0.05;
    [self.Image addSubview:view];
    
    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 150, SWIDTH-50, 50)];
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    self.titleLabel.numberOfLines = 0;
    [self.contentView addSubview:self.titleLabel];
}


@end
