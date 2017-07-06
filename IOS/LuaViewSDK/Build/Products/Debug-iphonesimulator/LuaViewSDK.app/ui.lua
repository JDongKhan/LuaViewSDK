--设置

require "system"
require "constant"

local function click(sender)
    --Console.log("next");
    this:pushLuaView('list.lua');
end

local function click2(sender)
    local bt3 = LuaButton.create();
    bt3:setFrame({10,270,10,10});
    bt3:setBackgroundColor("#ffffff");
    this:addSubView(bt3);
end


w,h = LuaSystem.screenSize();

LuaConsole.log(this);

this:setBackgroundColor("#ff0000");

local bt = LuaButton.create();
bt:click(click);
bt:setFrame({100,200,200,200});
bt:setBackgroundColor("#ffffff");
--bt:setImage({ [ControlStates.UIControlStateNormal] = "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1485332719&di=08f9c509df9a600ba6bd3fe0fd39230c&imgtype=jpg&er=1&src=http%3A%2F%2Fimg.taopic.com%2Fuploads%2Fallimg%2F140418%2F318749-14041Q5395349.jpg"})
this:addSubView(bt);

local bt2 = LuaButton.create();
bt2:click(click2);
bt2:setFrame({10,70,50,50});
bt2:setBackgroundColor("#ffffff");
this:addSubView(bt2);

LuaConsole.log(ControlStates.UIControlStateSelected)

if(request ~= nil)
then
    Console.log(request);
    local text = request["text"];
    Console.log(text);
    bt:setTitleColor({[ControlStates.UIControlStateNormal] = "#ff0000",[ControlStates.UIControlStateHighlighted] = "#0000ff"});
    bt:setFontSize("22")
    bt:setTitle({[ControlStates.UIControlStateNormal] = text,[ControlStates.UIControlStateHighlighted] = "ooooooooooo"});
Console.log(bt:title())
end



local view01 = LuaView.create();
view01:setFrame({10,400,-1,-1});
view01:setLayoutStyle(1<<2);
view01:setPadding({10,10,10,10});
view01:setBackgroundColor("#0000ff");
this:addSubView(view01);

local view02 = LuaView.create();
view02:setFrame({0,0,50,50});
view02:setBackgroundColor("#ffffff");
view01:addSubView(view02);
local view03 = LuaView.create();
view03:setFrame({10,0,50,50});
view03:setBackgroundColor("#ffffff");
view01:addSubView(view03);


local view11 = LuaView.create();
view11:setFrame({10,500,-1,-1});
view11:setLayoutStyle(1<<0);
view11:setPadding({10,10,10,10});
view11:setBackgroundColor("#0000ff");
this:addSubView(view11);

local view12 = LuaView.create();
view12:setFrame({0,0,50,50});
view12:setBackgroundColor("#ffffff");
view11:addSubView(view12);
local view13 = LuaView.create();
view13:setFrame({10,0,50,50});
view13:setBackgroundColor("#ffffff");
view13:setLeftView(view12);
view11:addSubView(view13);

local view14 = LuaView.create();
view14:setFrame({0,10,50,50});
view14:setBackgroundColor("#ffffff");
view14:setTopView(view12);
view11:addSubView(view14);

local view15 = LuaView.create();
view15:setFrame({10,10,50,50});
view15:setBackgroundColor("#ffffff");
view15:setTopView(view12);
view15:setLeftView(view12);
view11:addSubView(view15);

LuaConsole.log(h);



