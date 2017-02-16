--
-- Created by IntelliJ IDEA.
-- User: Administrator
-- Date: 2017/2/14
-- Time: 9:46
-- To change this template use File | Settings | File Templates.
--
w,h = LuaSystem.screenSize();

local lb = LuaLabel.create();
lb:setText(request["text"]);
lb:setFrame({10,10,w-20,-1});
lb:setTextColor("#000000");
lb:setMaxHeight(h-20);
lb:setVerticalScrollBarEnabled(true);
this:addSubView(lb);
