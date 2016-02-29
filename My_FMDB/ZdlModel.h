//
//  ZdlModel.h
//  ZDL_FMDB
//
//  Created by apple on 16/2/29.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZdlModel : NSObject
@property(nonatomic,strong)NSString *userName;
@property(nonatomic,strong)NSData *imageData;
@property(nonatomic,strong)NSString *text;
-(instancetype)initWithJson:(id)node;
@end
