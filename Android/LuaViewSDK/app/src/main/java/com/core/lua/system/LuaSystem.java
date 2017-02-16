package com.core.lua.system;

import android.app.Application;
import android.content.Context;
import android.util.DisplayMetrics;
import android.view.WindowManager;


import com.core.lua.local.ui.LSCActivity;
import com.core.lua.local.utils.ActivityManager;

import java.lang.reflect.Field;

import cn.vimfung.luascriptcore.LuaTuple;
import cn.vimfung.luascriptcore.modules.oo.LuaObjectClass;

/**
 * Created by JD on 2017/1/18.
 */
public class LuaSystem extends LuaObjectClass {
    private  static float density ;

    public static LuaTuple screenSize(){
        DisplayMetrics metric = new DisplayMetrics();
        Application context = ActivityManager.application;
        WindowManager wm = (WindowManager) context.getSystemService(Context.WINDOW_SERVICE);
        wm.getDefaultDisplay().getMetrics(metric);
        int width = metric.widthPixels;  // 屏幕宽度（像素）
        int height = metric.heightPixels;  // 屏幕高度（像素）
        int statusBarHeight = getStatusBarHeight();
        float density = metric.density;
        width = (int)(width/density);
        height = (int)((height-statusBarHeight- LSCActivity.navigation_height)/density);
        LuaTuple  tuple = new LuaTuple();
        tuple.addReturnValue(width);
        tuple.addReturnValue(height);
        return tuple;
    }

    public static float screenScale(){
        if (density <= 0) {
            DisplayMetrics metric = new DisplayMetrics();
            Context context = ActivityManager.getActivity();
            WindowManager wm = (WindowManager) context.getSystemService(Context.WINDOW_SERVICE);
            wm.getDefaultDisplay().getMetrics(metric);
            density = metric.density;  // 屏幕密度（0.75 / 1.0 / 1.5）
            //int densityDpi = metric.densityDpi;  // 屏幕密度DPI（120 / 160 / 240）
        }
        return density;
    }


    public static int getStatusBarHeight() {
        Class<?> c = null;
        Object obj = null;
        Field field = null;
        int x = 0, sbar = 0;
        try {
            c = Class.forName("com.android.internal.R$dimen");
            obj = c.newInstance();
            field = c.getField("status_bar_height");
            x = Integer.parseInt(field.get(obj).toString());
            Application context = ActivityManager.application;
            sbar = context.getResources().getDimensionPixelSize(x);
        } catch (Exception e1) {
            e1.printStackTrace();
        }
        return sbar;
    }
}
