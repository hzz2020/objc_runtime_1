//
//  HomeViewController.m
//  objc_runtime_001
//
//  Created by HEXSZ on 16/3/18.
//  Copyright © 2016年 DHL. All rights reserved.
//

#import "HomeViewController.h"
#import "Student.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    Student *st = [[Student alloc] init];
    [st getVarNameAndType];
    // 实例方法
    [st learnInstance:@"learnInstance"];
    
    // 类方法
//    [Student learnClass:@"learnClass"];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
