package com.core.lua.local.ui;

import android.content.Context;
import android.util.AttributeSet;
import android.view.View;
import android.view.ViewGroup;

import com.core.lua.ui.LuaView;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by JD on 2017/1/19.
 */
public class LuaViewGroup extends ViewGroup{

    public enum Layout {
        RELATIVE_LAYOUT(1<<0),VERTICAL_LAYOUT(1<<1),HORIZONTAL_LAYOUT(1<<2),VERTICAL_EQUAL_HEIGHT_LAYOUT(1<<3),HORIZONTAL_EQUAL_WIDTH_LAYOUT(1<<4);
        public int key;
        Layout(int key){
            this.key = key;
        }
       public static Layout getLayout(int key){
            for (Layout lay  : LuaViewGroup.Layout.values()){
                if (lay.key == key){
                    return lay;
                }
            }
            return RELATIVE_LAYOUT;
        }
    }
    private List<LuaView> subLuaView = new ArrayList<>();
    private LuaLayout layout = new RelativeLayout();
    private List<Double> padding;
    protected int leftPadding,topPadding,rightPadding,bottomPadding;
    private String luaTag;

    /********************线性布局***************************/
    //权重 线性布局会用到
    private List<Double> weight;

    public LuaViewGroup(Context context) {
        super(context);
    }

    public LuaViewGroup(Context context, AttributeSet attrs) {
        super(context, attrs);
    }

    public LuaViewGroup(Context context, AttributeSet attrs, int defStyleAttr) {
        super(context, attrs, defStyleAttr);
    }

    public List<LuaView> getSubLuaView(){
        return subLuaView;
    }
    public List<Double> getPadding() {
        return padding;
    }

    public void setPadding(List<Double> padding) {
        this.padding = padding;
        if (this.padding != null){
            this.leftPadding  = this.padding.get(0).intValue();
            this.topPadding  = this.padding.get(1).intValue();
            this.rightPadding  = this.padding.get(2).intValue();
            this.bottomPadding  = this.padding.get(3).intValue();
        }
    }

    public void setLayoutType(Layout layout_type){
        this.layout = LayoutFactory.getFactory(layout_type);
    }
    public String getLuaTag() {
        return luaTag;
    }

    public void setLuaTag(String luaTag) {
        this.luaTag = luaTag;
    }
    public void setWeight(List<Double> weight){
        this.weight = weight;
    }
    public List<Double> getWeight(){
        return this.weight;
    }

    public void addLuaView(LuaView view){
        LuaViewGroup.LuaLayoutParams lp = (LuaViewGroup.LuaLayoutParams) view.getLayoutParams();
        view._onLayout();
        this.subLuaView.add(view);
        this.addView(view._getView(),lp);
    }
    public void removeLuaView(LuaView view){
        this.removeView(view._getView());
        this.subLuaView.remove(view);
    }
    @Override
    public ViewGroup.LayoutParams generateLayoutParams(AttributeSet attrs){
        return new LuaLayoutParams(getContext(), attrs);
    }

    @Override
    protected void onLayout(boolean changed, int l, int t, int r, int b) {
        int cCount = this.subLuaView.size();
        LuaLayoutParams llp = null;
        for (int i = 0; i < cCount; i++) {
            LuaView luaView = this.subLuaView.get(i);
            View v = luaView._getView();
            llp = luaView.getLayoutParams();
            LuaLayoutRect luaLayoutRect = llp.getLuaLayoutRect();
            v.layout(luaLayoutRect.getL(), luaLayoutRect.getT(), luaLayoutRect.getR(), luaLayoutRect.getB());
        }
    }

    @Override
    protected void onMeasure(int widthMeasureSpec, int heightMeasureSpec) {
        layout.onMeasure(this,widthMeasureSpec,heightMeasureSpec);
    }
    public void measureLuaChild(View child, int parentWidthMeasureSpec,
                                           int parentHeightMeasureSpec){
        this.measureChild(child, parentWidthMeasureSpec, parentHeightMeasureSpec);
    }

    public int getLuaSuggestedMinimumWidth(){
        return this.getSuggestedMinimumWidth();
    }
    public int getLuaSuggestedMinimumHeight(){
        return this.getSuggestedMinimumHeight();
    }
    public void setLuaMeasuredDimension(int measuredWidth, int measuredHeight){
        this.setMeasuredDimension(measuredWidth,measuredHeight);
    }
    public static int resolveLuaSize(int size, int measureSpec) {
        return resolveSize(size, measureSpec);
    }
    /***********************************************分隔线****************************************************/

    public static class LuaLayoutParams extends ViewGroup.MarginLayoutParams {
        private LuaLayoutRect luaLayoutRect;
        public LuaLayoutParams(Context c, AttributeSet attrs) {
            super(c, attrs);
        }

        public LuaLayoutParams(int width, int height) {
            super(width, height);
        }

        public LuaLayoutParams(MarginLayoutParams source) {
            super(source);
        }

        public LuaLayoutParams(LayoutParams source) {
            super(source);
        }
        public LuaLayoutRect getLuaLayoutRect() {
            return luaLayoutRect;
        }
        public void setLuaLayoutRect(LuaLayoutRect luaLayoutRect) {
            this.luaLayoutRect = luaLayoutRect;
        }

    }


    /**************************************************************************************************************/

    public static class LuaLayoutRect {
        private int l;
        private int t;
        private int r;
        private int b;
        private int w;
        private int h;

        public LuaLayoutRect(int l,int t,int r,int b,int w,int h){
            this.l = l;
            this.t = t;
            this.r = r;
            this.b = b;
            this.w = w;
            this.h = h;
        }
        public int getL() {
            return l;
        }

        public void setL(int l) {
            this.l = l;
        }

        public int getT() {
            return t;
        }

        public void setT(int t) {
            this.t = t;
        }

        public int getR() {
            return r;
        }

        public void setR(int r) {
            this.r = r;
        }

        public int getB() {
            return b;
        }

        public void setB(int b) {
            this.b = b;
        }

        public int getW() {
            return w;
        }

        public void setW(int w) {
            this.w = w;
        }

        public int getH() {
            return h;
        }

        public void setH(int h) {
            this.h = h;
        }

        @Override
        public String toString() {
            return "Margin{" +
                    "l=" + l +
                    ", t=" + t +
                    ", r=" + r +
                    ", b=" + b +
                    ", w=" + w +
                    ", h=" + h +
                    '}';
        }
    }
}
