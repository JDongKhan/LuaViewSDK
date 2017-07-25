# SMTableView
对tableview的拓展，利用runtime的class_addMethod动态实现datasource和delegate方法，不用实现一个方法即可展示数据，当然你可以根据自己的喜好来实现也行！


 >IOS项目用的最多的控件中tableview恐怕是有着举足轻重位置，可是你如果还在自己实现tableview的delegate和datasource恐怕就low了，尤其是delegate和datasource逻辑大同小异，而本项目就是针对一个数组来分析实现掉delegate和datasource，甚至完全靠一个数组源都能全部处理掉tableview的渲染和事件处理。
 
 这种写法也能帮开发者只关注数据和界面，不需要考虑tableview的渲染逻辑


# -------惯例先上图，图丑但是它不是重点------
此效果图的实现可看代码，及其简单，不用实现一行协议代码

![](https://github.com/wangjindong/SMTableView/blob/master/tableview.gif)



设计理念：动态添加委托方法，实现tableview的委托，不需要程序猿实现任何接口方法，所有可能来源均有数据结构（即数组）提供！

该方法支持在数据里面增加tableview的选择事件，默认的cell样式、accessoryView,block等等！


如果你有好的建议请联系我:419591321@qq.com,其实自己仔细琢磨更有意思！

例子:

 ## 第一种
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
## 第二种 可支持自定义model
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

## 第三种 支持数组 可支持自定义model
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

        
## 第四种 支持数组 自定义model group样式 cell自定义(model只要key对应上即可，跟字典一样的)
-----------------------------------
```c
__weak UIViewController *weakSelf = self;
self.forthTableView.keyOfHeadTitle = @"title";
self.forthTableView.autoLayout = YES;
self.forthTableView.sectionable = YES;
self.forthTableView.dataSource = self;
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
## 第五种 自定义的modal 
-----------------------------------

 >这种就比较复杂 ，如果你的数据源比较复杂，只需要将数组指定给itemArray，然后帮你分析将每行的数据对象传给cell，你只需要重写cell的render方法即可拿到数据进行渲染，在cell重写tableView:(UITableView *)tableView cellInfo:(id)dataInfo即可继续计算行高
 
 >详情可看 [SMRefreshTableViewController.m](https://github.com/wangjindong/SMTableView/blob/master/SMTableView/SMRefreshTableViewController.m)

# CocoaPods

1、在 Podfile 中添加 `pod 'SMTableView'`。

2、执行 `pod install` 或 `pod update`。

3、导入 \<SMTableView/UITableiView+simplify.h\>。
