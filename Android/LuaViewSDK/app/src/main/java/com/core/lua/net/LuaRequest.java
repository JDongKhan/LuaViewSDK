package com.core.lua.net;

import com.core.lua.local.net.NetworkInterface;
import com.core.lua.local.net.NetworkManager;

import java.util.Map;

import cn.vimfung.luascriptcore.LuaFunction;
import cn.vimfung.luascriptcore.LuaValue;
import cn.vimfung.luascriptcore.modules.oo.LuaObjectClass;

/**
 * Created by JD on 2017/2/6.
 */
public class LuaRequest extends LuaObjectClass {

    public static void post(String url,Map params,final LuaFunction success,final LuaFunction fail){
        System.out.println("post");
        NetworkManager.post(url, params, new NetworkInterface.NetworkCallBack() {
            @Override
            public void callBack(boolean s, Map result) {
                LuaValue[] resultValue = new LuaValue[1];
                resultValue[0] = new LuaValue(result);
                if (s){
                    if (success != null) {
                        success.invoke(resultValue);
                    }
                }else{
                    if (fail != null) {
                        fail.invoke(resultValue);
                    }
                }
            }
        });
    }
}
