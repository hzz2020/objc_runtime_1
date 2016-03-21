//
//  HomeViewController.m
//  objc_runtime_001
//
//  Created by HEXSZ on 16/3/18.
//  Copyright © 2016年 DHL. All rights reserved.
//

#import "HomeViewController.h"
#import "Student.h"
#import <objc/runtime.h>

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    Student *st = [[Student alloc] init];
    [st objcMethod];
    // 实例方法
    [st learnInstance:@"learnInstance"];
    // 类方法
//    [Student learnClass:@"learnClass"];
    
    // 调用这个方法来对比一下 object_getClass(obj) 和 [self class];的不同
    [self methodCompare];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) methodCompare {
    // obj为实例对象
    id obj = [[Student alloc] init];
    // classObj为类对象
    Class classObj = [obj class];
    Class objectClass = object_getClass(obj);                //① 当obj是实例对象时 object_getClass(obj)＝＝[obj class]
    NSLog(@"当obj是实例对象时 object_getClass(obj)＝＝[obj class]");
    NSLog(@"===%@===%@===",  objectClass, classObj);
    NSLog(@"===%p===%p===",  objectClass, classObj);
    // metaClassObj为元类对象
    Class metaClassObj = object_getClass(classObj);          //② 当obj是类对象(classObj)时
    NSLog(@"当obj是类对象(classObj)时");
    NSLog(@"getClass(obj)=%@;[obj class]=%@",  metaClassObj, [classObj class]);
    NSLog(@"getClass(obj)=%p;[obj class]=%p",  metaClassObj, [classObj class]);
    // rootClassObj为根类对象
    Class rootClassObj = object_getClass(metaClassObj);      //③ 当obj是元类对象(metaClassObj)时
    NSLog(@"当obj是元类对象(metaClassObj)时");
    NSLog(@"getClass(obj)=%@;[obj class]=%@",  rootClassObj, [metaClassObj class]);
    NSLog(@"getClass(obj)=%p;[obj class]=%p",  rootClassObj, [metaClassObj class]);
    // rootMetaClassObj为根元类对象
    Class rootMetaClassObj = object_getClass(rootClassObj);  //④ 当obj是根类对象(rootClassObj)时
    NSLog(@"当obj是根类对象(rootClassObj)时");
    NSLog(@"getClass(obj)=%@;[obj class]=%@",  rootMetaClassObj, [rootClassObj class]);
    NSLog(@"getClass(obj)=%p;[obj class]=%p",  rootMetaClassObj, [rootClassObj class]);
}

@end
