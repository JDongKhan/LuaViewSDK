package cn.core.test.demo;

import android.graphics.Bitmap;
import android.graphics.BitmapFactory;

import com.core.lua.local.bundle.Bundle;
import com.core.lua.local.net.NetworkInterface;
import com.core.lua.local.utils.ActivityManager;

import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by JD on 2017/2/7.
 */
public class ScriptNetWork implements NetworkInterface {
    @Override
    public void post(String url, Map params, NetworkCallBack callBack) {
        Map map = new HashMap();
        map.put("aa","aa");
        Map map1 = new HashMap();
        map1.put("bb","bb");
        map.put("cc",map1);
        callBack.callBack(true,map);
    }

    @Override
    public void downImage(String url, ImageCallBack callBack) {
        if (callBack != null){
            callBack.callBack(Bundle.getImage(url));
        }
    }
}
