package com.core.lua.dialog;

import android.app.AlertDialog;
import android.content.DialogInterface;

import com.core.lua.local.utils.ActivityManager;

import cn.vimfung.luascriptcore.modules.oo.LuaObjectClass;

/**
 * Created by JD on 2017/2/10.
 */
public class LuaDialog extends LuaObjectClass {
    public static void show(String mesaage){
        AlertDialog.Builder builder = new AlertDialog.Builder(ActivityManager.getActivity());
        builder.setMessage(mesaage);
        builder.setTitle("提示");
        builder.setPositiveButton("确认", new DialogInterface.OnClickListener() {
            @Override
            public void onClick(DialogInterface dialog, int which) {
                dialog.dismiss();
            }
        });
        builder.create().show();
    }
}
