//
//  Student.h
//  objc_runtime_001
//
//  Created by HEXSZ on 16/3/18.
//  Copyright © 2016年 DHL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Student : NSObject {
    NSString *other;
}
// 属性
@property (nonatomic, assign) long cid;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) int age;
@property (nonatomic, copy) NSString *sex;

// 方法
-(void) objcMethod;        //

-(void) learnInstance:(NSString *)string;

+(void) learnClass:(NSString *) string;



@end
