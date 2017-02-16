--
-- Created by IntelliJ IDEA.
-- User: Administrator
-- Date: 2017/2/13
-- Time: 15:53
-- To change this template use File | Settings | File Templates.
--

w,h = LuaSystem.screenSize();

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
tableview:setFrame({10,10,w-20,h-20});
tableview:setCell("demo/ticketcell");
tableview:setItems(items);
tableview:setItemClick(itemClick);
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
