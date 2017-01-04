//
//  ViewController.m
//  update
//
//  Created by 高志强 on 2016/12/29.
//  Copyright © 2016年 高志强. All rights reserved.
//

#import "ViewController.h"
#import "H5Update.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[H5Update alloc] check];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
