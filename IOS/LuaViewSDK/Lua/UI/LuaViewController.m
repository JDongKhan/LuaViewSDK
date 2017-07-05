//
//  LuaViewController.m
//  LuaView
//
//  Created by 王金东 on 17/1/16.
//  Copyright © 2017年 wangjindong. All rights reserved.
//

#import "LuaViewController.h"
#import "LuaScriptCoreManager.h"
#import "UIColorUtil.h"
#import "LuaView.h"
#import "LuaConsole.h"
#import "Bundle.h"


@interface LuaViewController ()

@property (nonatomic, strong) UIViewController *viewController;

@property (nonatomic, strong) LuaView *luaView;

@property (nonatomic, strong) LSCFunction *rightClickFunction;

@end

@implementation LuaViewController

- (instancetype)initWithViewController:(UIViewController *)viewController {
    if (self == [super init]) {
        _luaView = [[LuaView alloc] init];
        _luaView.vc = self;
        _viewController = viewController;
        //TODO 此处请用约束
        self.luaView._view.frame = _viewController.view.bounds;
        self.luaView._view.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        [self.luaView _layout];
        [_viewController.view addSubview:self.luaView._view];
    }
    return self;
}

- (instancetype)init {
    if (self == [super init]) {
        _luaView = [[LuaView alloc] init];
    }
    return self;
}


- (void)setNavigationBackgroundColor:(NSString *)color {
    
}

- (void)setTitle:(NSString *)title {
    _viewController.title = title;
}

- (void)setTitleColor:(NSString *)color {
    
}
- (void)setBackTitle:(NSString *)title {
    _viewController.navigationItem.leftBarButtonItem.title = title;
}
- (void)setBackTitleColor:(NSString *)color {
    
}

- (void)addMenu:(NSString *)title click:(LSCFunction *)click {
    self.rightClickFunction = click;
    _viewController.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:self action:@selector(rightClick:)];
}
- (void)rightClick:(id)sender{
    //TODO
    NSArray *p = @[[LSCValue objectValue:sender]];
    [self.rightClickFunction invokeWithArguments:p];
}
- (void)removeMenus {
    _viewController.navigationItem.rightBarButtonItem = nil;
}



- (void)setLuaName:(NSString *)luaName {
    _luaName = luaName;
    NSString *fileString =  [Bundle luaScript:luaName];
    
    NSString *methodName = [NSString stringWithFormat:@"%@_%ld",[[luaName lastPathComponent] stringByDeletingPathExtension],[self hash]];
    NSString *luaScript = [NSString stringWithFormat:@"function %@(this,request) %@ end",methodName,fileString];
    [[LuaScriptCoreManager shareInstance] evalScriptFromString:luaScript];
    NSMutableArray *param = [NSMutableArray array];
    [param addObject:[LSCValue objectValue:self]];
    if (self.params != nil) {
        [param addObject:[LSCValue dictionaryValue:self.params]];
    }
    [[LuaScriptCoreManager shareInstance] callMethodWithName:methodName arguments:param];
}

- (void)setBackgroundColor:(NSString *)backgroundColor {
    _backgroundColor = backgroundColor;
    self.luaView._view.backgroundColor = [UIColorUtil colorWithHexString:backgroundColor];
}

- (void)addSubView:(LuaView *)subView {
    [_luaView addSubView:subView];
}

- (void)removeSubView:(LuaView *)subView{
    [_luaView removeSubView:subView];
}

- (void)pushLuaView:(NSString *)luaName param:(NSDictionary *)params {
    if([params isKindOfClass:[NSNull class]]){
        params = nil;
    }
    [self.navigationController pushLuaView:luaName param:params];
}
- (void)hideNavigationBar {
    _viewController.navigationController.navigationBarHidden = YES;
}
- (void)showNavigationBar {
    _viewController.navigationController.navigationBarHidden = NO;
}
@end
