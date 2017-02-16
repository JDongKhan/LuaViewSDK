package com.core.lua.local.utils;

import java.io.Serializable;
import java.util.Map;

/**
 * Created by JD on 2017/1/22.
 */
public class SerializableMap implements Serializable {

    private Map<String,Object> map;
    public Map<String,Object> getMap() {
        return map;
    }
    public SerializableMap(Map<String,Object> map){
        this.map = map;
    }
    public void setMap(Map<String,Object> map) {
        this.map=map;
    }
}
