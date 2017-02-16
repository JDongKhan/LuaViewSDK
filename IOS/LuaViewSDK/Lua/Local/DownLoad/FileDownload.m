//
//  FileDownload.m
//  LuaViewSDK
//
//  Created by 王金东 on 17/2/13.
//  Copyright © 2017年 王金东. All rights reserved.
//

#import "FileDownload.h"

@implementation FileDownload{
    NSMutableData *_mDataReceive;
}

- (void)down:(NSString *)down_url target_url:(NSString *)target_url {
    NSURL *fileURL = [NSURL URLWithString:target_url];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:fileURL
                                                  cachePolicy:NSURLRequestUseProtocolCachePolicy
                                              timeoutInterval:60.0];
    //创建连接，异步操作
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request
                                                                  delegate:self];
    [connection start]; //启动连接
    
}



#pragma mark - NSURLConnectionDataDelegate
- (NSURLRequest *)connection:(NSURLConnection *)connection willSendRequest:(NSURLRequest *)request redirectResponse:(NSURLResponse *)response {
    NSLog(@"即将发送请求");
    
    return request;
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    NSLog(@"已经接收到响应");
    _mDataReceive = [[NSMutableData alloc] init];
    NSDictionary *dicHeaderField = [(NSHTTPURLResponse *)response allHeaderFields];
    NSInteger totalDataLength = [[dicHeaderField objectForKey:@"Content-Length"] integerValue];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    NSLog(@"已经接收到响应数据，数据长度为%lu字节...", (unsigned long)[data length]);
    [_mDataReceive appendData:data]; //连续接收数据
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSLog(@"已经接收完所有响应数据");
    NSString *savePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    [_mDataReceive writeToFile:savePath atomically:YES];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    //如果连接超时或者连接地址错误可能就会报错
    NSLog(@"连接错误，错误信息：%@", error.localizedDescription);
}

@end
