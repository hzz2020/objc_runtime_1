//
//  UIViewController+Swilzz.m
//  objc_runtime_002
//
//  Created by HEXSZ on 16/3/22.
//  Copyright © 2016年 大辉郎. All rights reserved.
//

#import "UIViewController+Swilzz.h"
#import <objc/runtime.h>

@implementation UIViewController (Swilzz)

+(void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        SEL originSelector = @selector(viewWillAppear:);
        SEL nowginSelector = @selector(swilzz_wiewWillAppear:);
        
        // 实例方法
        Class aClass = [self class];
        Method originMethod = class_getInstanceMethod(aClass, originSelector);
        Method nowginMethod = class_getInstanceMethod(aClass, nowginSelector);
        
        // 类方法
//        Class aClass = object_getClass([self class]);
//        Method originMethod = class_getInstanceMethod(aClass, originSelector);
//        Method nowginMethod = class_getInstanceMethod(aClass, nowginSelector);
        BOOL addMethod = class_addMethod(aClass,
                                         originSelector,
                                         method_getImplementation(nowginMethod),
                                         method_getTypeEncoding(nowginMethod));
        
        if (addMethod) {
            class_replaceMethod(aClass,
                                nowginSelector,
                                method_getImplementation(originMethod),
                                method_getTypeEncoding(originMethod));
        } else {
            method_exchangeImplementations(originMethod, nowginMethod);
        }
    });
}

-(void)swilzz_wiewWillAppear:(BOOL)animated {
    [self swilzz_wiewWillAppear:animated];
    NSLog(@"self = %@", self);
    
}

@end
