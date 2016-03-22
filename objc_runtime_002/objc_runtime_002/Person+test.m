//
//  Person+test.m
//  objc_runtime_002
//
//  Created by HEXSZ on 16/3/22.
//  Copyright © 2016年 大辉郎. All rights reserved.
//

#import "Person+test.h"
#import <objc/runtime.h>

@implementation Person (test)

-(void) setAssociateObject_retain:(id)associateObject_retain {
    objc_setAssociatedObject(self, @selector(associateObject_retain), associateObject_retain,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(id) associateObject_retain {
    return objc_getAssociatedObject(self, _cmd);
}


-(void) setAssociateObject_assign:(id)associateObject_assign {
    objc_setAssociatedObject(self, @selector(associateObject_assign), associateObject_assign, OBJC_ASSOCIATION_ASSIGN);
}

-(id) associateObject_assign {
    return objc_getAssociatedObject(self, _cmd);
}


-(void) setAssociateObject_copy:(id)associateObject_copy {
    objc_setAssociatedObject(self, @selector(associateObject_copy), associateObject_copy, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

-(id) associateObject_copy {
     return objc_getAssociatedObject(self, _cmd);
}


@end
