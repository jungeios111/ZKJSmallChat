//
//  ZKJMessage.h
//  ZKJSmartChat
//
//  Created by ZKJ on 16/7/21.
//  Copyright © 2016年 ZKJ. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    ZKJMessageTypeMe = 0,
    ZKJMessageTypeOther = 1
}ZKJMessageType;

@interface ZKJMessage : NSObject

/** 时间 */
@property(nonatomic,copy) NSString *time;
/** 消息 */
@property(nonatomic,copy) NSString *text;
/** 类型 */
@property(nonatomic,assign) ZKJMessageType type;
/** 行高 */
@property(nonatomic,assign) CGFloat cellHeight;
/** 是否隐藏时间 */
@property(nonatomic,assign,getter=isHideTime) BOOL hideTime;

+ (instancetype)messageWithDic:(NSDictionary *)dic;

@end
