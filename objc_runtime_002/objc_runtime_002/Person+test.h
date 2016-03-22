//
//  Person+test.h
//  objc_runtime_002
//
//  Created by HEXSZ on 16/3/22.
//  Copyright © 2016年 大辉郎. All rights reserved.
//

#import "Person.h"

@interface Person (test)

@property (nonatomic, strong) id associateObject_retain;
@property (nonatomic, copy) id associateObject_copy;
@property (nonatomic, assign) id associateObject_assign;

@end
