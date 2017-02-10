//
//  ZKJChatCell.h
//  ZKJSmartChat
//
//  Created by ZKJ on 16/7/21.
//  Copyright © 2016年 ZKJ. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZKJMessage;

@interface ZKJChatCell : UITableViewCell

/** 数据模型 */
@property(nonatomic,strong) ZKJMessage *message;

@end
