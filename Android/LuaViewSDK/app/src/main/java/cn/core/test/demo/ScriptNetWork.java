package cn.core.test.demo;

import com.core.lua.local.net.NetworkInterface;

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
}
