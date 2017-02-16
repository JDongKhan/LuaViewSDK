package com.core.lua.local.ui;

import android.view.View;

import com.core.lua.ui.LuaView;

import junit.framework.Assert;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by JD on 2017/2/9.
 */
public class HorizontalLayout implements LuaLayout {
    @Override
    public void onMeasure(LuaViewGroup viewGroup, int widthMeasureSpec, int heightMeasureSpec) {
        // 计算所有child view 要占用的空间
        int desireWidth = 0;
        int desireHeight = 0;
        int cCount = viewGroup.getSubLuaView().size();
        int cl = 0,ct = 0, cr = 0, cb = 0;
        int l = 0, t = 0,r = 0,b = 0,w = 0, h = 0;
        LuaViewGroup.LuaLayoutParams llp = null;

        for (int i = 0; i < cCount; i++) {
            LuaView luaView = viewGroup.getSubLuaView().get(i);
            llp = luaView.getLayoutParams();
            if (luaView.isHidden() == 0) {
                View v = luaView._getView();
                viewGroup.measureLuaChild(v, widthMeasureSpec,
                        heightMeasureSpec);
                l = llp.leftMargin+r;
                t = llp.topMargin+b;
                r = llp.rightMargin;
                b = llp.bottomMargin;
                w = v.getMeasuredWidth();
                h = v.getMeasuredHeight();
            }else{
                l = 0;
                t = 0;
                r = 0;
                b = 0;
                w = 0;
                h = 0;
            }
            cl = l+cr;
            ct = t;
            cr = cl + w;
            cb = ct + h;
            llp.setLuaLayoutRect(new LuaViewGroup.LuaLayoutRect(cl+viewGroup.leftPadding, ct+viewGroup.topPadding, cr+viewGroup.leftPadding, cb+viewGroup.topPadding,w,h));
            desireHeight = Math
                    .max(desireHeight, h+t);
        }
        // count with padding
        desireWidth = cr + viewGroup.leftPadding + viewGroup.rightPadding;
        desireHeight += viewGroup.topPadding + viewGroup.bottomPadding;

        // see if the size is big enough
        desireWidth = Math.max(desireWidth, viewGroup.getLuaSuggestedMinimumWidth());
        desireHeight = Math.max(desireHeight, viewGroup.getLuaSuggestedMinimumHeight());

        viewGroup.setLuaMeasuredDimension(viewGroup.resolveLuaSize(desireWidth, widthMeasureSpec),
                viewGroup.resolveLuaSize(desireHeight, heightMeasureSpec));

        //处理权重
        this.resizeWithWeight(viewGroup);
    }

    private void resizeWithWeight(LuaViewGroup viewGroup){
        if (viewGroup.getWeight() != null && viewGroup.getWeight().size() > 0){
            int width = viewGroup.getLayoutParams().width;
            Assert.assertTrue("width 必须大于0",width > 0);
            int remainWidth = width;
            int cCount = viewGroup.getSubLuaView().size();
            LuaViewGroup.LuaLayoutParams llp = null;
            LuaViewGroup.LuaLayoutRect luaLayoutRect = null;
            int index = 0;
            for (int i = 0; i < cCount; i++) {
                LuaView luaView = viewGroup.getSubLuaView().get(i);
                if (luaView.isHidden() == 0) {
                    llp = luaView.getLayoutParams();
                    luaLayoutRect = llp.getLuaLayoutRect();
                    if (index > viewGroup.getWeight().size()-1){
                        remainWidth = remainWidth-luaLayoutRect.getW()-llp.leftMargin-llp.rightMargin;
                    }else{
                        remainWidth = remainWidth  -llp.leftMargin-llp.rightMargin;
                    }
                    index++;
                }
            }
            remainWidth = remainWidth-viewGroup.leftPadding-viewGroup.rightPadding;
            Double totalWeight = 0.0;
            List<Double> widthList = new ArrayList();
            for(Double j : viewGroup.getWeight()){
                totalWeight += j;
                widthList.add(remainWidth*j);
            }
            Assert.assertTrue("权重之和必须为1",totalWeight == 1);
            index = 0;
            int cl = 0, cr = 0;
            int l = 0,r = 0,w = 0;
            for (int i = 0; i < cCount; i++) {
                LuaView luaView = viewGroup.getSubLuaView().get(i);
                if (luaView.isHidden() == 0) {
                    llp = luaView.getLayoutParams();
                    luaLayoutRect = llp.getLuaLayoutRect();
                    l = llp.leftMargin+r;
                    r = llp.rightMargin;
                    if(index <= widthList.size()-1) {
                        w = widthList.get(index).intValue();
                    }else{
                        w = luaLayoutRect.getW();
                    }
                    cl = l+cr;
                    cr = cl + w;
                    luaLayoutRect.setL(cl+viewGroup.leftPadding);
                    luaLayoutRect.setR(cr+viewGroup.leftPadding);
                    luaLayoutRect.setW(w);
                    index++;
                }
            }
        }
    }
}
