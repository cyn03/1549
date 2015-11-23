//
//  MYHeaderView.h
//  CYN_TBLX1
//
//  Created by qianfeng on 15/10/22.
//  Copyright (c) 2015年 xiaoxiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MYHeaderView : UIView

+(instancetype)HeaderView;

/** scrollView显示的所有的图片 */
@property (nonatomic, strong) NSArray *images;

@end
