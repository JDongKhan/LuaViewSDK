
LuaViewGroup = {};
LuaViewGroup.RELATIVE_LAYOUT = 1<<0;
LuaViewGroup.VERTICAL_LAYOUT = 1<<1;
LuaViewGroup.HORIZONTAL_LAYOUT = 1<<2;
LuaViewGroup.VERTICAL_EQUAL_HEIGHT_LAYOUT = 1<<3;
LuaViewGroup.HORIZONTAL_EQUAL_WIDTH_LAYOUT = 1 << 4;

LuaViewGroup.WRAP_CONTENT = -2;
LuaViewGroup.MATCH_PARENT = -1;

LuaView.Layout = {};
LuaView.Layout.PARENT_TOP = 1 << 0;
LuaView.Layout.PARENT_CENTER = 1 << 1;
LuaView.Layout.PARENT_RIGHT = 1 << 2;
LuaView.Layout.PARENT_LEFT = 1 << 3;
LuaView.Layout.PARENT_BOTTOM = 1 << 4;

LuaView.Layout.PARENT_TOP_CENTER = LuaView.Layout.PARENT_TOP|LuaView.Layout.PARENT_CENTER;
LuaView.Layout.PARENT_RIGHT_CENTER = LuaView.Layout.PARENT_RIGHT|LuaView.Layout.PARENT_CENTER;
LuaView.Layout.PARENT_LEFT_CENTER = LuaView.Layout.PARENT_LEFT|LuaView.Layout.PARENT_CENTER;
LuaView.Layout.PARENT_BOTTOM_CENTER = LuaView.Layout.PARENT_BOTTOM|LuaView.Layout.PARENT_CENTER;
