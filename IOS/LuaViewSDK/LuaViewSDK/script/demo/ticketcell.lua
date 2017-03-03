--
-- Created by IntelliJ IDEA.
-- User: Administrator
-- Date: 2017/2/13
-- Time: 15:59
-- To change this template use File | Settings | File Templates.
--
require("constant");
w,h = LuaSystem.screenSize();

local cView;

local timeLable;
local startCityNameLabel;
local endCityNameLable;
local priceLable;
local typeLable;
local buyButton;

function click(btn)
    local text = LuaBundle.getLuaScript("demo/ticketcell");
    this:pushLuaView("source",{text=text});
end
function loadView(contentView)
    
    this:setBackgroundColor("#00000000");
    
    cView = LuaView.create();
    cView:setBackgroundColor("#ffffff");
    cView:setFrame({0,0,0,10,w,-1});
    cView:setTag("cView");
    this:addSubView(cView);
    
    timeLable = LuaLabel.create();
    timeLable:setFrame({10,5,-1,-1});
    timeLable:setBackgroundColor("#cecece");
    timeLable:setBold(true);
    timeLable:setTextColor("#ff0000");
    cView:addSubView(timeLable);
    
    typeLable = LuaLabel.create();
    typeLable:setFrame({10,5,-1,-1});
    typeLable:setLayout_gravity(LuaView.Layout.PARENT_RIGHT);
    typeLable:setBackgroundColor("#cecece");
    typeLable:setTextColor("#ff0000");
    cView:addSubView(typeLable);
    
    startCityNameLabel = LuaLabel.create();
    startCityNameLabel:setFrame({10,10,-1,-1});
    startCityNameLabel:setTopView(timeLable);
    startCityNameLabel:setBackgroundColor("#cecece");
    startCityNameLabel:setTextColor("#ff0000");
    cView:addSubView(startCityNameLabel);
    
    endCityNameLable = LuaLabel.create();
    endCityNameLable:setFrame({10,10,0,10,-1,-1});
    endCityNameLable:setTopView(startCityNameLabel);
    endCityNameLable:setBackgroundColor("#cecece");
    endCityNameLable:setTextColor("#ff0000");
    cView:addSubView(endCityNameLable);
    
    buyButton = LuaButton.create();
    buyButton:setText("显示源码");
    buyButton:setFrame({10,0,100,-1});
    buyButton:setLayout_gravity(LuaView.Layout.PARENT_RIGHT);
    buyButton:setTopView(typeLable);
    buyButton:setTextColor("#ff0000");
    buyButton:setFocusable(false);
    buyButton:click(click);
    cView:addSubView(buyButton);
    
    priceLable = LuaLabel.create();
    priceLable:setFrame({10,-10,-1,-1});
    priceLable:setRightView(buyButton);
    priceLable:setTopView(startCityNameLabel);
    priceLable:setBackgroundColor("#cecece");
    priceLable:setTextColor("#ff0000");
    cView:addSubView(priceLable);
end

function loadData(obj)
    timeLable:setText(obj["time"]);
    typeLable:setText(obj["type"]);
    startCityNameLabel:setText(obj["startCityName"]);
    endCityNameLable:setText(obj["endCityName"]);
    priceLable:setText(obj["price"]);
end

function cellHeight(obj)
    return 120;
end
