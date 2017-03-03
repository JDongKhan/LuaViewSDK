package cn.core.test.demo;

import android.content.Intent;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.RelativeLayout;

import com.core.lua.LuaScriptCoreManager;
import com.core.lua.local.ui.LSCActivity;

public class MainActivity extends AppCompatActivity {


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        LuaScriptCoreManager.shareInstance().register(this.getApplicationContext());
        LuaScriptCoreManager.shareInstance().registerNetwork(new ScriptNetWork());
        //注册类按钮
        Button nextBtn = (Button) findViewById(R.id.nextButton);
        if (nextBtn != null)
        {
            nextBtn.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View v) {
                    Intent intent = new Intent(MainActivity.this, LSCActivity.class);
                    intent.putExtra("luaName","list.lua");
                    MainActivity.this.startActivity(intent);
                 }
            });
        }
    }

}
