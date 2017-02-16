package com.core.lua.bundle;

import android.content.Context;

import com.core.lua.local.bundle.Bundle;
import com.core.lua.local.utils.ActivityManager;

import cn.vimfung.luascriptcore.modules.oo.LuaObjectClass;

/**
 * Created by JD on 2017/2/14.
 */
public class LuaBundle extends LuaObjectClass{

    public static String getLuaScript(String fileName){
        return Bundle.getLuaScript(ActivityManager.application,fileName);
    }
}
