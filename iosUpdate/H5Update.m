//
//  H5Update.m
//  iosUpdate
//
//  Created by 高志强 on 2017/1/4.
//  Copyright © 2017年 高志强. All rights reserved.
//

#import "H5Update.h"
#import "ZipArchive.h"
#import "AFNetworking.h"
@interface H5Update ()
{
    NSString *fileName;
    NSString *folderName;
    NSFileManager *fm;
    NSString *dcoumentpath;
}
@end
@implementation H5Update
-(void) check{
    fileName=@"ztxH5.zip";
    folderName=@"/h5";
    fm=[NSFileManager defaultManager];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    dcoumentpath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
    [fm removeItemAtPath:[dcoumentpath stringByAppendingString:folderName] error:nil];
    //1.创建管理者对象
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //2.确定请求的URL地址
    NSURL *url = [NSURL URLWithString:@"http://192.168.1.102"];
    //3.创建请求对象
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    //下载任务
    NSURLSessionDownloadTask *task = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        //打印下下载进度
        NSLog(@"%lf",1.0 * downloadProgress.completedUnitCount / downloadProgress.totalUnitCount);
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        // 告诉服务器下载的文本保存的位置在那里
        NSURL *documentsDirectoryURL = [fm URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        
        return [documentsDirectoryURL URLByAppendingPathComponent:fileName];
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        
        //下载完成调用的方法
        ZipArchive* zip = [[ZipArchive alloc] init];
        
        NSString* l_zipfile = [NSString stringWithFormat:@"%@/%@",dcoumentpath,fileName];
        NSString* unzipto = [dcoumentpath stringByAppendingString:folderName] ;
        if( [zip UnzipOpenFile:l_zipfile] ) {
            BOOL ret = [zip UnzipFileTo:unzipto overWrite:YES];
            if( NO==ret ) {
            }else{
                [fm removeItemAtPath:l_zipfile error:nil];            }
            [zip UnzipCloseFile];
        }
    }];
    
    //开始启动任务
    [task resume];
};

@end
