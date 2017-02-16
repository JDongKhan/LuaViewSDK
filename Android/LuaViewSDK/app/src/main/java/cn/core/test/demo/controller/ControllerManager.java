package cn.core.test.demo.controller;

import java.util.HashMap;
import java.util.Map;

/**
 * Created by Administrator on 2017/1/19.
 */
public class ControllerManager {

    private static Map<String,BaseController> controllerMap = new HashMap<>();

    public static String pushController(BaseController controller){
        String key = controller.getClass().getSimpleName()+"_"+controller.hashCode();
        controllerMap.put(key,controller);
        return key;
    }
    public static void popController(BaseController controller){
        String key = controller.getClass().getSimpleName()+"_"+controller.hashCode();
        controllerMap.remove(key);
    }

    public static BaseController getController(String key){
        return controllerMap.get(key);
    }
}
