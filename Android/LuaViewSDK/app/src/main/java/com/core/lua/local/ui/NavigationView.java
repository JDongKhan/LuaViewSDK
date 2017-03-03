package com.core.lua.local.ui;

import android.app.Activity;
import android.content.Context;
import android.graphics.Color;
import android.util.AttributeSet;
import android.view.Gravity;
import android.view.View;
import android.widget.Button;
import android.widget.LinearLayout;
import android.widget.RelativeLayout;
import android.widget.TextView;
/**
 * @author wangjindong
 */
public class NavigationView extends RelativeLayout{
	private LinearLayout navigation_back_layout;
	private Button navigation_back;

	private LinearLayout navigation_title_layout;
	private TextView navigation_title;

	private LinearLayout navigation_detail_layout;
	private TextView navigation_detail;

	private LinearLayout navigation_menu_layout;

	public NavigationView(Context context) {
		super(context);
		this.initView(context);
	}

	public NavigationView(Context context, AttributeSet attrs) {
		super(context, attrs);
		this.initView(context);
	}

	private void initView(Context context){
		this.setBackgroundColor(Color.WHITE);
		this.initBack(context);
		this.initTitle(context);
		this.initMenu(context);
		RelativeLayout.LayoutParams backLp = new RelativeLayout.LayoutParams(LayoutParams.WRAP_CONTENT,LayoutParams.WRAP_CONTENT);
		backLp.addRule(RelativeLayout.ALIGN_PARENT_LEFT,RelativeLayout.TRUE);
		backLp.addRule(RelativeLayout.CENTER_VERTICAL,RelativeLayout.TRUE);
		this.addView(this.navigation_back_layout,backLp);

		RelativeLayout.LayoutParams titleLp = new RelativeLayout.LayoutParams(LayoutParams.WRAP_CONTENT,LayoutParams.WRAP_CONTENT);
		titleLp.addRule(RelativeLayout.CENTER_HORIZONTAL,RelativeLayout.TRUE);
		titleLp.addRule(RelativeLayout.CENTER_VERTICAL,RelativeLayout.TRUE);
		this.addView(this.navigation_title_layout,titleLp);

		RelativeLayout.LayoutParams menuLp = new RelativeLayout.LayoutParams(LayoutParams.WRAP_CONTENT,LayoutParams.WRAP_CONTENT);
		menuLp.addRule(RelativeLayout.ALIGN_PARENT_RIGHT,RelativeLayout.TRUE);
		menuLp.addRule(RelativeLayout.CENTER_VERTICAL,RelativeLayout.TRUE);
		menuLp.setMargins(0,0,0,10);
		this.addView(this.navigation_menu_layout,menuLp);
	}

	private void initBack(final Context context){
		this.navigation_back_layout = new LinearLayout(context);
		this.navigation_back = new Button(context);
		this.navigation_back.setOnClickListener(new OnClickListener() {
			@Override
			public void onClick(View v) {
				if (context instanceof Activity){
					((Activity)context).finish();
				}
			}
		});
		this.navigation_back.setText("返回");
		this.navigation_back.setPadding(0,0,0,0);
		this.navigation_back_layout.addView(this.navigation_back,new LinearLayout.LayoutParams(LinearLayout.LayoutParams.WRAP_CONTENT,LinearLayout.LayoutParams.WRAP_CONTENT));
	}

	private void initTitle(Context context){
		this.navigation_title_layout = new LinearLayout(context);
		this.navigation_title_layout.setGravity(Gravity.CENTER);
		this.navigation_title_layout.setOrientation(LinearLayout.VERTICAL);

		this.navigation_title = new TextView(context);
		this.navigation_title.setSingleLine();

		this.navigation_detail_layout = new LinearLayout(context);
		this.navigation_detail_layout.setGravity(Gravity.BOTTOM);
		this.navigation_detail_layout.setOrientation(LinearLayout.HORIZONTAL);

		this.navigation_detail = new TextView(context);
		this.navigation_detail.setSingleLine();
		this.navigation_detail.setVisibility(View.GONE);

		this.navigation_detail_layout.addView(this.navigation_detail,new LinearLayout.LayoutParams(LinearLayout.LayoutParams.WRAP_CONTENT,LinearLayout.LayoutParams.WRAP_CONTENT));
		this.navigation_title_layout.addView(this.navigation_title,new LinearLayout.LayoutParams(LinearLayout.LayoutParams.WRAP_CONTENT,LinearLayout.LayoutParams.WRAP_CONTENT));
		this.navigation_title_layout.addView(this.navigation_detail_layout,new LinearLayout.LayoutParams(LinearLayout.LayoutParams.WRAP_CONTENT,LinearLayout.LayoutParams.WRAP_CONTENT));
	}
	private void initMenu(Context context){
		this.navigation_menu_layout = new LinearLayout(context);
		this.navigation_menu_layout.setOrientation(LinearLayout.HORIZONTAL);
		this.navigation_menu_layout.setMinimumWidth(25);
		this.navigation_menu_layout.setPadding(10,10,10,10);
	}

	public void setBackgroundColor(String color){
		this.setBackgroundColor(Color.parseColor(color));
	}
	/**
	 * @param @param activity
	 * @param @param title
	 * @return void
	 * @throws
	 * @Title: setTitle
	 * @Description: 设置标题
	 */
	public void setTitle(String title) {
		TextView titleView = this.navigation_title;
		if (title == null) {
			titleView.setVisibility(View.GONE);
		} else {
			titleView.setVisibility(View.VISIBLE);
			titleView.setText(title);
		}
	}
	public void setTitleColor(String color) {
		TextView titleView = this.navigation_title;
		titleView.setTextColor(Color.parseColor(color));
	}
	/**
	 * @param @param title
	 * @return void
	 * @Description: 返回按钮
	 */
	public  void setBackTitle(String text) {
		Button backView = this.navigation_back;
		if (text == null) {
			backView.setVisibility(View.GONE);
		} else {
			backView.setVisibility(View.VISIBLE);
			backView.setText(text);
		}
	}
	public  void setBackTitleColor(String color) {
		Button backView = this.navigation_back;
		backView.setTextColor(Color.parseColor(color));
	}
	/**
	 * @param @param text
	 * @param @param onClickListener
	 * @return void
	 * @Description: 返回按钮
	 */
	public  void setBackTitle(String text,
	                           final OnClickListener onClickListener) {
		Button backView = this.navigation_back;
		if (text == null) {
			backView.setVisibility(View.GONE);
		} else {
			backView.setVisibility(View.VISIBLE);
			backView.setText(text);
			backView.setOnClickListener(new OnClickListener() {
				@Override
				public void onClick(View v) {
					Context context = v.getContext();
					if (context instanceof Activity){
						((Activity)context).finish();
					}
					if (onClickListener != null){
						onClickListener.onClick(v);
					}
				}
			});
		}
	}

	public void addMenu(String title,OnClickListener onClickListener){
		Button button = new Button(this.getContext());
		button.setText(title);
		button.setOnClickListener(onClickListener);
		this.navigation_menu_layout.addView(button);
	}

}
