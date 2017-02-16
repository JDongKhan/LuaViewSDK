package com.core.lua.local.download;

import android.content.Context;

import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URL;
import java.net.URLConnection;

/**
 * Created by JD on 2017/2/13.
 */
public class FileDownload {
    public static void  down(Context context,String down_url,String targetUrl){
        String newFileUrl = targetUrl;
        File file = new File(newFileUrl);
        //如果目标文件已经存在，则删除。产生覆盖旧文件的效果
        if(file.exists()) {
            file.delete();
        }
        try {
            // 构造URL
            URL url = new URL(down_url);
            // 打开连接
            URLConnection con = url.openConnection();
            //获得文件的长度
            int contentLength = con.getContentLength();
            System.out.println("长度 :"+contentLength);
            // 输入流
            InputStream is = con.getInputStream();
            // 1K的数据缓冲
            byte[] bs = new byte[1024];
            // 读取到的数据长度
            int len;
            // 输出的文件流
            OutputStream os = new FileOutputStream(newFileUrl);
            // 开始读取
            while ((len = is.read(bs)) != -1) {
                os.write(bs, 0, len);
            }
            // 完毕，关闭所有链接
            os.close();
            is.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}
