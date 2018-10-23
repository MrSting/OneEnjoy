//
//  OneEnjoyActivityCell.h
//  OneEnjoy
//
//  Created by 吴 on 2018/10/19.
//  Copyright © 2018年 YiChenTec. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface OneEnjoyActivityCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *titleImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
@property (weak, nonatomic) IBOutlet UIButton *clickRateBtn;
@property (weak, nonatomic) IBOutlet UIButton *bargainCountBtn;
@property (weak, nonatomic) IBOutlet UILabel *currentPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *originalPriceLabel;

@end

NS_ASSUME_NONNULL_END
