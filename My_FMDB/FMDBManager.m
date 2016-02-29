//
//  FMDBManager.m
//  ZDL_FMDB
//
//  Created by apple on 16/2/29.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "FMDBManager.h"
@implementation FMDBManager
-(instancetype)init
{
    self=[super init];
    if (self) {
        NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/NYFZ.sqlite"];
        
        _fmdb=[FMDatabase databaseWithPath:path];
        BOOL isend=[_fmdb open];
        if (isend) {
            NSLog(@"打开成功");
        }else{
            NSLog(@"打开失败");
    }
    }
    
    return self;
}
+(FMDBManager *)shareManager
{
    static FMDBManager *db=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        db=[[FMDBManager alloc]init];
    });
    return db;
}
-(void)creatTableWithName:(NSString *)tableName
{
  NSString *createSql = [NSString stringWithFormat:@"create table if not exists %@",tableName];
    //执行更新操作（增删改都属于更新）
    BOOL isCreate = [_fmdb executeUpdate:createSql];
    
    if (!isCreate) {
        NSLog(@"%@",_fmdb.lastErrorMessage);
    }else{
        NSLog(@"创建表成功");
    }
    
}
@end
