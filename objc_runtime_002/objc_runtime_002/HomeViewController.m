//
//  HomeViewController.m
//  objc_runtime_002
//
//  Created by HEXSZ on 16/3/22.
//  Copyright © 2016年 大辉郎. All rights reserved.
//

#import "HomeViewController.h"
#import "Person+test.h"
#import "UIViewController+Swilzz.h"

@interface HomeViewController () {
    Person *p;
}

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    p = [[Person alloc] init];
    
    p.associateObject_retain = @"test associateObject_retain";  // 调用set方法
    NSLog(@"retain=============%@", p.associateObject_retain);  // 调用get方法
    p.associateObject_copy = @"test associateObject_copy";  // 调用set方法
    NSLog(@"copy===============%@", p.associateObject_copy);  // 调用get方法
    p.associateObject_assign = @"test associateObject_assign";  // 调用set方法
    NSLog(@"assign=============%@", p.associateObject_assign);  // 调用get方法
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
