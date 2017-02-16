package cn.core.test.demo.controller;

import android.app.Activity;
import android.content.Intent;

/**
 * Created by Administrator on 2017/1/19.
 */
public abstract class BaseController {

    public Activity activity;

    public BaseController(){

    }

    public void setActivity(Activity activity) {
        this.activity = activity;
    }

    public void startView(BaseController view){
        Intent intent = new Intent(this.activity, BaseActivity.class);
        String key = ControllerManager.pushController(view);
        intent.putExtra("key",key);
        this.activity.startActivity(intent);
    }
    protected abstract int layout_id();
    protected abstract void onCreate();
}
