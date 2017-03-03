package com.core.lua.ui;

import android.graphics.Color;
import android.text.TextPaint;
import android.text.method.ScrollingMovementMethod;
import android.widget.Scroller;
import android.widget.TextView;

import com.core.lua.local.utils.ActivityManager;
import com.core.lua.system.LuaSystem;

/**
 * Created by JD on 2017/1/19.
 */
public class LuaLabel extends LuaView{
    private TextView textView;

    public LuaLabel(){
        this.textView = new TextView(ActivityManager.getActivity());
        this.textView.setMovementMethod(ScrollingMovementMethod.getInstance()) ;
        super.view = this.textView;
    }

    public void setText(String text){
        this.textView.setText(text);
    }

    public void setTextColor(String color){
        this.textView.setTextColor(Color.parseColor(color));
    }

    public void setBold(boolean bold){
        TextPaint tp = this.textView.getPaint();
        tp.setFakeBoldText(bold);
    }

    public void setMaxHeight(int height){
        float scale = LuaSystem.screenScale();
        this.textView.setMaxHeight((int)(height*scale));
    }
    public void setVerticalScrollBarEnabled(boolean verticalScrollBarEnabled) {
        this.textView.setHorizontalScrollBarEnabled(true);
    }
    public void setHorizontalScrollBarEnabled(boolean horizontalScrollBarEnabled) {
        this.textView.setVerticalScrollBarEnabled(true);
    }


    public CharSequence text(){
        return this.textView.getText();
    }
}
