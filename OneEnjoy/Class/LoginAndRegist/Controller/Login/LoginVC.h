//
//  LoginVC.h
//  OneEnjoy
//
//  Created by 吴 on 2018/10/15.
//  Copyright © 2018年 YiChenTec. All rights reserved.
//

#import "BaseKeyBoardViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface LoginVC : BaseKeyBoardViewController

@property (nonatomic, copy) NSString *identifierString;
@property (nonatomic, assign) BOOL isPush;
@property (nonatomic, assign) BOOL isChangePassword;

@end

NS_ASSUME_NONNULL_END
