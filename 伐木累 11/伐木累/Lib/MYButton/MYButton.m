//
//  MYButton.m
//  4564131316
//
//  Created by qianfeng on 15/10/27.
//  Copyright (c) 2015年 xiaoxiao. All rights reserved.
//

#import "MYButton.h"

/** 颜色判断 */
#define UIColorRGBA(_r, _g, _b, _a) [UIColor colorWithRed:_r/255.f green:_g/255.f blue:_b/255.f alpha:_a]

#define UIColorRGB(_r, _g, _b) UIColorRGBA(_r, _g, _b, 1)

@interface MYButton ()

/** 全局变量, 用来临时存储代码段 */
@property (nonatomic, copy) void (^clickCallBack)(MYButton *button);

@end

@implementation MYButton

/** -------------工厂button------------ */
+ (instancetype)buttonWithFrame:(CGRect)frame
                          title:(NSString *)title
                backgroundImage:(NSString *)image
                  clickCallBack:(void (^)(MYButton *button))callBack{
    
    MYButton *button = [MYButton buttonWithType:UIButtonTypeCustom];
    
    button.frame = frame;
    [button setTitle:title forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    
    
    [button setTitleColor:UIColorRGB(arc4random()%255, arc4random()%255, arc4random()%255) forState:UIControlStateNormal];
    
    button.layer.borderWidth = 1;
    button.layer.borderColor = [[UIColor greenColor]CGColor];
//    button.titleLabel.font = [UIFont systemFontOfSize:15];
    
#warning 重点  封装button的重点
#warning target不能是self ,这个时候self表示类本身
    // 事件回调
    [button addTarget:button action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    // 复制代码段
    button.clickCallBack = callBack;
    
    return button;
}

- (void)buttonAction:(MYButton *)button {
    // 事件回调
    if (button.clickCallBack) {
        button.clickCallBack(button);
    }
}


@end
