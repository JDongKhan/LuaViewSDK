//
//  LSCTableViewCell.h
//  LuaViewSDK
//
//  Created by 王金东 on 17/2/3.
//  Copyright © 2017年 王金东. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LuaViewController;

@interface LSCTableViewCell : UITableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier
                      luaName:(NSString *)luaName
            luaViewController:(LuaViewController *)vc;



@end
