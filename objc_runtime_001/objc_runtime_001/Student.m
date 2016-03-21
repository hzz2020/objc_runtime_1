//
//  Student.m
//  objc_runtime_001
//
//  Created by HEXSZ on 16/3/18.
//  Copyright © 2016年 DHL. All rights reserved.
//

#import "Student.h"
#import "StudentForward.h"
#import <objc/runtime.h>

@implementation Student 

#pragma mark - 获取实例变量和property属性
-(void) objcMethod {
    //******************class_copyIvarList()来回去实例对象的property属性+实例变量*******************//
    unsigned int numIvars = 0;
    NSString *key=nil;
//    id StudentClass = objc_getClass("Student");
    Ivar * ivars = class_copyIvarList([self class], &numIvars);
    for(int i = 0; i < numIvars; i++) {
        Ivar thisIvar = ivars[i];
//        const char *type = ivar_getTypeEncoding(thisIvar); // 获取类型
//        NSString *stringType =  [NSString stringWithCString:type encoding:NSUTF8StringEncoding]; // 获取类型
        key = [NSString stringWithUTF8String:ivar_getName(thisIvar)];
        NSLog(@"key = %@",key);
    }
    free(ivars);
    
    //*********************class_copyPropertyList()来获取实例对象的property属性**********************//
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    for (i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        fprintf(stdout, "%s %s\n", property_getName(property), property_getAttributes(property));
    }
    free(properties);
}

//#pragma mark - ①默认方式 即消息的接收者能够找到对应的selector，那么就直接执行接收者这个对象的特定方法
//// 实例Method
//-(void) learnInstance:(NSString *)string{
//    NSLog(@"learnInstance = %@", string);
//}
//// 类Method
//+(void) learnClass:(NSString *) string {
//    NSLog(@"learnClass = %@", string);
//}

//#pragma mark - ②消息转发 resolveInstanceMethod
//// 针对实例方法
//+(BOOL) resolveInstanceMethod:(SEL)sel {
//    if (sel == @selector(learnInstance:)) {
//       BOOL addMethod = class_addMethod([self class], sel, class_getMethodImplementation([self class], @selector(myInstanceMethod:)), "v@:");
//        return addMethod;
//    }
//    return [super resolveInstanceMethod:sel];
//}
//
//-(void) myInstanceMethod:(NSString *)string {
//    NSLog(@"myInstanceMethod = %@", string);
//}
//
//#pragma mark - ②消息转发resolveClassMethod
//// 针对类方法
//+(BOOL) resolveClassMethod:(SEL)sel {
//    if (sel == @selector(learnClass:)) {
//        // 此处注意 object_getClass(obj) 和 [self class]的区别;
//        class_addMethod(object_getClass(self), sel, class_getMethodImplementation(object_getClass(self), @selector(myClassMethod:)), "v@:");
//        return YES;
//    }
//    return [super resolveClassMethod:sel];
//}
//
//// 这里也要是类(+)方法
//+(void) myClassMethod:(NSString *)string {
//    NSLog(@"myClassMethod = %@", string);
//}


//#pragma mark - ③重定向 forwardingTargetForSelector 对实例方法
//-(id)forwardingTargetForSelector:(SEL)aSelector {
//    if (aSelector == @selector(learnInstance:)) {
//        return [[StudentForward alloc] init];
//    }
//    return [super forwardingTargetForSelector:aSelector];
//}

#pragma mark - ④转发 forwardInvocation
-(NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    NSMethodSignature *methodSignature = [super methodSignatureForSelector:aSelector];
    if (!methodSignature) {
        methodSignature = [NSMethodSignature signatureWithObjCTypes:"v@:*"];
    }
    
    return methodSignature;
}

-(void)forwardInvocation:(NSInvocation *)anInvocation {
     StudentForward *stfd = [[StudentForward alloc] init];
    if ([stfd respondsToSelector:[anInvocation selector]]){
        [anInvocation invokeWithTarget:stfd];
    } else {
        [super forwardInvocation:anInvocation];
    }
}


@end
