package com.core.lua.ui;

import android.view.View;
import com.core.lua.LuaScriptCoreManager;
import com.core.lua.local.bundle.Bundle;
import com.core.lua.local.ui.LSCActivity;
import com.core.lua.local.ui.LuaViewGroup;

import java.util.ArrayList;
import java.util.Map;

import cn.vimfung.luascriptcore.LuaFunction;
import cn.vimfung.luascriptcore.LuaTuple;
import cn.vimfung.luascriptcore.LuaValue;
import cn.vimfung.luascriptcore.modules.oo.LuaObjectClass;

/**
 * Created by JD on 2017/1/23.
 */
public class LuaTableViewCell extends LuaObjectClass {
    private LuaView contentView;
    private LuaLabel lable = null;
    private String luaName;
    private LSCActivity activity;
    private LuaFunction loadView,loadData;
    public LuaTableViewCell(LSCActivity activity,String luaName){
        this.activity = activity;
        this.luaName = luaName;
    }
    public View _getContentView(){
        return this.contentView._getView();
    }
    public void _onCreate() {
        this.contentView = new LuaView();
        this.contentView.setBackgroundColor("#ffffff");
        this.contentView.setLayoutType(LuaViewGroup.Layout.RELATIVE_LAYOUT.key);
        if (this.luaName == null) {
            lable = new LuaLabel();
            this.contentView.addSubView(lable);
        }else{
            String luaString = Bundle.getLuaScript(this.activity,this.luaName);
            String methodName = "_"+this.hashCode();
            String luaScript = "function "+methodName+"(this) "+luaString+" return loadView,loadData end";
            LuaScriptCoreManager.shareInstance().evalScript(luaScript);
            ArrayList<LuaValue> list = new ArrayList<LuaValue>();
            list.add(new LuaValue(this));
            LuaValue[] arguments = new LuaValue[list.size()];
            for (int i = 0 ; i < list.size(); i++){
                arguments[i] = list.get(i);
            }
            LuaValue value =  LuaScriptCoreManager.shareInstance().callMethod(methodName,arguments);
            LuaTuple tuple = value.toTuple();
            this.loadView = (LuaFunction) tuple.getReturnValueByIndex(0);
            this.loadData = (LuaFunction) tuple.getReturnValueByIndex(1);
            LuaValue[] v = new LuaValue[1];
            v[0] = new LuaValue(this.contentView);
            this.loadView.invoke(v);
        }
    }
    public void addSubView(LuaView view){
        this.contentView.addSubView(view);
    }
    public void removeSubView(LuaView view){
        this.contentView.removeSubView(view);
    }

    public void setDataSource(Object obj){
        if(this.lable != null) {
            this.lable.setText(obj.toString());
        }else{
            LuaValue[] v = new LuaValue[1];
            v[0] = new LuaValue(obj);
            this.loadData.invoke(v);
        }
    }
    public void pushLuaView(String luaName,Map params){
        this.activity.pushLuaView(luaName, params);
    }
}
