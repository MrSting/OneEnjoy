//
//  OneEnjoyVC.m
//  OneEnjoy
//
//  Created by 吴 on 2018/10/15.
//  Copyright © 2018年 YiChenTec. All rights reserved.
//

#import "OneEnjoyVC.h"

@interface OneEnjoyVC ()

@property (weak, nonatomic) IBOutlet UIImageView *categoryImageView1;
@property (weak, nonatomic) IBOutlet UILabel *categoryLabel1;
@property (weak, nonatomic) IBOutlet UIImageView *categoryImageView2;
@property (weak, nonatomic) IBOutlet UILabel *categoryLabel2;
@property (weak, nonatomic) IBOutlet UIImageView *categoryImageView3;
@property (weak, nonatomic) IBOutlet UILabel *categoryLabel3;
@property (weak, nonatomic) IBOutlet UIImageView *categoryImageView4;
@property (weak, nonatomic) IBOutlet UILabel *categoryLabel4;

@end

@implementation OneEnjoyVC

#pragma mark - LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createUserInterface];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

#pragma mark - UIResponse & Event

- (IBAction)categoryBtnClick:(UIButton *)sender {
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

#pragma mark - UITabelViewDelegate & DataSource


#pragma mark - PrivateMethod

- (void)createUserInterface {
    [self createNavigationBar];
}

- (void)createNavigationBar {
    
}

#pragma mark - Set & Get

@end
