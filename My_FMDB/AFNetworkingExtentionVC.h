//
//  AFNetworkingExtentionVC.h
//  AFNetWorking+Extention
//
//  Created by 雷传营 on 16/1/8.
//  Copyright © 2016年 leichuanying. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFNetworking.h"
@interface AFNetworkingExtentionVC : UIViewController
+(AFNetworkingExtentionVC *)sharedManager;
/**
 *  发送一个GET请求
 *
 *  @param url     请求路径
 *  @param params  请求参数
 *  @param success 请求成功后的回调（请将请求成功后想做的事情写到这个block中）
 *  @param failure 请求失败后的回调（请将请求失败后想做的事情写到这个block中）
 */
-(void)get:(NSString *)url params:(NSDictionary *)params success:(void (^)(id responseObj))success failure:(void (^)(NSError *error))failure;
/**
 *  发送一个POST请求
 *
 *  @param url     请求路径
 *  @param params  请求参数
 *  @param success 请求成功后的回调（请将请求成功后想做的事情写到这个block中）
 *  @param failure 请求失败后的回调（请将请求失败后想做的事情写到这个block中）
 */
//+ (void)post:(NSString *)url params:(NSDictionary *)params success:(void (^)(id responseObj))success failure:(void (^)(NSError *error))failure;



/**
 *  发送一个POST请求
 *
 *  @param url     请求路径
 *  @param params  请求参数
 *  @param formdata追加数据的回调  （请将追加的其他格式数据写到这个block中）
 *  @param progress请求进程的回调  （请将进程的事情写到这个block中）
 *  @param success 请求成功后的回调（请将请求成功后想做的事情写到这个block中）
 *  @param failure 请求失败后的回调（请将请求失败后想做的事情写到这个block中）
 */

- (void)httpPost:(NSString *)url parameters:(NSDictionary *)parameters formdata:(void(^)(id<AFMultipartFormData>formdata))formdata  progress:(void(^)(NSProgress *uploadProgress))progress success:(void (^)(id responseObj))success failure:(void (^)(NSError *error))failure;


@end
