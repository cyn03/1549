//
//  MYButton.h
//  4564131316
//
//  Created by qianfeng on 15/10/27.
//  Copyright (c) 2015年 xiaoxiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MYButton : UIButton

/** 工厂button */
+ (instancetype)buttonWithFrame:(CGRect)frame
                          title:(NSString *)title
                backgroundImage:(NSString *)image
                  clickCallBack:(void (^)(MYButton *button))callBack;

@end
