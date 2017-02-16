--
-- Created by IntelliJ IDEA.
-- User: Administrator
-- Date: 2017/2/9
-- Time: 9:53
-- To change this template use File | Settings | File Templates.
--

require("constant");


local lb = LuaLabel.create();
lb:setText("垂直平分布局");
lb:setFrame({10,10,-1,-1});
lb:setTextColor("#000000");
this:addSubView(lb);

local view011 = LuaView.create();
view011:setBackgroundColor("#000000");
view011:setFrame({10,30,30,150});
view011:setPadding({10,10,10,10});
view011:setLayoutType(LuaViewGroup.VERTICAL_EQUAL_HEIGHT_LAYOUT);
this:addSubView(view011);
local view012 = LuaView.create();
view012:setBackgroundColor("#0000ff");
view011:addSubView(view012);
local view013 = LuaView.create();
view013:setBackgroundColor("#f00fff");
view011:addSubView(view013);
local view014 = LuaView.create();
view014:setBackgroundColor("#ffffff");
view011:addSubView(view014);
