--
-- Created by IntelliJ IDEA.
-- User: Administrator
-- Date: 2017/2/10
-- Time: 10:11
-- To change this template use File | Settings | File Templates.
--

local lb = LuaTextField.create();
lb:setText("我是TextField");
lb:setFrame({10,10,-1,-1});
lb:setTextColor("#000000");
this:addSubView(lb);