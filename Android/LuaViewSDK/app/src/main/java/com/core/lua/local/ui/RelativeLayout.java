package com.core.lua.local.ui;

import android.view.View;

import com.core.lua.ui.LuaView;

/**
 * Created by JD on 2017/2/9.
 */
public class RelativeLayout implements LuaLayout {
    @Override
    public void onMeasure(LuaViewGroup viewGroup, int widthMeasureSpec, int heightMeasureSpec) {
        int cCount = viewGroup.getSubLuaView().size();
        int cl = 0,ct = 0, cr = 0, cb = 0;
        LuaViewGroup.LuaLayoutParams llp = null;
        int pWidth = 0;
        int pHeight = 0;
        /**
         * 遍历所有childView根据其宽和高，以及margin进行布局
         */
        int l = 0, t = 0,r = 0,b = 0,w = 0, h = 0;
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
                w = 0;
                h = 0;
            }
            cl = l+viewGroup.leftPadding;
            ct = t+viewGroup.topPadding;
            if (luaView.getLeftView() != null){
                LuaView lv = luaView.getLeftView();
                LuaViewGroup.LuaLayoutParams leftLp = lv.getLayoutParams();
                cl = l + leftLp.getLuaLayoutRect().getR();
            }
            if (luaView.getTopView() != null){
                LuaView lv = luaView.getTopView();
                LuaViewGroup.LuaLayoutParams topLp = lv.getLayoutParams();
                ct = t + topLp.getLuaLayoutRect().getB();
            }
            cr = cl + w;
            cb = ct + h;
            llp.setLuaLayoutRect(new LuaViewGroup.LuaLayoutRect(cl,ct,cr,cb,w,h));
            //LuaConsole.log(luaView.getTag()+"--cl:"+cl+"-ct:"+ct+"-cr:"+cr+"-cb:"+cb);
            pWidth = Math.max(pWidth,cr+llp.rightMargin);
            pHeight = Math.max(pHeight,cb+llp.bottomMargin);
        }
        // count with padding
        pWidth = pWidth+viewGroup.rightPadding;
        pHeight = pHeight+viewGroup.bottomPadding;
        //LuaConsole.log("viewGroup",this.getLuaTag()+"--------"+pWidth+"-----------"+pHeight);
        // see if the size is big enough
        pWidth = Math.max(pWidth, viewGroup.getLuaSuggestedMinimumWidth());
        pHeight = Math.max(pHeight, viewGroup.getLuaSuggestedMinimumHeight());
        pWidth = viewGroup.resolveLuaSize(pWidth, widthMeasureSpec);
        pHeight = viewGroup.resolveLuaSize(pHeight, heightMeasureSpec);
        viewGroup.setLuaMeasuredDimension(pWidth,pHeight);

        //处理相对父布局
        this.resizeViewAtParent(viewGroup,pWidth,pHeight);
        //处理相对于右视图
        this.resizeViewAtRightView(viewGroup);
    }

    private void resizeViewAtParent(LuaViewGroup viewGroup,int vw,int vh){
       // int vw = viewGroup.getWidth();
        //int vh = viewGroup.getHeight();
        int cCount = viewGroup.getSubLuaView().size();
        LuaViewGroup.LuaLayoutParams llp = null;
        int cl = 0,ct = 0, cr = 0, cb = 0;
        for (int i = 0; i < cCount; i++) {
            LuaView luaView = viewGroup.getSubLuaView().get(i);
            int layout_gravity = luaView.getLayout_gravity();
            if (luaView.isHidden() == 0 && layout_gravity > 0){
                llp = luaView.getLayoutParams();
                LuaViewGroup.LuaLayoutRect luaLayoutRect = llp.getLuaLayoutRect();
                cl = luaLayoutRect.getL();
                ct = luaLayoutRect.getT();
                cr = luaLayoutRect.getR();
                cb = luaLayoutRect.getB();
                if (layout_gravity == LuaView.Layout_gravity.PARENT_RIGHT.key) {
                    cr = vw - viewGroup.rightPadding;
                    cl = cr - luaLayoutRect.getW();
                }else if (layout_gravity == LuaView.Layout_gravity.PARENT_BOTTOM.key) {
                    cb = vh-viewGroup.bottomPadding;
                    ct = cb-luaLayoutRect.getH();
                }else if (layout_gravity == (LuaView.Layout_gravity.PARENT_BOTTOM.key|LuaView.Layout_gravity.PARENT_BOTTOM.key)) {
                    cr = vw - viewGroup.rightPadding;
                    cl = cr - luaLayoutRect.getW();
                    cb = vh-viewGroup.bottomPadding;
                    ct = cb-luaLayoutRect.getH();
                }else if (layout_gravity == (LuaView.Layout_gravity.PARENT_LEFT.key|LuaView.Layout_gravity.PARENT_CENTER.key)) {
                    int y_middle = (vh-viewGroup.topPadding-viewGroup.bottomPadding-luaLayoutRect.getH())/2;
                    cl = viewGroup.leftPadding+llp.leftMargin;
                    cr = cl + luaLayoutRect.getW();
                    ct = y_middle;
                    cb = ct+luaLayoutRect.getH();
                }else if (layout_gravity == LuaView.Layout_gravity.PARENT_CENTER.key) {
                    int x_middle = (vw-viewGroup.leftPadding-viewGroup.rightPadding-luaLayoutRect.getW())/2;
                    int y_middle = (vh-viewGroup.topPadding-viewGroup.bottomPadding-luaLayoutRect.getH())/2;
                    cl = x_middle;
                    cr = cl + luaLayoutRect.getW();
                    ct = y_middle;
                    cb = ct+luaLayoutRect.getH();
                }else if (layout_gravity == (LuaView.Layout_gravity.PARENT_RIGHT.key|LuaView.Layout_gravity.PARENT_CENTER.key)) {
                    int y_middle = (vh-viewGroup.topPadding-viewGroup.bottomPadding-luaLayoutRect.getH())/2;
                    cr = vw - viewGroup.rightPadding;
                    cl = cr - luaLayoutRect.getW();
                    ct = y_middle;
                    cb = ct+luaLayoutRect.getH();
                }
                luaLayoutRect.setR(cr);
                luaLayoutRect.setL(cl);
                luaLayoutRect.setB(cb);
                luaLayoutRect.setT(ct);
            }
        }
    }


    private void resizeViewAtRightView(LuaViewGroup viewGroup){
        int cCount = viewGroup.getSubLuaView().size();
        LuaViewGroup.LuaLayoutParams llp = null;
        int cl = 0,ct = 0, cr = 0, cb = 0;
        for (int i = 0; i < cCount; i++) {
            LuaView luaView = viewGroup.getSubLuaView().get(i);
            if (luaView.isHidden() == 0){
                llp = luaView.getLayoutParams();
                LuaViewGroup.LuaLayoutRect margin = llp.getLuaLayoutRect();
                if (luaView.getRightView() != null){
                    LuaView rv = luaView.getRightView();
                    LuaViewGroup.LuaLayoutParams rightLp = rv.getLayoutParams();
                    cr = rightLp.getLuaLayoutRect().getL()-rightLp.leftMargin-llp.rightMargin;
                    cl = cr-margin.getW();
                    margin.setR(cr);
                    margin.setL(cl);
                }
                if (luaView.getBottomView() != null){
                    LuaView bv = luaView.getBottomView();
                    LuaViewGroup.LuaLayoutParams bottomLp = bv.getLayoutParams();
                    cb = bottomLp.getLuaLayoutRect().getT()-bottomLp.topMargin-llp.bottomMargin;
                    ct = cb-margin.getH();
                    margin.setB(cb);
                    margin.setT(ct);
                }
            }
        }
    }
}
