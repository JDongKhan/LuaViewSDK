package com.core.lua.ui;

import android.graphics.Color;
import android.widget.EditText;

import com.core.lua.local.utils.ActivityManager;


/**
 * Created by JD on 2017/1/19.
 */
public class LuaTextField extends LuaView{
    private EditText editText;

    public LuaTextField(){
        this.editText = new EditText(ActivityManager.getActivity());
        super.view = this.editText;
    }

    public void setText(String text){
        this.editText.setText(text);
    }
    public void setTextColor(String color){
        this.editText.setTextColor(Color.parseColor(color));
    }

    public CharSequence text(){
        return this.editText.getText();
    }
}
