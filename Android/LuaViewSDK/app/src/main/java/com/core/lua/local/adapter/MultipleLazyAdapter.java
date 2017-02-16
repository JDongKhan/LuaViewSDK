package com.core.lua.local.adapter;

import java.util.List;

import android.content.Context;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AbsListView;
import android.widget.BaseAdapter;

import com.core.lua.local.ui.LSCActivity;
import com.core.lua.log.LuaConsole;
import com.core.lua.ui.LuaTableViewCell;

public abstract class MultipleLazyAdapter extends BaseAdapter {
	public Object tag;
	private List<?> dataList;
	private List<String> luaCells = null;
	public Context context;
	/**
	 * @title 如果不传layout_id 请在viewHolder类里面增加InjectLayer注解
	 * @param listView
	 * @param dataList
	 * @author wangjindong
	 */
	public MultipleLazyAdapter(AbsListView listView, List<?> dataList) {
		this.init(listView, dataList, null);
	}
	protected void init(AbsListView listView, List<?> dataList,List<String> luaCells){
		this.dataList = dataList;
		this.context = listView.getContext();
		listView.setOnScrollListener(new AbsListView.OnScrollListener() {
			@Override
			public void onScrollStateChanged(AbsListView absListView, int scrollState) {
			}
			@Override
			public void onScroll(AbsListView absListView, int firstVisibleItem, int visibleItemCount, int totalItemCount) {
			}
		});
		this.luaCells = luaCells;
	}
	@Override
	public int getCount() {
		if(dataList == null){
			return 0;
		}
		return dataList.size();
	}

	@Override
	public Object getItem(int arg0) {
		return dataList.get(arg0);
	}

	@Override
	public long getItemId(int arg0) {
		return 0;
	}

	@Override
	public int getItemViewType(int position) {
		int type  = this.indexOfLayoutsAtPosition(position);
		if(type >= 0){
			return type;
		}
		return super.getItemViewType(position);
	}

	@Override
	public int getViewTypeCount() {
		if(this.luaCells == null || this.luaCells.size() == 0){
			return 1;
		}
		return this.luaCells.size();
	}
	
	
	public abstract int indexOfLayoutsAtPosition(int position);

	@Override
	public View getView(int position, View convertView, ViewGroup arg2) {
		try {
			LuaTableViewCell cell = null;
			if (convertView == null) {
				int index = this.indexOfLayoutsAtPosition(position);
				try {
					//取viewHolderClass类型
					String luaName = null;
					if (this.luaCells != null && this.luaCells.size() > 0){
						luaName = this.luaCells.get(index);
					}
					//增加InjectLayer标签功能
					cell = new LuaTableViewCell((LSCActivity) this.context,luaName);
					cell._onCreate();
					//cell._setActivity(context);
					convertView = cell._getContentView();
				} catch (Exception e) {
					e.printStackTrace();
					if(this.luaCells.size() <= index){
						LuaConsole.log("在实例化viewHolder时出现错误 viewHolder数组越界，请检查indexOfLayoutsAtPosition返回的值是否大于viewHolder的长度");
					}else if(this.luaCells.get(index) == null){
						LuaConsole.log("在实例化viewHolder时出现错误 viewHolder == null，请检查是否设置viewHolder类");
					}else{
						LuaConsole.log("在实例化viewHolder时出现错误 viewHolder:"+this.luaCells.get(index)+",请检查viewHolder类是否设置正确");
					}
				}
				// 缓存绑定
				convertView.setTag(cell);
			} else {
				cell = (LuaTableViewCell) convertView.getTag();
			}
			if (cell != null){
				cell.setDataSource(dataList.get(position));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return convertView;
	}
	public void setLuaCells(List  luaCells) {
		this.luaCells = luaCells;
	}
	public Object getTag() {
		return tag;
	}
	public void setTag(Object tag) {
		this.tag = tag;
	}
}
