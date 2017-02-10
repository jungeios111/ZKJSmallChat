//
//  ZKJMessage.m
//  ZKJSmartChat
//
//  Created by ZKJ on 16/7/21.
//  Copyright © 2016年 ZKJ. All rights reserved.
//

#import "ZKJMessage.h"

@implementation ZKJMessage

+ (instancetype)messageWithDic:(NSDictionary *)dic
{
    ZKJMessage *message = [[self alloc] init];
    [message setValuesForKeysWithDictionary:dic];
    return message;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    NSLog(@"%@ is not found!",key);
}

@end
