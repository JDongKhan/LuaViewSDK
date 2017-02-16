package com.core.lua.ui;

import android.view.View;
import android.widget.AdapterView;
import android.widget.ListView;
import com.core.lua.local.adapter.MultipleLazyAdapter;
import com.core.lua.local.utils.ActivityManager;
import java.util.ArrayList;
import java.util.List;

import cn.vimfung.luascriptcore.LuaFunction;
import cn.vimfung.luascriptcore.LuaValue;

/**
 * Created by JD on 2017/1/23.
 */
public class LuaTableView extends LuaView {
    private ListView listView;
    private List dataInfo = new ArrayList();
    private MultipleLazyAdapter adapter;
    private LuaFunction itemClick;
    private LuaFunction layoutIndex;

    public LuaTableView(){
        this.listView = new ListView(ActivityManager.getActivity());
        super.view = this.listView;
        this.adapter = new MultipleLazyAdapter(this.listView, this.dataInfo) {
            @Override
            public int indexOfLayoutsAtPosition(int position) {
                if (layoutIndex == null) {
                    return 0;
                }else {
                    LuaValue[] v = new LuaValue[1];
                    v[0] = new LuaValue(position);
                    LuaValue value =  layoutIndex.invoke(v);
                    int  p = value.toInteger();
                    return p;
                }
            }
        };
        this.listView.setAdapter(this.adapter);
        this.listView.setOnItemClickListener(new AdapterView.OnItemClickListener() {
            @Override
            public void onItemClick(AdapterView<?> parent, View view, int position, long id) {
                LuaValue[] p = new LuaValue[1];
                p[0] = new LuaValue(position);
                if (LuaTableView.this.itemClick != null) {
                    LuaTableView.this.itemClick.invoke(p);
                }
            }
        });
    }
    public void setCell(String luaName){
         List list = new ArrayList();
        list.add(luaName);
        this.adapter.setLuaCells(list);
    }
    public void setCells(List luaNames){
        this.adapter.setLuaCells(luaNames);
    }
    public void setItems(List dataInfo){
        this.dataInfo.clear();
        this.dataInfo.addAll(dataInfo);
        this.adapter.notifyDataSetChanged();
    }
    public void setLayoutIndex(LuaFunction layoutIndex){
        this.layoutIndex = layoutIndex;
    }
    public void setItemClick(LuaFunction itemClick){
        this.itemClick = itemClick;
    }
}
