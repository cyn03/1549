//
//  MineMoreViewController.h
//  伐木累
//
//  Created by qianfeng on 15/11/18.
//  Copyright (c) 2015年 xiaoxiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MineMoreViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIScrollView *sc;
@property(nonatomic, strong)void (^Block)(NSString *);
@property(nonatomic, copy)NSString *str;
@end
