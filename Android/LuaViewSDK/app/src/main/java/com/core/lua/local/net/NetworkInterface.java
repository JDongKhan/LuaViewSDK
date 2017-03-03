package com.core.lua.local.net;

import android.graphics.Bitmap;

import java.util.Map;


/**
 * Created by JD on 2017/2/6.
 */
public interface NetworkInterface {

    void post(String url, Map params,NetworkCallBack callBack);
    void downImage(String url,ImageCallBack callBack);

    public static interface NetworkCallBack{
        void callBack(boolean success,Map result);
    }
    public static interface ImageCallBack{
        void callBack(Bitmap bitmap);
    }
}
