package com.core.lua;

import android.content.Context;
import android.util.Log;

import com.core.lua.bundle.LuaBundle;
import com.core.lua.dialog.LuaDialog;
import com.core.lua.local.net.NetworkInterface;
import com.core.lua.local.net.NetworkManager;
import com.core.lua.log.LuaConsole;
import com.core.lua.net.LuaRequest;
import com.core.lua.system.LuaSystem;
import com.core.lua.ui.LuaActivity;
import com.core.lua.ui.LuaButton;
import com.core.lua.ui.LuaTextField;
import com.core.lua.ui.LuaImage;
import com.core.lua.ui.LuaLabel;
import com.core.lua.ui.LuaTableView;
import com.core.lua.ui.LuaTableViewCell;
import com.core.lua.ui.LuaView;

import java.util.ArrayList;
import java.util.List;

import cn.vimfung.luascriptcore.LuaContext;
import cn.vimfung.luascriptcore.LuaExceptionHandler;
import cn.vimfung.luascriptcore.LuaValue;

/**
 * Created by JD on 2017/1/17.
 */
public class LuaScriptCoreManager {

    private LuaContext _luaContext;
    private static LuaScriptCoreManager _instance;

    public LuaContext getLuaContext(){
        return _luaContext;
    }
    public LuaScriptCoreManager(){
    }

    public void register(Context context){
        //创建LuaContext
        _luaContext = LuaContext.create(context);
        _luaContext.onException(new LuaExceptionHandler() {
            @Override
            public void onException(String s) {
                Log.d("luaScriptCore","---------------------------------------------");
                Log.d("luaScriptCore",s);
                Log.d("luaScriptCore","---------------------------------------------");
            }
        });
        this.registerAllModule();
    }

    public void registerNetwork(NetworkInterface netWork){
        NetworkManager.register(netWork);
    }

    public static LuaScriptCoreManager shareInstance(){
        if (_instance == null){
            _instance = new LuaScriptCoreManager();
        }
        return _instance;
    }

    public void registerAllModule() {
        List<Class> list = new ArrayList<Class>();
        list.add(LuaActivity.class);
        list.add(LuaView.class);
        list.add(LuaButton.class);
        list.add(LuaConsole.class);
        list.add(LuaSystem.class);
        list.add(LuaLabel.class);
        list.add(LuaImage.class);
        list.add(LuaTextField.class);
        list.add(LuaTableView.class);
        list.add(LuaTableViewCell.class);
        list.add(LuaRequest.class);
        list.add(LuaDialog.class);
        list.add(LuaBundle.class);
        for (Class clazz : list){
            this.registerModule(clazz);
        }
    }

    public void registerModule(Class clazz){
        this._luaContext.registerModule(clazz);
    }

    public LuaValue evalScript(String script) {
        return this._luaContext.evalScript(script);
    }

    public LuaValue evalScriptFromFile(String filePath) {
        return this._luaContext.evalScriptFromFile(filePath);
    }

    public LuaValue callMethod(String methodName, LuaValue[] arguments) {
        return this._luaContext.callMethod(methodName, arguments);
    }
    public void addSearchPath(String path){
        this._luaContext.addSearchPath(path);
    }

}
