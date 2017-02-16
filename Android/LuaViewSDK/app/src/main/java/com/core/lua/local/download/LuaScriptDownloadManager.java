package com.core.lua.local.download;

import android.content.Context;

import com.core.lua.LuaScriptCoreManager;
import com.core.lua.local.bundle.Bundle;

import java.io.File;

/**
 * Created by JD on 2017/2/13.
 */
public class LuaScriptDownloadManager {
    public static String zip_down_cache_url = "zipluadown";
    /**
     * 下载文件并解压
     * @param context
     * @param down_url
     */
    public static void down(Context context,String down_url){
        String fileName = down_url.substring(down_url.lastIndexOf("/") + 1);;
        String zip_target_url = Bundle.getCacheDir(context)+ File.pathSeparator+zip_down_cache_url+File.pathSeparator+fileName;
        String files_target_url = Bundle.getCacheDir(context)+ File.pathSeparator+ Bundle.down_cache_url;
        //下载文件
        FileDownload.down(context,down_url,zip_target_url);
        //解压文件
        try {
            FileZip.unZipFolder(zip_target_url,files_target_url);
            //文件增加搜索路径
            File cacheDir = new File(files_target_url);
            if(!cacheDir.exists()) {
                cacheDir.mkdirs();
            }
            LuaScriptCoreManager.shareInstance().addSearchPath(cacheDir.toString());
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
