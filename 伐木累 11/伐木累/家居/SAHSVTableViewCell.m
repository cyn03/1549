//
//  SAHSVTableViewCell.m
//  HeartPro
//
//  Created by qianfeng on 15/11/8.
//  Copyright (c) 2015年 xiaoxiao. All rights reserved.
//

#import "SAHSVTableViewCell.h"
#import "SAHModel.h"
@implementation SAHSVTableViewCell

-(void)createCell{
    
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(10, 20, 100, 20)];
    label.text = @"专题合集";
    label.font = [UIFont systemFontOfSize:20];
    [self.contentView addSubview:label];
    
    UIScrollView *sv = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 50, SWIDTH, 90)];
    sv.showsHorizontalScrollIndicator = NO;
    [self.contentView addSubview:sv];
    sv.contentSize = CGSizeMake(140*10+10, 0);
    
    for (int i = 0; i < self.SVArray.count; i ++) {
        
        SAHModel *model = self.SVArray[i];
        
        UIImageView * view = [[UIImageView alloc]initWithFrame:CGRectMake(140*i+10, 10, 130, 70)];
        [view sd_setImageWithURL:[NSURL URLWithString:model.cover_image_url] placeholderImage:[UIImage imageNamed:@"default_pic_big"]];
        view.userInteractionEnabled = YES;
        view.tag = 19-i;
        view.layer.masksToBounds = YES;
        view.layer.cornerRadius = 8;
        view.backgroundColor = [UIColor blueColor];
        [sv addSubview:view];
        
        UITapGestureRecognizer *ViewTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ViewClick:)];
        [view addGestureRecognizer:ViewTap];
        
        UIView *vi = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 130, 70)];
        vi.backgroundColor = [UIColor blackColor];
        vi.alpha = 0.05;
        [view addSubview:vi];
        
        self.label = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, 120, 60)];
        self.label.text = model.title;
        self.label.textColor = [UIColor whiteColor];
        self.label.textAlignment = YES;
        self.label.numberOfLines = 0;
                
        if (model.title.length < 6) {
            self.label.font = [UIFont boldSystemFontOfSize:24];
        }
        else if (model.title.length < 9){
            self.label.font = [UIFont boldSystemFontOfSize:20];
        }
        else{
            self.label.font = [UIFont boldSystemFontOfSize:16];
        }
        [view addSubview:self.label];
    }
    
    UILabel * lb = [[UILabel alloc]initWithFrame:CGRectMake(0, 140, SWIDTH, 10)];
    lb.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.contentView addSubview:lb];
}


-(void)ViewClick:(UITapGestureRecognizer *)tap{
    
    self.Block((int)tap.view.tag);
}



@end
