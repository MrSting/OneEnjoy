//
//  OneEnjoySelectionCell.m
//  OneEnjoy
//
//  Created by 吴 on 2018/10/18.
//  Copyright © 2018年 YiChenTec. All rights reserved.
//

#import "OneEnjoySelectionCell.h"

@implementation OneEnjoySelectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - UIResponse & Event

- (IBAction)buttonDidClick:(UIButton *)sender {
    switch (sender.tag) {
        case 10:{
            
        }
            break;
        case 20:{
            
        }
            break;
        case 30:{
            
        }
            break;
        case 40:{
            
        }
            break;
        default:
            break;
    }
}


@end

