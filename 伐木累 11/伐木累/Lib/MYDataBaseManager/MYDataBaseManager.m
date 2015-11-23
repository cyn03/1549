//
//  MYDataBaseManager.m
//  14112221
//
//  Created by qianfeng on 15/10/24.
//  Copyright (c) 2015年 xiaoxiao. All rights reserved.
//

#import "MYDataBaseManager.h"

@implementation MYDataBaseManager

/* --------------创建单例-------------- */
+(instancetype)sharedManager{
    
    static MYDataBaseManager * Manager;
    
    static dispatch_once_t onceTaken;
    
    dispatch_once(&onceTaken,^{
        
        Manager = [[MYDataBaseManager alloc]init];
    });
    
    return Manager;
}

/* ----------初始化---------- */
-(instancetype)init{
    
    if (self == [super init]) {
        
        [self creatTable];
    }
    return self;
}

/* ------------打开和创建数据库表------------ */
-(void)creatTable{
    
    NSString * Path = [NSHomeDirectory()stringByAppendingPathComponent:@"Documents/cyn.db"];
    
    _dataBase = [[FMDatabase alloc]initWithPath:Path];
    
    if ([_dataBase open]) {
        NSLog(@"数据库已经打开");
    }
    
    NSString * creatTableSql = @"create table if not exists mymanager(id integer primary key,title varchar (256),idid varchar (256),image varchar (256),original_title varchar (256),pubdate varchar (256),collect_count varchar (256),stars varchar (256),average varchar (256))";
    
    if ([_dataBase executeUpdate:creatTableSql]) {
        NSLog(@"数据库表创建成功");
    }
}

/* ------------判断是否收藏过------------ */
-(BOOL)isCollectionedWithID:(NSString *)ID{
    
    NSString * selectSql = @"select * from mymanager where idid = ?";
    
    FMResultSet * set = [_dataBase executeQuery:selectSql,ID];
    
    while ([set next]) {
        return YES;
    }
    return NO;
}

/* ---------------收藏总数--------------- */
-(NSInteger)totalCount{
    
    int i = 0;
    
    NSString * selectSql = @"select * from mymanager";
    
    FMResultSet * set = [_dataBase executeQuery:selectSql];
    
    while ([set next]) {
        i ++;
    }
    return i;
}

/* ------------添加收藏------------ */
-(void)addDic:(NSDictionary *)dic{
    
    NSString * insertSql = @"insert into mymanager (idid,title,image,original_title,pubdate,collect_count,stars,average) values (?,?,?,?,?,?,?,?)";
    
    if ([_dataBase executeUpdate:insertSql,dic[@"id"],dic[@"title"],dic[@"images"][@"medium"],dic[@"original_title"],dic[@"pubdate"],dic[@"collect_count"],dic[@"rating"][@"stars"],dic[@"rating"][@"average"]]) {
        NSLog(@"收藏成功");
    }
}

/* ----------------删除收藏---------------- */
-(void)deleteDic:(NSString *)ID1{
    
    NSString * deleteSql = @"delete from mymanager where idid = ?";
    
    if ([_dataBase executeUpdate:deleteSql,ID1]) {
        NSLog(@"取消收藏成功");
    }
}

/* ------------展示收藏------------ */
-(NSMutableArray *)insertIntoArray{
    
    NSMutableArray * data = [[NSMutableArray alloc]init];
    
    NSString * selectSql = @"select * from mymanager";
    
    FMResultSet * set = [_dataBase executeQuery:selectSql];
    
    while ([set next]) {
        
        MyModel * model = [[MyModel alloc] init];
        model.id = [set stringForColumn:@"idid"];
        model.title = [set stringForColumn:@"title"];
        model.image = [set stringForColumn:@"image"];
        model.original_title = [set stringForColumn:@"original_title"];
        model.pubdate = [set stringForColumn:@"pubdate"];
        model.collect_count = [set stringForColumn:@"collect_count"];
        model.stars = [set stringForColumn:@"stars"];
        model.average = [set stringForColumn:@"average"];
        
        [data addObject:model];
    }
    return data;
}


@end
