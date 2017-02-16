package cn.core.test.demo.controller;

/**
 * Created by Administrator on 2017/1/19.
 */
public class IndexController extends BaseController {


    @Override
    public int layout_id() {
        return 0;
    }

    @Override
    public void onCreate() {
        SecondController c = new SecondController();
        this.startView(c);
    }
}
