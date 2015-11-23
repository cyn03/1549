//
//  ThreeTableViewCell.m
//  HeartPro
//
//  Created by qianfeng on 15/11/13.
//  Copyright (c) 2015年 xiaoxiao. All rights reserved.
//

#import "ThreeTableViewCell.h"

@implementation ThreeTableViewCell

- (void)awakeFromNib {
    
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(leftClick:)];
//    self.leftImage.tag = 0;
//    [self.leftImage addGestureRecognizer:tap];
}

-(void)leftClick:(UITapGestureRecognizer *)tap{
    
    NSLog(@"%@",tap.view);
}

@end
