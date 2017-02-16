package cn.core.test.demo.controller;

import android.app.Activity;
import android.os.Bundle;

/**
 * Created by wangjindong on 2017/1/19.
 */
public class BaseActivity extends Activity {

    private BaseController controller;

    @Override
    protected void onStart() {
        super.onStart();
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        String key = this.getIntent().getStringExtra("key");
        this.controller = ControllerManager.getController(key);
        int id = this.controller.layout_id();
        this.setContentView(id);
        this.controller.setActivity(this);
        this.controller.onCreate();
    }

    @Override
    protected void onRestart() {
        super.onRestart();
    }

    @Override
    protected void onPause() {
        super.onPause();
    }

    @Override
    protected void onStop() {
        super.onStop();
    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
        ControllerManager.popController(this.controller);
    }
}
