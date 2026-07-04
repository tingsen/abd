<?php
namespace Admin\Controller;
use Think\Controller;
class OrderController extends AdminBasicController {
    public $Order = '';
    public function _initialize(){
        $this->checkLogin();
        $this->Order = D('Order');
    }
    /**
     * 新闻列表
     */
    public function orderList(){
        $this->checkAuth('Order','list');
        $order_count = $this->Order->count();
        $order_list = $this->Order->selectOrder($where,'ctime desc','10',$parameter);
        if($order_list['list']){
            $this->assign('page',$order_list['page']);
            $this->assign('order_list',$order_list['list']);
        }
        $this->assign('order_count',$order_count);
        $this->display('orderList');
    }
	
	/**
     * 新闻操作
     */
    public function addOrder(){
        $this->checkAuth('Order','addOrder');
        if(IS_POST){
            $title = I('title');
            $content = I('content');
            $is_url = I('is_url');
            $web_url = I('web_url'); 
			$data['title'] = $title;
            $data['content'] = $content;
            $data['is_url'] = $is_url;
            $data['web_url'] = $web_url;
			$data['ctime'] = time();
            $result = M('order')->add($data);
            if($result){
                $this->ajaxReturn(array('code'=>1));
            }else{
				$this->ajaxReturn(array('code'=>2));
            }
        }else{
            $this->display("addOrder");    
        }
    }
	/**
     * 新闻操作
     */
    public function editOrder(){
        $this->checkAuth('Order','editOrder');
        if(IS_POST){
			$where['id'] = I('id');
            $title = I('title');
            $content = I('content');
            $is_url = I('is_url');
            $web_url = I('web_url');
            $data['title'] = $title;
            $data['content'] = $content;
            $data['is_url'] = $is_url;
            $data['web_url'] = $web_url;
			$data['ctime'] = time();
            $result = $this->Order->editOrder($where,$data);
            if($result){
                $this->ajaxReturn(array('code'=>1));
            }else{
				$this->ajaxReturn(array('code'=>2));
            }
        }else{
			$id = I('request.id');
			$userinfo = $this->Order->where(array('id'=>$id))->select();
			$this->assign('user',$userinfo[0]);
            $this->display("editOrder");    
        }
    }
    /**
     * 删除新闻操作
     */
    public function deleteOrder(){
        $this->checkAuth('Order','deleteOrder');
        if(empty($_REQUEST['id'])){
            $this->error('您未选择任何操作对象');
        }
        $where['id'] = array('IN',I('request.id'));
        $res = $this->Order->deleteOrder($where);
        if($res){
            $this->success('删除操作成功');
        }else{
            $this->error('删除操作失败');
        }
    }
}