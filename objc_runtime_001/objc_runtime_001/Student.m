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

@interface Student ()

@end

@implementation Student

- (id)init
{
    if (self = [super init])
    {
        NSLog(@"self class = %@", NSStringFromClass([self class]));
        NSLog(@"super class = %@", NSStringFromClass([super class]));
        // 这里会同时输出Student;  因为super是编译器标识符 会调用objc_msgSendSuper(objc_super, class);
        // objc_super里包含了 一个id receiver（指的self）和Super class
    }
    return self;
}

- (NSString *)description {
    NSString *des = [NSString stringWithFormat:@"<%@:%p>,name=%@, age=%d, sex=%@", [self class], [self class], name, age, _sex];
    return des;
}

+(void) objcMethod2 {
    NSLog(@"errr");
}

#pragma mark - class_copyIvarList 和 class_copyPropertyList
-(void) objcMethod {
    //*****方法 class_copyIvarList() 来取出 实例对象的property实例变量和带下划线的属性*******************//
    unsigned int numIvars = 0;
    NSString *key=nil;
    Ivar * ivars = class_copyIvarList([self class], &numIvars);
    for(int i = 0; i < numIvars; i++) {
        Ivar thisIvar = ivars[i];
        const char *type = ivar_getTypeEncoding(thisIvar); // 获取类型
        NSString *stringType =  [NSString stringWithCString:type encoding:NSUTF8StringEncoding]; // 获取类型
        key = [NSString stringWithUTF8String:ivar_getName(thisIvar)];
        NSLog(@"type = %@ key = %@", stringType, key);
    }
    free(ivars);
    
    //*****方法 class_copyPropertyList()来获取实例对象的property属性（不带下划线）**********************//
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    for (i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        fprintf(stdout, "%s %s\n", property_getName(property), property_getAttributes(property));
    }
    free(properties);
    
    
    //*****方法 class_copyMethodList()来获取实例方法列表**********************//
    unsigned int methodCount;
    Method *methods = class_copyMethodList([self class], &methodCount);  // 获取实例方法
//    Method *methods = class_copyMethodList(object_getClass([self class]), &methodCount); // 获取类方法
    for (i = 0; i < methodCount; i++) {
        Method thisMethod = methods[i];
        SEL methodSEL = method_getName(thisMethod);
        const char *selName = sel_getName(methodSEL);
        if (methodSEL) {
            NSLog(@"sel------%s", selName);
        }
    }
    free(methods);
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
//        // 此处注意 object_getClass(self) 和 [self class]的区别;
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
