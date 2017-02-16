//
//  ZKJChatVC.m
//  ZKJSmartChat
//
//  Created by ZKJ on 16/7/21.
//  Copyright © 2016年 ZKJ. All rights reserved.
//

#import "ZKJChatVC.h"
#import "ZKJChatCell.h"
#import "ZKJMessage.h"

@interface ZKJChatVC () <UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) NSMutableArray *messageArray;
@property (strong, nonatomic) IBOutlet UITextField *messageTF;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *bottomSpace;
@end

@implementation ZKJChatVC

- (NSMutableArray *)messageArray
{
    if (!_messageArray) {
        NSArray *array = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"messages.plist" ofType:nil]];
        _messageArray = [NSMutableArray array];
        ZKJMessage *lastMessage = nil;
        for (NSDictionary *dic in array) {
            ZKJMessage *message = [ZKJMessage messageWithDic:dic];
            message.hideTime = [message.time isEqualToString:lastMessage.time];
            [_messageArray addObject:message];
            lastMessage = message;
        }
    }
    return _messageArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *view = [[UIView alloc] init];
    view.frame = CGRectMake(0, 0, 5, 0);
    self.messageTF.leftView = view;
    self.messageTF.leftViewMode = UITextFieldViewModeAlways;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick)];
    tap.numberOfTouchesRequired = 1;
    [self.tableView addGestureRecognizer:tap];
    
    // 1.监听键盘弹出和收回
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardFrameChanged:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (void)keyboardFrameChanged:(NSNotification *)info
{
    ZKJLog(@"%@",info.userInfo);
    double time = [info.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGRect rect = [info.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat transValue = [UIScreen mainScreen].bounds.size.height - rect.origin.y;
    [UIView animateWithDuration:time animations:^{
        self.view.transform = CGAffineTransformMakeTranslation(0, -transValue);
    }];
}

- (void)tapClick
{
    [self.messageTF resignFirstResponder];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

#pragma mark - UITableViewDelegateAndUITableViewDataSoruce
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.messageArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZKJChatCell *cell = [tableView dequeueReusableCellWithIdentifier:@"message"];
    cell.message = self.messageArray[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 200;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZKJMessage *message = self.messageArray[indexPath.row];
    return message.cellHeight;
}


@end
