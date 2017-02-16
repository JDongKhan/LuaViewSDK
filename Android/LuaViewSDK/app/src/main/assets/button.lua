--
-- Created by IntelliJ IDEA.
-- User: Administrator
-- Date: 2017/2/10
-- Time: 10:10
-- To change this template use File | Settings | File Templates.
--

--LuaConsole.log(h);
local function click()
    LuaDialog.show("我是按钮");
end
local btn = LuaButton.create();
btn:setText("我是按钮");
btn:setTextColor("#ffffff");
--btn:setPadding({10,10,10,10})
btn:setBackgroundColor("#f00fff");
btn:setFrame({10,240,150,50});
btn:click(click);
this:addSubView(btn);