--
-- Created by IntelliJ IDEA.
-- User: Administrator
-- Date: 2017/2/13
-- Time: 15:53
-- To change this template use File | Settings | File Templates.
--
require("constant");

this:setTitle("车次列表");
this:setNavigationBackgroundColor("#00a4ff");
this:setTitleColor("#ffffff");

w,h = LuaSystem.screenSize();


local headView = LuaView.create();
headView:setFrame({0,0,w,70});
headView:setBackgroundColor("#00a4ff");
this:addSubView(headView);

local function preClick()
    LuaDialog.show("我是按钮");
end
local leftBtn = LuaButton.create();
leftBtn:setText("前一天");
leftBtn:setLeftImage("icon_newui_left_reduce.png");
leftBtn:setTextColor("#ffffff");
leftBtn:setFrame({10,10,120,50});
leftBtn:click(preClick);
headView:addSubView(leftBtn);

local function timeClick()
    LuaDialog.show("我是按钮");
end
local timeBtn = LuaButton.create();
timeBtn:setText("2月21日");
timeBtn:setTextColor("#ffffff");
timeBtn:setFrame({0,10,80,50});
timeBtn:click(timeClick);
timeBtn:setLayout_gravity(LuaView.Layout.PARENT_CENTER);
headView:addSubView(timeBtn);

local function nextClick()
    LuaDialog.show("我是按钮");
end
local nextBtn = LuaButton.create();
nextBtn:setText("下一天");
nextBtn:setTextColor("#ffffff");
nextBtn:setFrame({0,10,120,50});
nextBtn:setRightImage("icon_newui_right_add.png");
nextBtn:click(nextClick);
nextBtn:setLayout_gravity(LuaView.Layout.PARENT_RIGHT);
headView:addSubView(nextBtn);

local items = {
    {
        time="16:25",
        startCityName="杭州",
        endCityName="安吉",
        type="固普",
        price="36.0",
        leftTicketCount="24"
    },{
        time="16:25",
        startCityName="杭州",
        endCityName="安吉",
        type="固普",
        price="36.0",
        leftTicketCount="24"
    },{
        time="16:25",
        startCityName="杭州",
        endCityName="安吉",
        type="固普",
        price="36.0",
        leftTicketCount="24"
    }
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
tableview:setFrame({0,70,w,h-100});
tableview:setCell("demo/ticketcell");
tableview:setItems(items);
tableview:setItemClick(itemClick);
tableview:setHiddenDivider(true);
tableview:setLayoutIndex(indexOfLayoutsAtPosition);
this:addSubView(tableview);

local function click()
    local text = LuaBundle.getLuaScript("demo/ticketlist");
    this:pushLuaView("source",{text=text});
end
local btn = LuaButton.create();
btn:setText("显示源码");
btn:setTextColor("#ffffff");
--btn:setPadding({10,10,10,10})
btn:setBackgroundColor("#f00fff");
btn:setFrame({10,440,150,50});
btn:click(click);
this:addSubView(btn);
