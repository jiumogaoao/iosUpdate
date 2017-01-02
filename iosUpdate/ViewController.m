//
//  ViewController.m
//  update
//
//  Created by 高志强 on 2016/12/29.
//  Copyright © 2016年 高志强. All rights reserved.
//

#import "ViewController.h"
#import "ZipArchive.h"
#import "AFNetworking.h"
#import "UIKit+AFNetworking.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    /*ZipArchive* zip = [[ZipArchive alloc] init];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *dcoumentpath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
    NSLog(@"%@", dcoumentpath);
    NSString* l_zipfile = [dcoumentpath stringByAppendingString:@"/2.zip"] ;
    NSString* unzipto = [dcoumentpath stringByAppendingString:@"/test"] ;
    if( [zip UnzipOpenFile:l_zipfile] ) {
        BOOL ret = [zip UnzipFileTo:unzipto overWrite:YES];
        if( NO==ret ) {
            NSLog(@"没解压");
        }else{
            NSLog(@"已解压");
        }
        [zip UnzipCloseFile];
    }
    //  [zip release];
     */
    //1.创建管理者对象
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //2.确定请求的URL地址
    NSURL *url = [NSURL URLWithString:@"http://192.168.1.102/down/2.zip"];
    
    //3.创建请求对象
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    //下载任务
    NSURLSessionDownloadTask *task = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        //打印下下载进度
        NSLog(@"%lf",1.0 * downloadProgress.completedUnitCount / downloadProgress.totalUnitCount);
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        //下载地址
        NSString *cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
        NSString *path = [cachesPath stringByAppendingPathComponent:response.suggestedFilename];
        NSLog(@"下载地址:%@",path);
        return [NSURL URLWithString:path];
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        
        //下载完成调用的方法
        NSLog(@"下载完成：");
        NSLog(@"%@--%@",response,filePath);
    }];
    
    //开始启动任务
    [task resume];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
