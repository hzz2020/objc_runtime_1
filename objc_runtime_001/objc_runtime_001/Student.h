//
//  Student.h
//  objc_runtime_001
//
//  Created by HEXSZ on 16/3/18.
//  Copyright © 2016年 DHL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"

@interface Student : Person {
    // 私有变量
    NSString *name;
    int age;
}
// 属性
@property (nonatomic, copy) NSString *sex;

// objc的一些方法 如class_copyIvarList和class_copyPropertyList
-(void) objcMethod;

// 实例(-)方法
-(void) learnInstance:(NSString *)string;

// 类(+)方法
+(void) learnClass:(NSString *) string;


@end
