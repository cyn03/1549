//
//  SAHTableViewCell.m
//  HeartPro
//
//  Created by qianfeng on 15/11/8.
//  Copyright (c) 2015年 xiaoxiao. All rights reserved.
//

#import "SAHTableViewCell.h"
#import "SAHModel.h"
@implementation SAHTableViewCell

-(void)createCell{
    
    UILabel * Lb = [[UILabel alloc]initWithFrame:CGRectMake(10, 20, 100, 20)];
    Lb.text = @"地点";
    Lb.font = [UIFont systemFontOfSize:20];
    [self.contentView addSubview:Lb];
    
    UIButton * refinedBut = [[UIButton alloc]initWithFrame:CGRectMake(SWIDTH-60, 20, 40, 20)];
    [refinedBut setTitle:@"精选" forState:UIControlStateNormal];
    [refinedBut setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    refinedBut.titleLabel.font = [UIFont systemFontOfSize:20];
    [refinedBut addTarget:self action:@selector(refinedClick) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:refinedBut];
    
    
    //厨房
    UIView *kitchenView = [[UIView alloc]initWithFrame:CGRectMake(10, 60, (SWIDTH-30)/2, 200)];
    [self.contentView addSubview:kitchenView];
    
    UITapGestureRecognizer *kitchenTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(kitchenClick)];
    [kitchenView addGestureRecognizer:kitchenTap];

    self.kitchenImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, (SWIDTH-30)/2, 165/375.f*SWIDTH)];
    [kitchenView addSubview:self.kitchenImage];
    self.kitchenLb = [[UILabel alloc]initWithFrame:CGRectMake(0, 165/375.f*SWIDTH, (SWIDTH-30)/2, 30)];
    self.kitchenLb.font = [UIFont systemFontOfSize:20];
    self.kitchenLb.textAlignment = YES;
    [kitchenView addSubview:self.kitchenLb];
    
    //卧室
    UIView *bedroomView = [[UIView alloc]initWithFrame:CGRectMake((SWIDTH-30)/2+20, 60, (SWIDTH-30)/2, 120)];
    [self.contentView addSubview:bedroomView];
    
    UITapGestureRecognizer *bedroomTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(bedroomClick)];
    [bedroomView addGestureRecognizer:bedroomTap];
    
    self.bedroomImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, (SWIDTH-30)/2, 90/375.f*SWIDTH)];
    [bedroomView addSubview:self.bedroomImage];
    self.bedroomLb = [[UILabel alloc]initWithFrame:CGRectMake(0, 90/375.f*SWIDTH, (SWIDTH-30)/2, 30)];
    self.bedroomLb.font = [UIFont systemFontOfSize:20];
    self.bedroomLb.textAlignment = YES;
    [bedroomView addSubview:self.bedroomLb];
    
    //卫浴
    UIView *sanitation = [[UIView alloc]initWithFrame:CGRectMake(10, 270, (SWIDTH-30)/2, 130)];
    [self.contentView addSubview:sanitation];
    
    UITapGestureRecognizer *sanitationTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(sanitationClick)];
    [sanitation addGestureRecognizer:sanitationTap];
    
    self.sanitationImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, (SWIDTH-50)/2, 100/375.f*SWIDTH)];
    [sanitation addSubview:self.sanitationImage];
    self.sanitationLb = [[UILabel alloc]initWithFrame:CGRectMake(0, 100/375.f*SWIDTH, (SWIDTH-30)/2, 30)];
    self.sanitationLb.font = [UIFont systemFontOfSize:20];
    self.sanitationLb.textAlignment = YES;
    [sanitation addSubview:self.sanitationLb];
    
    //客厅
    UIView *LV = [[UIView alloc]initWithFrame:CGRectMake((SWIDTH-30)/2+20, 190, (SWIDTH-30)/2, 150)];
    [self.contentView addSubview:LV];
    
    UITapGestureRecognizer *LVTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(LVClick)];
    [LV addGestureRecognizer:LVTap];
    
    self.LVImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, (SWIDTH-30)/2, 120/375.f*SWIDTH)];
    [LV addSubview:self.LVImage];
    self.LVLb = [[UILabel alloc]initWithFrame:CGRectMake(0, 120/375.f*SWIDTH, (SWIDTH-30)/2, 30)];
    self.LVLb.font = [UIFont systemFontOfSize:20];
    self.LVLb.textAlignment = YES;
    [LV addSubview:self.LVLb];
    
    //书房
    UIView *study = [[UIView alloc]initWithFrame:CGRectMake((SWIDTH-30)/2+20, 350, (SWIDTH-30)/2, 90)];
    [self.contentView addSubview:study];
    
    UITapGestureRecognizer *studyTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(studyClick)];
    [study addGestureRecognizer:studyTap];
    
    self.studyImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, (SWIDTH-30)/2, 60/375.f*SWIDTH)];
    [study addSubview:self.studyImage];
    self.studyLb = [[UILabel alloc]initWithFrame:CGRectMake(0, 60/375.f*SWIDTH, (SWIDTH-30)/2, 30)];
    self.studyLb.font = [UIFont systemFontOfSize:20];
    self.studyLb.textAlignment = YES;
    [study addSubview:self.studyLb];
}

-(void)kitchenClick{
    
    self.KitchenBlock(12);
}

-(void)bedroomClick{
    
    self.KitchenBlock(13);
}

-(void)sanitationClick{
    
    self.KitchenBlock(14);
}

-(void)LVClick{
    
    self.KitchenBlock(15);
}

-(void)studyClick{
    
    self.KitchenBlock(16);
}

-(void)refinedClick{
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"refined" object:nil];
}

@end
