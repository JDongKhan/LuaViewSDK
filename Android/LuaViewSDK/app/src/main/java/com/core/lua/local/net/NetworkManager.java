package com.core.lua.local.net;

import java.util.Map;

/**
 * Created by JD on 2017/2/6.
 */
public class NetworkManager {

    public static NetworkInterface netWorkInterface;

    public static void register(NetworkInterface netWork){
            netWorkInterface = netWork;
    }

    public static void post(String url, Map params, NetworkInterface.NetworkCallBack callBack) {
        netWorkInterface.post(url, params, callBack);
    }

    public static void downImage(String url,NetworkInterface.ImageCallBack callBack) {
        netWorkInterface.downImage(url,callBack);
    }
}
