--
-- Created by IntelliJ IDEA.
-- User: Administrator
-- Date: 2017/2/9
-- Time: 9:54
-- To change this template use File | Settings | File Templates.
--
require("constant");

local lb = LuaLabel.create();
lb:setText("相对布局");
lb:setFrame({10,80,-1,-1});
lb:setTextColor("#000000");
this:addSubView(lb);

local view11 = LuaView.create();
view11:setBackgroundColor("#00ff00");
view11:setTag("view11");
view11:setFrame({10,100,-1,-1});
view11:setPadding({10,10,10,10});
view11:setLayoutType(LuaViewGroup.RELATIVE_LAYOUT);
this:addSubView(view11);
local view12 = LuaView.create();
view12:setBackgroundColor("#0000ff");
view12:setTag("view12");
view12:setFrame({0,0,30,30});
view11:addSubView(view12);
local view13 = LuaView.create();
view13:setBackgroundColor("#ffffff");
view13:setTag("view13");
view13:setFrame({10,0,30,30});
view13:setLeftView(view12);
view11:addSubView(view13);
local view14 = LuaView.create();
view14:setBackgroundColor("#f00fff");
view14:setTag("view14");
view14:setFrame({0,10,30,30});
view14:setHidden(1);
view14:setTopView(view12);
view11:addSubView(view14);
local view15 = LuaView.create();
view15:setBackgroundColor("#ffffff");
view15:setTag("view15");
view15:setFrame({10,10,30,30});
view15:setLeftView(view14);
view15:setTopView(view12);
view11:addSubView(view15);