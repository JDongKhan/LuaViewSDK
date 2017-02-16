package com.core.lua.ui;

import android.content.Context;
import android.graphics.Color;
import android.view.View;

import com.core.lua.local.ui.LuaViewGroup;
import com.core.lua.local.utils.ActivityManager;
import com.core.lua.system.LuaSystem;

import java.util.ArrayList;
import java.util.List;

import cn.vimfung.luascriptcore.modules.oo.LuaObjectClass;

/**
 * Created by JD on 2017/1/18.
 */
public class LuaView extends LuaObjectClass {
    private List<Double> frame;
    protected View view;
    private String  backgroundColor;
    private String tag;
    private int hidden;
    protected LuaActivity luaActivity;
    LuaViewGroup.LuaLayoutParams lp = null;

    /***********************相对布局*************************/
    private LuaView leftView;
    private LuaView topView;
    private LuaView rightView;
    private LuaView bottomView;
    //相对于父view的位置
    private int layout_gravity;
    /********************线性布局***************************/
    //权重 线性布局会用到
    private List<Double> weight;


    public LuaView(){
        this.view = new LuaViewGroup(ActivityManager.getActivity());
        this.view.setBackgroundColor(Color.BLACK);
        lp = new LuaViewGroup.LuaLayoutParams(LuaViewGroup.LayoutParams.WRAP_CONTENT,LuaViewGroup.LayoutParams.WRAP_CONTENT);
    }
    //开始布局
    public void _onLayout(){
    }

    /**
     * 布局类型
     * @param layout_type
     */
    public void setLayoutType(int layout_type){
        if (this.view instanceof LuaViewGroup){
            ((LuaViewGroup)this.view).setLayoutType(LuaViewGroup.Layout.getLayout(layout_type));
        }
    }

    public void setBackgroundColor(String color){
        this.backgroundColor = color;
        this._getView().setBackgroundColor(Color.parseColor(color));
    }
    public void setFrame(List<Double> frame){
        this.frame = frame;
        Double l = 0.0,t = 0.0,r = 0.0,b = 0.0,w = 0.0 , h = 0.0;
        if(frame.size() == 2){
            w = frame.get(0);
            h = frame.get(1);
        }else if (frame.size() == 4) {
            l = frame.get(0);
            t = frame.get(1);
            w = frame.get(2);
            h = frame.get(3);
        }else if (frame.size() == 6){
            l = frame.get(0);
            t = frame.get(1);
            r = frame.get(2);
            b = frame.get(3);
            w = frame.get(4);
            h = frame.get(5);
        }
        float scale = LuaSystem.screenScale();
        lp.leftMargin = (int)(l.intValue()*scale);
        lp.topMargin = (int)(t.intValue()*scale);
        lp.rightMargin = (int)(r.intValue()*scale);
        lp.bottomMargin = (int)(b.intValue()*scale);
        lp.width = (int)(w.intValue()*scale);
        lp.height = (int)(h.intValue()*scale);
    }
    public void setPadding(List<Double> padding) {
        if (this.view instanceof LuaViewGroup){
            float scale = LuaSystem.screenScale();
            List newList = new ArrayList();
            for (Double d : padding){
                newList.add(scale*d);
            }
            LuaViewGroup vp = (LuaViewGroup)this.view;
            vp.setPadding(newList);
        }
    }
    public void setTag(String tag) {
        if (this.view instanceof LuaViewGroup) {
            LuaViewGroup vp = (LuaViewGroup)this.view;
            vp.setLuaTag(tag);
        }
        this.tag = tag;
    }

    public void setHidden(int hidden) {
        this.hidden = hidden;
        if(hidden == 0) {
            this.view.setVisibility(View.VISIBLE);
        }else{
            this.view.setVisibility(View.INVISIBLE);
        }
    }

    public void setLuaActivity(LuaActivity activity){
        this.luaActivity = activity;
    }


    public void addSubView(LuaView view){
        view.setLuaActivity(this.luaActivity);
        if (this.view instanceof LuaViewGroup){
            ((LuaViewGroup)this.view).addLuaView(view);
        }
    }

    public void removeSubView(LuaView view){
        if (this.view instanceof LuaViewGroup){
            ((LuaViewGroup)this.view).removeLuaView(view);
        }
    }

    /**
     * 重新布局
     */
    public void reLayout() {
        this.view.invalidate();
    }

    /**********************相对布局****************************/

    public void setLeftView(LuaView leftView){
        this.leftView = leftView;
    }
    public void setTopView(LuaView topView){
        this.topView = topView;
    }
    public void setRightView(LuaView rightView){
        this.rightView = rightView;
    }
    public void setBottomView(LuaView bottomView){
        this.bottomView = bottomView;
    }
    public void setLayout_gravity(int layout_gravity){
        this.layout_gravity = layout_gravity;
    }
    /********************线性布局***************************/
    public void setWeight(List<Double> weight) {
        this.weight = weight;
        if (this.view instanceof LuaViewGroup){
            ((LuaViewGroup)this.view).setWeight(weight);
        }
    }

    /***********************************get***********************************/
    public View _getView(){
        return this.view;
    }
    public LuaViewGroup.LuaLayoutParams getLayoutParams() {
        return lp;
    }
    public List getPadding() {
        if (this.view instanceof LuaViewGroup){
            float scale = LuaSystem.screenScale();
            LuaViewGroup vp = (LuaViewGroup)this.view;
            List<Double> padding = vp.getPadding();
            List newList = new ArrayList();
            for (Double d : padding){
                newList.add(scale*d);
            }
            return newList;
        }
        return null;
    }

    public String getTag() {
        return this.tag;
    }
    public int isHidden() {
        return hidden;
    }

    /**********************相对布局****************************/
    public LuaView getTopView(){
        return this.topView;
    }
    public LuaView getLeftView(){
        return this.leftView;
    }
    public LuaView getRightView(){
        return this.rightView;
    }
    public LuaView getBottomView(){
        return this.bottomView;
    }
    public int getLayout_gravity(){
        return this.layout_gravity;
    }

    /****************************************************/
    public enum  Layout_gravity {
        PARENT_TOP(1 << 0),PARENT_CENTER(1 << 1),PARENT_RIGHT(1 << 2),PARENT_LEFT(1 << 3),PARENT_BOTTOM(1 << 4);
        public int key;
        Layout_gravity(int key){
            this.key = key;
        }
    }
}
