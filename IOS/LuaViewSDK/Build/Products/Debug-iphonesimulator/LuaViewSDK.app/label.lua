--
-- Created by IntelliJ IDEA.
-- User: Administrator
-- Date: 2017/2/10
-- Time: 10:09
-- To change this template use File | Settings | File Templates.
--


local lb = LuaLabel.create();
lb:setText("我是label");
lb:setFrame({10,10,-1,-1});
lb:setTextColor("#000000");
this:addSubView(lb);
