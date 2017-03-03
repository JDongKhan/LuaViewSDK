package com.core.lua.local.ui;

import android.app.Activity;
import android.util.Log;
import android.view.View;
import android.widget.RelativeLayout;

import com.core.lua.LuaScriptCoreManager;
import com.core.lua.local.bundle.Bundle;
import com.core.lua.local.utils.ActivityManager;
import com.core.lua.local.utils.SerializableMap;
import com.core.lua.ui.LuaActivity;
import cn.vimfung.luascriptcore.LuaValue;

import java.util.ArrayList;
import java.util.Map;


/**
 * Created by JD on 2017/1/18.
 */
public class LSCActivity extends Activity {

    public static int navigation_height = 180;

    private android.widget.RelativeLayout rootView;
    private NavigationView navigationView;
    private View contentView;
    private LuaActivity luaActivity;
    private String luaName;
    private Map  params;

    @Override
    protected void onCreate(android.os.Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        //管理activity
        ActivityManager.push(this);
        this.rootView = new android.widget.RelativeLayout(this);
        this.navigationView = new NavigationView(this);

        this.luaActivity = new LuaActivity(this,this.navigationView);
        this.contentView = this.luaActivity.getLuaView()._getView();

        this.rootView.addView(this.navigationView,new RelativeLayout.LayoutParams(RelativeLayout.LayoutParams.MATCH_PARENT,navigation_height));
        RelativeLayout.LayoutParams contentLp = new RelativeLayout.LayoutParams(RelativeLayout.LayoutParams.MATCH_PARENT,RelativeLayout.LayoutParams.MATCH_PARENT);
        contentLp.setMargins(0 ,navigation_height,0,0);
        this.rootView.addView(this.contentView,contentLp);

        //添加view
        this.setContentView(this.rootView,new android.widget.RelativeLayout.LayoutParams(RelativeLayout.LayoutParams.MATCH_PARENT, RelativeLayout.LayoutParams.MATCH_PARENT));

        this.luaName = this.getIntent().getStringExtra("luaName");
        SerializableMap serializableMap = (SerializableMap) this.getIntent().getExtras().get("params");
        if(serializableMap != null) {
            this.params = serializableMap.getMap();
        }
        this.didLoadView();
    }

    public void didLoadView(){
        String luaString = Bundle.getLuaScript(this,this.luaName);
        if (luaString == null || luaString.length() == 0){
            Log.d("lua_log","["+this.luaName+"]文件不存在或内容为空");
        }
        String methodName = "_"+this.hashCode();
        String luaScript = "function "+methodName+"(this,request) "+luaString+" end";
        LuaScriptCoreManager.shareInstance().evalScript(luaScript);
        ArrayList<LuaValue> list = new ArrayList<LuaValue>();
        list.add(new LuaValue(this.luaActivity));
        if(this.params != null) {
            list.add(new LuaValue(this.params));
        }
        LuaValue[] arguments = new LuaValue[list.size()];
        for (int i = 0 ; i < list.size(); i++){
            arguments[i] = list.get(i);
        }
        LuaScriptCoreManager.shareInstance().callMethod(methodName,arguments);
    }
    public void pushLuaView(String luaName,Map params){
        this.luaActivity.pushLuaView(luaName, params);
    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
        ActivityManager.pop(this.luaActivity);
    }
}
