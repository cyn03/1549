//
//  CommentCell.h
//  HeartPro
//
//  Created by qianfeng on 15/11/13.
//  Copyright (c) 2015年 xiaoxiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommentCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *userImage;
@property (weak, nonatomic) IBOutlet UILabel *userLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;
@property (weak, nonatomic) IBOutlet UIButton *MoreBtn;

@end
