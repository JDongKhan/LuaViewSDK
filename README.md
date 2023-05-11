# LuaViewSDK
![](https://github.com/wangjindong/LuaViewSDK/blob/master/test3.gif)

【本项目已不再维护】

用lua实现android和iOS的界面渲染，支持线性布局、相对布局

其使用和oc很相似

tableview

```c
--
-- Created by IntelliJ IDEA.
-- User: wjd
-- Date: 2017/1/23
-- Time: 15:32
-- To change this template use File | Settings | File Templates.
--
w,h = LuaSystem.screenSize();

this:setTitle("我的列表");

local items = {
    "HorizontalLayout",
    "HorizontalEqualWidthLayout",
    "VerticalLayout",
    "VerticalEqualHeightLayout",
    "RelativeLayout",
    "Label",
    "Button",
    "TextField",
    "demo/TicketList"
};

function itemClick(position)
    local name = items[position+1];
    name = string.lower(name);
    this:pushLuaView(name);
end

function layoutIndex(position)
    return 0;
end

local tableview = LuaTableView.create();
tableview:setBackgroundColor("#00ff00");
tableview:setFrame({10,10,w-20,h-20});
tableview:setCell("cell.lua");
tableview:setItems(items);
tableview:setItemClick(itemClick);
tableview:setLayoutIndex(layoutIndex);
this:addSubView(tableview);
```
