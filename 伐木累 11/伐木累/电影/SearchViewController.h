//
//  SearchViewController.h
//  伐木累
//
//  Created by qianfeng on 15/11/15.
//  Copyright (c) 2015年 xiaoxiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchViewController : UIViewController
@property(nonatomic, copy)NSString *str;
@property (weak, nonatomic) IBOutlet UITableView *tv;
@end
