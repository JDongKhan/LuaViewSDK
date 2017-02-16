package com.core.lua.local.utils;

import android.app.Activity;
import android.app.Application;

import com.core.lua.ui.LuaActivity;

import java.util.HashMap;
import java.util.Map;
import java.util.Stack;

/**
 * Created by JD on 2017/2/10.
 */
public class ActivityManager {
    private static Stack<Activity> activityStack = new Stack();
    public static Application application;

    public static void push(Activity activity) {
        if (application == null) {
            application = activity.getApplication();
        }
        activityStack.push(activity);
    }

    public static void pop(LuaActivity luaActivity) {
        activityStack.pop();
    }

    public static Activity getActivity() {
        return activityStack.peek();
    }
}
