<?php
namespace Home\Controller;
use Think\Controller;
class WorkController extends Controller {
    public $Category = '';
    public function _initialize(){
        $this->Category = D('Category');
        $this->User = D('User');
    }

    /**
     * 获取列表
     */
    public function index(){
        $id = I('request.id');
        if(empty($id)){
            $list = $this->User->where(array('categoryid'=>1))->select();
        }else{
            $list = $this->User->where(array('categoryid'=>$id))->select();
        }
        $order_list = $this->Category->select();
        $this->assign('list',$list);
        $this->assign('order_list',$order_list);
        $this->display('index');

    }
    /**
     * 获取详情
     */
    public function info(){
        $id = I('request.id');
        $order_list = $this->Category->select();
        $arr = array();
        foreach ($order_list as $item=>$value){
            $arr['arr'][$item]['menu']= $value;
        }
        if(empty($id)){
            $arr['list'] = $this->User->where(array('categoryid'=>1))->select();
        }else{
            $arr['list'] = $this->User->where(array('categoryid'=>$id))->select();
        }

        exit(json_encode(['code' => 200, 'msg' => '请求成功', 'data' => $arr]));
    }

    public function view(){
        $id = I('request.id');
        $info = $this->User->where(array('id'=>$id))->find();
        $this->assign('info',$info);
        $this->display("info");
    }
}
