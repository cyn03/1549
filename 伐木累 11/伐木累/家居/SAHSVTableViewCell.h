//
//  SAHSVTableViewCell.h
//  HeartPro
//
//  Created by qianfeng on 15/11/8.
//  Copyright (c) 2015年 xiaoxiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SAHSVTableViewCell : UITableViewCell

@property(nonatomic, strong)NSArray *SVArray;

@property(nonatomic, strong)UILabel * label;

@property(nonatomic, strong)void(^Block)(int);

-(void)createCell;

@end
