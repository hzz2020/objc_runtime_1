//
//  Student4Forward.m
//  objc_runtime_001
//
//  Created by laolai on 2021/3/5.
//  Copyright © 2021 DHL. All rights reserved.
//

#import "Student4Forward.h"

@implementation Student4Forward

-(void) learnInstance:(NSString *) string {
    NSLog(@"Student4Forward learnInstance = %@", string);
    
}

+(void) learnClass:(NSString *) string {
    NSLog(@"Student4Forward learnClass = %@", string);
}

@end
