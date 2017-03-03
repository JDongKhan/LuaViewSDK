package com.core.lua.ui;

import android.graphics.Bitmap;
import android.graphics.Color;
import android.graphics.drawable.BitmapDrawable;
import android.graphics.drawable.Drawable;
import android.view.View;
import android.widget.Button;

import com.core.lua.local.net.NetworkInterface;
import com.core.lua.local.net.NetworkManager;
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
    public void setTextFont(String textFont){
        float font = Float.valueOf(textFont);
        this.button.setTextSize(font);
    }
    public void setFocusable(boolean focusable){
        this.button.setFocusable(focusable);
    }
    public void setLeftImage(String image){
        NetworkManager.downImage(image, new NetworkInterface.ImageCallBack() {
            @Override
            public void callBack(Bitmap bitmap) {
                Drawable d = new BitmapDrawable(LuaButton.this.button.getContext().getResources(),bitmap);
                LuaButton.this.button.setCompoundDrawablesWithIntrinsicBounds(d,null,null,null);
            }
        });
    }
    public void setTopImage(String image){
        NetworkManager.downImage(image, new NetworkInterface.ImageCallBack() {
            @Override
            public void callBack(Bitmap bitmap) {
                Drawable d = new BitmapDrawable(LuaButton.this.button.getContext().getResources(),bitmap);
                LuaButton.this.button.setCompoundDrawablesWithIntrinsicBounds(null,d,null,null);
            }
        });
    }

    public void setRightImage(String image){
        NetworkManager.downImage(image, new NetworkInterface.ImageCallBack() {
            @Override
            public void callBack(Bitmap bitmap) {
                Drawable d = new BitmapDrawable(LuaButton.this.button.getContext().getResources(),bitmap);
                LuaButton.this.button.setCompoundDrawablesWithIntrinsicBounds(null,null,d,null);
            }
        });
    }

    public void setBottomImage(String image){
        NetworkManager.downImage(image, new NetworkInterface.ImageCallBack() {
            @Override
            public void callBack(Bitmap bitmap) {
                Drawable d = new BitmapDrawable(LuaButton.this.button.getContext().getResources(),bitmap);
                LuaButton.this.button.setCompoundDrawablesWithIntrinsicBounds(null,null,null,d);
            }
        });
    }
    public void setBackgroundImage(String backgroundImage){
        NetworkManager.downImage(backgroundImage, new NetworkInterface.ImageCallBack() {
            @Override
            public void callBack(Bitmap bitmap) {
                Drawable d = new BitmapDrawable(LuaButton.this.button.getContext().getResources(),bitmap);
                LuaButton.this.button.setBackground(d);
            }
        });
    }
    public void setEnable(boolean enable){
        this.button.setEnabled(enable);
    }
    public void setSelected(boolean selected){
        this.button.setSelected(selected);
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

    /*************************************************************************/
    public CharSequence text(){
        return this.button.getText();
    }
    public String textColor(){
        return null;
    }
    public String textFont(){
        return null;
    }
    public boolean focusable(){
        return false;
    }
    public String image(){
        return null;
    }
    public String backgroundImage(){
        return null;
    }
    public boolean enable(){
        return false;
    }
    public boolean selected(){
        return false;
    }
}
