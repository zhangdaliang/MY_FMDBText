//
//  ZdlModel.m
//  ZDL_FMDB
//
//  Created by apple on 16/2/29.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ZdlModel.h"
#import "UIImageView+WebCache.h"
@implementation ZdlModel
-(instancetype)initWithJson:(id)node
{
    self=[super init];
    if (self) {
        self.userName=[node objectForKey:@"newsID"];
        self.text=[node objectForKey:@"title"];
        NSString *urlStr=[[[node objectForKey:@"images"] lastObject] objectForKey:@"url"];
        NSURL *imageUrl=[NSURL URLWithString:urlStr];
        self.imageData=[NSData dataWithContentsOfURL:imageUrl];
        
        
        
        
    }
    return self;
}
@end
