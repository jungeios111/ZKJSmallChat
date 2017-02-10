//
//  ZKJChatCell.m
//  ZKJSmartChat
//
//  Created by ZKJ on 16/7/21.
//  Copyright © 2016年 ZKJ. All rights reserved.
//

#import "ZKJChatCell.h"
#import "ZKJMessage.h"

@interface ZKJChatCell ()
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *otherImageView;
@property (weak, nonatomic) IBOutlet UIButton *otherBtn;
@property (weak, nonatomic) IBOutlet UIButton *meBtn;
@property (weak, nonatomic) IBOutlet UIImageView *meImageView;
@end

@implementation ZKJChatCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.meBtn.titleLabel.numberOfLines = 0;
    self.otherBtn.titleLabel.numberOfLines = 0;
}

- (void)setMessage:(ZKJMessage *)message
{
    _message = message;
    if (message.isHideTime) {
        self.timeLabel.hidden = YES;
        [self.timeLabel updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(0);
        }];
    } else {
        self.timeLabel.hidden = NO;
        self.timeLabel.text = message.time;
        [self.timeLabel updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(21);
        }];
    }
    
    if (message.type == ZKJMessageTypeMe) {
        [self showImageView:self.meImageView andShowButton:self.meBtn andHideImageView:self.otherImageView andHideButton:self.otherBtn];
    } else {
        [self showImageView:self.otherImageView andShowButton:self.otherBtn andHideImageView:self.meImageView andHideButton:self.meBtn];
    }
}

- (void)showImageView:(UIImageView *)showImageView andShowButton:(UIButton *)showButton andHideImageView:(UIImageView *)hideImageView andHideButton:(UIButton *)hideButton
{
    hideImageView.hidden = YES;
    hideButton.hidden = YES;
    
    showImageView.hidden = NO;
    showButton.hidden = NO;
    [showButton setTitle:self.message.text forState:UIControlStateNormal];
    
    [self layoutIfNeeded];
    
//    CGFloat titleH = showButton.titleLabel.frame.size.height;
//    NSLog(@"titleH:%f",titleH);
//    CGFloat showBtnH = showButton.frame.size.height;
//    NSLog(@"showBtnH:%f",showBtnH);
    
    [showButton updateConstraints:^(MASConstraintMaker *make) {
        CGFloat buttonH = showButton.titleLabel.frame.size.height + 30;
        make.height.equalTo(buttonH);
    }];
    
    
    [self layoutIfNeeded];
    
    CGFloat imgH = CGRectGetMaxY(showImageView.frame);
    CGFloat btnH = CGRectGetMaxY(showButton.frame);
    self.message.cellHeight = MAX(imgH, btnH) + 10;
}

@end
