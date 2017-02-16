package com.core.lua.local.ui;

/**
 * Created by JD on 2017/2/9.
 */
public class LayoutFactory {
    public static LuaLayout getFactory(LuaViewGroup.Layout layout_type){
        if (layout_type == LuaViewGroup.Layout.HORIZONTAL_LAYOUT){
              return new HorizontalLayout();
        }else  if (layout_type == LuaViewGroup.Layout.RELATIVE_LAYOUT){
            return new RelativeLayout();
        }else if(layout_type == LuaViewGroup.Layout.VERTICAL_LAYOUT){
           return new VerticalLayout();
        }else if(layout_type == LuaViewGroup.Layout.HORIZONTAL_EQUAL_WIDTH_LAYOUT){
           return new HorizontalEqualWidthLayout();
        }else if(layout_type == LuaViewGroup.Layout.VERTICAL_EQUAL_HEIGHT_LAYOUT){
            return new VerticalEqualHeightLayout();
        }else {
            return new RelativeLayout();
        }
    }
}
