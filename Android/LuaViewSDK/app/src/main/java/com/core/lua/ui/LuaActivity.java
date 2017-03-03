package com.core.lua.ui;

import android.app.Activity;
import android.content.Intent;
import android.graphics.Color;
import android.view.View;


import com.core.lua.local.ui.LSCActivity;
import com.core.lua.local.ui.LuaViewGroup;
import com.core.lua.local.ui.NavigationView;
import com.core.lua.local.utils.SerializableMap;

import java.util.Map;

import cn.vimfung.luascriptcore.LuaFunction;
import cn.vimfung.luascriptcore.LuaValue;
import cn.vimfung.luascriptcore.modules.oo.LuaObjectClass;

/**
 * Created by JD on 2017/1/17.
 */
public class LuaActivity extends LuaObjectClass {
    private Activity activity;
    private NavigationView navigationView;
    private LuaView luaView;

    public LuaView getLuaView(){
        return luaView;
    }
    public LuaActivity(Activity activity,NavigationView navigationView){
        this.activity = activity;
        this.navigationView = navigationView;
        this.luaView = new LuaView();
        this.luaView.setLuaActivity(this);
        this.luaView.setBackgroundColor("#ffffff");
        this.luaView.setLayoutType(LuaViewGroup.Layout.RELATIVE_LAYOUT.key);
        this.luaView._onLayout();
    }

    /*********************************导航**********************************************/
    public void setNavigationBackgroundColor(String color){
        this.navigationView.setBackgroundColor(color);
    }
    public void setTitle(String title){
        this.navigationView.setTitle(title);
    }
    public void setBackTitle(String title){
        this.navigationView.setBackTitle(title);
    }
    public void setTitleColor(String color){
        this.navigationView.setTitleColor(color);
    }
    public void setBackTitleColor(String color){
        this.navigationView.setBackTitleColor(color);
    }
    public void addMenu(String title, final LuaFunction click){
        //TODO
        this.navigationView.addMenu(title, new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                if (click != null){
                    LuaValue[] p = new LuaValue[1];
                    p[0] = new LuaValue(view);
                    click.invoke(p);
                }
            }
        });
    }

    /************************************view************************************/

    public void addSubView(LuaView view){
        this.luaView.addSubView(view);
    }
    public void removeSubView(LuaView view){
        this.luaView.removeSubView(view);
    }
    public void setBackgroundColor(String color){
        this.luaView.setBackgroundColor(color);
    }




    /***********************************跳转********************************************/
    public void pushLuaView(String luaName,Map params){
        SerializableMap serializableMap = new SerializableMap(params);
        Intent intent = new Intent(this.activity, LSCActivity.class);
        if (luaName.indexOf("lua") == -1){
            luaName = luaName+".lua";
        }
        intent.putExtra("luaName",luaName);
        intent.putExtra("params",serializableMap);
        this.activity.startActivity(intent);
    }

}
