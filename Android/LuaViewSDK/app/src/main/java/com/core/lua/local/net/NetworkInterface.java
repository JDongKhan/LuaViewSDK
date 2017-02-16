package com.core.lua.local.net;

import java.util.Map;


/**
 * Created by JD on 2017/2/6.
 */
public interface NetworkInterface {

    void post(String url, Map params,NetworkCallBack callBack);

    public static interface NetworkCallBack{
        void callBack(boolean success,Map result);
    }
}
