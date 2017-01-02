//
//  ViewController.m
//  update
//
//  Created by 高志强 on 2016/12/29.
//  Copyright © 2016年 高志强. All rights reserved.
//

#import "ViewController.h"
#import "ZipArchive.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    ZipArchive* zip = [[ZipArchive alloc] init];
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
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
