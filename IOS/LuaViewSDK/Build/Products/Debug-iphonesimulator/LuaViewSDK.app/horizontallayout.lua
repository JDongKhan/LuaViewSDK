--
-- Created by IntelliJ IDEA.
-- User: Administrator
-- Date: 2017/2/9
-- Time: 9:52
-- To change this template use File | Settings | File Templates.
--
require("constant");

local lb = LuaLabel.create();
lb:setText("线性布局");
lb:setFrame({10,10,-1,-1});
lb:setTextColor("#000000");
this:addSubView(lb);

local view01 = LuaView.create();
view01:setBackgroundColor("#00ff00");
view01:setFrame({10,50,-1,-1});
view01:setPadding({10,10,10,10});
view01:setLayoutType(LuaViewGroup.HORIZONTAL_LAYOUT);
this:addSubView(view01);
local view02 = LuaView.create();
view02:setBackgroundColor("#0000ff");
view02:setFrame({0,0,30,30});
view01:addSubView(view02);
local view03 = LuaView.create();
view03:setBackgroundColor("#f00fff");
--view03:setHidden(1);
view03:setFrame({10,0,10,0,30,30});
view01:addSubView(view03);
local view04 = LuaView.create();
view04:setBackgroundColor("#ffffff");
view04:setFrame({0,0,30,30});
view01:addSubView(view04);


local view101 = LuaView.create();
view101:setBackgroundColor("#00ff00");
view101:setFrame({10,130,200,-1});
view101:setPadding({10,10,10,10});
view101:setWeight({0.2,0.8});
view101:setLayoutType(LuaViewGroup.HORIZONTAL_LAYOUT);
this:addSubView(view101);
local view102 = LuaView.create();
view102:setBackgroundColor("#0000ff");
view102:setFrame({0,0,30,30});
view101:addSubView(view102);
local view103 = LuaView.create();
view103:setBackgroundColor("#f00fff");
--view103:setHidden(1);
view103:setFrame({10,0,30,30});
view101:addSubView(view103);
local view104 = LuaView.create();
view104:setBackgroundColor("#ffffff");
view104:setFrame({10,0,30,30});
view101:addSubView(view104);
