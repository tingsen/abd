<?php
namespace Home\Controller;
use Think\Controller;
class OrderController extends Controller {
    public $Order = '';
    public function _initialize(){
        $this->Order = D('Order');
    }

	/**
     * 获取列表
     */
    public function newslist(){
        $order_count = $this->Order->count();
        $order_list = $this->Order->selectOrder($where,'ctime desc','10',$parameter);
        if($order_list['list']){
            $this->assign('page',$order_list['page']);
            $this->assign('order_list',$order_list['list']);
        }
        $this->assign('order_count',$order_count);
        $this->display('newslist');
    }
	/**
     * 获取详情
     */
    public function getNewsInfo(){
		$id = I('request.id');
		$userinfo = $this->Order->where(array('id'=>$id))->select();
		$this->assign('user',$userinfo[0]);
		$this->display("getNewsInfo");
    }
}
