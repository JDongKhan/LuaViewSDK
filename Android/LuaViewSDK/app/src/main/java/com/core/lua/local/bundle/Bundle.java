package com.core.lua.local.bundle;

import android.content.Context;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.os.Environment;

import com.core.lua.local.utils.ActivityManager;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;

import cn.core.test.demo.R;

/**
 * Created by JD on 2017/1/18.
 */
public class Bundle {


    public static String down_cache_url = "luadown";

    public static String getLuaScript(Context context,String fileName){
        if (fileName.indexOf("lua") == -1){
            fileName = fileName+".lua";
        }
        String files_target_url = Bundle.getCacheDir(context)+ File.separator+down_cache_url;
        String fileUrl = files_target_url+File.separator+fileName;
        File file = new File(fileUrl);
        InputStream in = null;
        if (file.exists()){
            try {
                in = new FileInputStream(fileUrl);
            } catch (FileNotFoundException e) {
                e.printStackTrace();
            }
        }else{
            try {
                in = context.getAssets().open(fileName);//获取资源
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        try {
            InputStreamReader inputStreamReader = new InputStreamReader(in, "UTF-8");
            BufferedReader bufferedReader = new BufferedReader(inputStreamReader);
            StringBuffer buffer = new StringBuffer("");
            String str;
            while ((str = bufferedReader.readLine()) != null) {
                buffer.append(str);
                buffer.append("\n");
            }
            return buffer.toString();
        }catch (Exception e){

        }
       return "";
    }

    public static String getFromAssets(Context context,String fileName){
        String result = "";
        try{
            InputStream in = context.getAssets().open(fileName);//获取资源
            InputStreamReader inputStreamReader = new InputStreamReader(in, "UTF-8");
            BufferedReader bufferedReader = new BufferedReader(inputStreamReader);
            StringBuffer buffer = new StringBuffer("");
            String str;
            while ((str = bufferedReader.readLine()) != null) {
                buffer.append(str);
                buffer.append("\n");
            }
            return buffer.toString();
        }catch (Exception e) {
        }
        return result;
    }

    public static Bitmap getImage(String path){
        InputStream is = null;
        try {
            path = "res/"+path;
            is = ActivityManager.getActivity().getAssets().open(path);
        } catch (IOException e) {
            e.printStackTrace();
        }
        Bitmap bitmap= BitmapFactory.decodeStream(is);
        return bitmap;
    }

    public static File getCacheDir(Context context) {
        File appCacheDir = null;
        int perm = context.checkCallingOrSelfPermission("android.permission.WRITE_EXTERNAL_STORAGE");
        if("mounted".equals(Environment.getExternalStorageState()) && perm == 0) {
            appCacheDir = context.getExternalCacheDir();
        }
        if(appCacheDir == null) {
            appCacheDir = context.getCacheDir();
        }
        return appCacheDir;
    }

}
