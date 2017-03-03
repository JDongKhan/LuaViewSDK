package com.core.lua.ui;

import android.graphics.Bitmap;
import android.widget.ImageButton;

import com.core.lua.local.net.NetworkInterface;
import com.core.lua.local.net.NetworkManager;
import com.core.lua.local.utils.ActivityManager;

import cn.vimfung.luascriptcore.LuaFunction;

/**
 * Created by JD on 2017/1/19.
 */
public class LuaImage extends LuaView{
    private ImageButton imageButton;
    private LuaFunction function;

    public LuaImage(){
        this.imageButton = new ImageButton(ActivityManager.getActivity());
        super.view = this.imageButton;
    }

    public void setImage(String image){
        NetworkManager.downImage(image, new NetworkInterface.ImageCallBack() {
            @Override
            public void callBack(Bitmap bitmap) {
                LuaImage.this.imageButton.setImageBitmap(bitmap);
            }
        });
    }

    public String image(){
        return null;
    }


}
