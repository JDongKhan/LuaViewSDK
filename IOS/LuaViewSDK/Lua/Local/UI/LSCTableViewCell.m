//
//  LSCTableViewCell.m
//  LuaViewSDK
//
//  Created by 王金东 on 17/2/3.
//  Copyright © 2017年 王金东. All rights reserved.
//

#import "LSCTableViewCell.h"
#import "LuaTableViewCell.h"
#import <tableViewSimplify/UITableViewCell+simplify.h>

@interface LSCTableViewCell ()

@property (nonatomic,strong) LuaTableViewCell *cell;

@end
@implementation LSCTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier
                      luaName:(NSString *)luaName
            luaViewController:(LuaViewController *)vc {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.cell = [[LuaTableViewCell alloc] init];
        self.cell.vc = vc;
        self.cell.luaName = luaName;
        [self.cell _onCreate];
        self.cell.contentView._view.frame = self.contentView.bounds;
        self.cell.contentView._view.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        [self.contentView addSubview:self.cell.contentView._view];
    }
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (CGFloat)tableView:(UITableView *)tableView cellInfo:(id)dataInfo {
    return [self.cell tableViewCellHeight:dataInfo];
}

- (void)setDataInfo:(id)dataInfo{
    self.cell.dataSource = dataInfo;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
