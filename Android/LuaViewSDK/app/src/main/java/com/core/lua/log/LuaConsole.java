package com.core.lua.log;


import android.util.Log;

import cn.vimfung.luascriptcore.modules.oo.LuaObjectClass;


/**
 * Created by JD on 2017/1/18.
 */
public class LuaConsole extends LuaObjectClass {
    public static void log(String msg){
        if (msg == null){
         Log.d("lua_log","null");
        }else {
            Log.d("lua_log", msg);
        }
    }
}
