package com.core.lua.local.ui;

import android.view.View;

import com.core.lua.ui.LuaView;

/**
 * Created by JD on 2017/2/9.
 */
public class VerticalEqualHeightLayout implements LuaLayout {
    @Override
    public void onMeasure(LuaViewGroup viewGroup, int widthMeasureSpec, int heightMeasureSpec) {
        // 计算所有child view 要占用的空间
        int desireWidth = viewGroup.getWidth();
        int desireHeight = viewGroup.getHeight();
        int cCount = viewGroup.getSubLuaView().size();
        int cl = 0,ct = 0, cr = 0, cb = 0;
        int l = 0, t = 0,w = desireWidth-viewGroup.leftPadding-viewGroup.rightPadding, h = (desireHeight-viewGroup.topPadding-viewGroup.bottomPadding)/cCount;
        LuaViewGroup.LuaLayoutParams llp = null;
        int index = 0;
        for (int i = 0; i < cCount; i++) {
            LuaView luaView = viewGroup.getSubLuaView().get(i);
            llp = luaView.getLayoutParams();
            if (luaView.isHidden() == 0) {
                l = viewGroup.leftPadding;
                t = viewGroup.topPadding+h*index;
                index++;
            }
            cl = l;
            ct = t;
            cr = cl + w;
            cb = ct + h;
            llp.setLuaLayoutRect(new LuaViewGroup.LuaLayoutRect(cl, ct, cr, cb,w,h));
        }
        viewGroup.setLuaMeasuredDimension(viewGroup.resolveLuaSize(desireWidth, widthMeasureSpec),
                viewGroup.resolveLuaSize(desireHeight, heightMeasureSpec));
    }
}
