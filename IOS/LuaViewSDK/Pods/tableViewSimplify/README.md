# tableViewSimplify


对tableview的拓展，通过数据源控制、显示，不用实现一行委托类，当然你可以根据自己的喜好用委托类来实现也行！
tableview用的最多，对tableview的玩法是对tableview的数据结构操作即可！
设计理念：程序由算法和数据结构组成，那么算法只负责逻辑，所有可能来源均有数据结构提供！

该方法支持在数据里面增加tableview的选择事件，默认的cell样式、accessoryView,block等等！


如果你有好的建议请联系我:419591321@qq.com,其实自己仔细琢磨更有意思！

简单使用 pod 'tableivewSimplify'

例子:

### 第一种
----------------------------------- 
```c
self.tableView.itemsArray = @[
        @"第一条",
        @"第二条",
        @"第3条",
        @"第4条",
        @"第5条",
        @"第6条",
        @"第7条",
        @"第8条",
        @"第9条",
        @"第10条",
        @"第11条"
        ].mutableCopy;
```
###第二种 可支持自定义model
-----------------------------------
```c
self.secondTableView.keyForTitleView = @"title";
self.secondTableView.itemsArray = @[
                                @{
                                    @"title" : @"第一"
                                },
                                @{
                                    @"title" : @"第二"
                                },
                                @{
                                    @"title" : @"第仨"
                                }
                        ].mutableCopy;
```

###第三种 支持数组 可支持自定义model
-----------------------------------
```c
self.thirdTableView.keyOfHeadTitle = @"title";
//可以不配置 有默认值
self.thirdTableView.keyForTitleView = @"title";
self.thirdTableView.keyForDetailView = @"detail";
self.thirdTableView.keyOfItemArray = @"items";

self.thirdTableView.sectionable = YES;
self.thirdTableView.tableViewCellClass = [HsBaseTableViewCellStyleValue1 class];
self.thirdTableView.itemsArray = @[
@{
    @"title" : @"人",
    @"items" : @[
    @{
        @"title" : @"美女",
        @"detail" : @"很漂亮"
    },
    @{
        @"title" : @"帅哥",
        @"detail" : @"大长腿"
    }
    ]
},
@{
    @"title" : @"第二",
    @"items" : @[
    @{
        @"title" : @"美女",
        @"detail" : @"很漂亮"
    },
    @{
        @"title" : @"帅哥",
        @"detail" : @"大长腿"
    }
    ]
},
@{
    @"title" : @"第仨",
    @"items" : @[
    @{
        @"title" : @"美女",
        @"detail" : @"很漂亮"
    },
    @{
        @"title" : @"帅哥",
        @"detail" : @"大长腿"
    }
    ]
}
].mutableCopy;
```

__weak UIViewController *weakSelf = self;
###第四种 支持数组 自定义model group样式 cell自定义(model只要key对应上即可，跟字典一样的)
-----------------------------------
```c
self.forthTableView.keyOfHeadTitle = @"title";
self.forthTableView.autoLayout = YES;
self.forthTableView.sectionable = YES;
self.forthTableView.baseDataSource = self;
self.forthTableView.tableViewCellArray = @[
[UINib nibWithNibName:@"TableViewDemoCell" bundle:nil],
[HsBaseTableViewCellStyleValue1 class]
];
self.forthTableView.itemsArray = @[
@{
    @"title" : @"人",
    @"items" : @[
        [User user:@"张三1" sex:@"男"],
        [User user:@"张三2" sex:@"男"]
    ]
},
@{
    @"title" : @"第二",
    @"items" : @[
    @{
    @"title" : @"美女",
    @"detail" : @"很漂亮",
    HsCellKeySelectedBlock : ^(NSIndexPath *indexPath){
        [weakSelf.navigationController pushViewController:[[HsRefreshTableViewController alloc] init] animated:YES];
        NSLog(@"选中第%ld行",indexPath.row);
    },
    HsBaseTableViewKeyTypeForRow : @(1)//等同于下面的typeForRowAtIndexPath委托方法
},
@{
    @"title" : @"美女",
    @"detail" : @"很漂亮",
    HsBaseTableViewKeyTypeForRow : @(1)//等同于下面的typeForRowAtIndexPath委托方法
}
]
},
@{
    @"title" : @"第仨",
    @"items" : @[
    [User user:@"张三5" sex:@"女"],
    [User user:@"张三6" sex:@"男"]
    ]
}
].mutableCopy;
```
