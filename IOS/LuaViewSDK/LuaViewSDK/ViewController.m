//
//  ViewController.m
//  LuaViewSDK
//
//  Created by 王金东 on 17/1/17.
//  Copyright © 2017年 王金东. All rights reserved.
//

#import "ViewController.h"
#import "LuaNavigationController.h"

@interface ViewController (){
    LuaNavigationController *_nav;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _nav = [[LuaNavigationController alloc] initWithRootViewController:self];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)nextAction:(id)sender {
    [_nav pushLuaView:@"list.lua"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
