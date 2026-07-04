<?php
namespace Admin\Controller;

class IndexController extends AdminBasicController {

    public function _initialize(){
        $this->checkLogin();
    }

    public function index(){
        $this->display('index');
    }

    public function left(){
        $this->display('left');
    }

    public function top(){
        $admin = session('A_ACCOUNT');
        $this->assign('admin',$admin);
        $this->display('top');
    }

    public function main(){
                $this->display('main');
    }

    public function news(){

    }


}
