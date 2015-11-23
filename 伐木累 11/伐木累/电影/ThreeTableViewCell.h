//
//  ThreeTableViewCell.h
//  HeartPro
//
//  Created by qianfeng on 15/11/13.
//  Copyright (c) 2015年 xiaoxiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ThreeTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *leftImage;
@property (weak, nonatomic) IBOutlet UIImageView *middleImage;
@property (weak, nonatomic) IBOutlet UIImageView *rightImage;
@property (weak, nonatomic) IBOutlet UILabel *leftLabel;
@property (weak, nonatomic) IBOutlet UILabel *middleLabel;
@property (weak, nonatomic) IBOutlet UILabel *righrLabel;

@end
