package com.core.lua.ui;

import android.graphics.Color;
import android.view.View;
import android.widget.Button;

import com.core.lua.local.utils.ActivityManager;

import cn.vimfung.luascriptcore.LuaFunction;
import cn.vimfung.luascriptcore.LuaValue;

/**
 * Created by JD on 2017/1/18.
 */
public class LuaButton extends LuaView {
    private Button button;
    private LuaFunction function;

    public LuaButton(){
        this.button = new Button(ActivityManager.getActivity());
        super.view = this.button;
    }
    public void setText(String text){
        this.button.setText(text);
    }
    public void setTextColor(String color){
        this.button.setTextColor(Color.parseColor(color));
    }
    public void click(LuaFunction function){
        this.function = function;
        this.button.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                LuaValue[] value = new LuaValue[1];
                value[0] = new LuaValue(LuaButton.this);
                LuaButton.this.function.invoke(value);
            }
        });
    }
    public void setFocusable(boolean focusable){
        this.button.setFocusable(focusable);
    }

    public CharSequence text(){
        return this.button.getText();
    }
}
