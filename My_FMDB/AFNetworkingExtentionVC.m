//
//  AFNetworkingExtentionVC.m
//  AFNetWorking+Extention
//
//  Created by 雷传营 on 16/1/8.
//  Copyright © 2016年 leichuanying. All rights reserved.
//

#import "AFNetworkingExtentionVC.h"


@implementation AFNetworkingExtentionVC
+(AFNetworkingExtentionVC *)sharedManager
{
    static AFNetworkingExtentionVC *af=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        af=[[AFNetworkingExtentionVC alloc]init];
    });
    return af;
}
-(void)get:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    
    // 1.获得请求管理者
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
      mgr.responseSerializer = [AFHTTPResponseSerializer serializer];

    // 2.发送GET请求
    [mgr GET:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"zzzz");

        if (success) {
            success(responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (failure) {
            NSLog(@"hhhhh");
            failure(error);
        }
        
    }];
    
    
}
//
//+ (void)post:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure
//{
//    // 1.获得请求管理者
//    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
//    mgr.responseSerializer = [AFJSONResponseSerializer serializer];
//    
//    // 2.发送POST请求
//    [mgr POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//        
//    } progress:^(NSProgress * _Nonnull uploadProgress) {
//        
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        
//        if (success) {
//            success(responseObject);
//        }
//        
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        
//        if (failure) {
//            failure(error);
//        }
//        
//    }];
//    
//}


//http post  请求
-(void)httpPost:(NSString *)url parameters:(NSDictionary *)parameters formdata:(void (^)(id<AFMultipartFormData>))formdata progress:(void (^)(NSProgress *))progress success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
 
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        if (formdata)
        {
            formdata(formData);
        }
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        if (progress)
        {
            progress(uploadProgress);
        }
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (success)
        {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    
        if (failure)
        {
            failure(error);
        }
    }];

}



@end
