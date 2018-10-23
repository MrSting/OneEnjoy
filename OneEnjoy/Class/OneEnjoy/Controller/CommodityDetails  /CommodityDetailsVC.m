//
//  CommodityDetailsVC.m
//  OneEnjoy
//
//  Created by 吴 on 2018/10/22.
//  Copyright © 2018 YiChenTec. All rights reserved.
//

#import "CommodityDetailsVC.h"

@interface CommodityDetailsVC ()

@end

@implementation CommodityDetailsVC

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

#pragma mark - PrivateMethod

- (void)createUserInterface {
    [self createNavigationBar];
}

- (void)createNavigationBar {
    
}

#pragma mark - Set & Get

@end
