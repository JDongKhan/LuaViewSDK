--
-- Created by IntelliJ IDEA.
-- User: Administrator
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
tableview:setLayoutIndex(indexOfLayoutsAtPosition);
this:addSubView(tableview);
