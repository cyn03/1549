//
//  MYDataBaseManager.h
//  14112221
//
//  Created by qianfeng on 15/10/24.
//  Copyright (c) 2015年 xiaoxiao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MyModel.h"
/** 导入数据库文件头 */
#import "FMDatabase.h"

@interface MYDataBaseManager : NSObject
{
    FMDatabase *_dataBase;
}
//创建单例
+(instancetype)sharedManager;
//初始化
-(instancetype)init;
//判断是否收藏过
-(BOOL)isCollectionedWithID:(NSString *)ID;
//收藏总数
-(NSInteger)totalCount;
//添加收藏
-(void)addDic:(NSDictionary *)dic;
//删除收藏
-(void)deleteDic:(NSString *)ID1;
//展示收藏
-(NSMutableArray *)insertIntoArray;

@end
