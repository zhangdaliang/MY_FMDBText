//
//  FMDBManager.h
//  ZDL_FMDB
//
//  Created by apple on 16/2/29.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDB.h"

@interface FMDBManager : NSObject
@property(nonatomic,strong)FMDatabase *fmdb;
+(FMDBManager *)shareManager;
-(void)creatTableWithName:(NSString *)tableName;

@end
