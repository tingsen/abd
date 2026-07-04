<?php
namespace Home\Controller;
use Think\Controller;
set_time_limit(0);

class UserController extends Controller {

    public $User = '';
    public function _initialize(){
        $this->User = D('User');
    }
    /**
     * 社区申请
     */
    public function applyS(){
		$slist = $this->User->where(array('v11'=>1,'v12'=>2))
                ->limit(30)
				->order('v10 DESC')
                ->select();
        $this->assign('slist',$slist);
        $this->display('joinS');
    }
    /**
     * 债券发行申请
     */
    public function applyZ(){
		$zlist = $this->User->where(array('v11'=>2,'v12'=>2))
                ->limit(30)
				->order('v10 DESC')
                ->select();
        $this->assign('zlist',$zlist);
        $this->display('joinZ');
    }
    /**
     * 申请规则
     */
    public function applyR(){
        $this->display('joinR');
    }
	
	public function dianzan(){
		if(IS_POST){
			$id = I('id');
			$this->User->where(array('id'=>$id))->setInc('v10',1);
			$this->ajaxReturn(array('code'=>1));
		}
	}
	
	public function applyJoinUs(){
		$v1 = I('v1');
		$v2 = I('v2');
		$v3 = I('v3');
		$v4 = I('v4');
		$v5 = I('v5');
		$v6 = I('v6');
		$v7 = I('v7');
		$v8 = I('v8');
		$v11 = I('v11');
		
		$data['v1'] = $v1;
		$data['v2'] = $v2;
		$data['v3'] = $v3;
		$data['v4'] = $v4;
		$data['v5'] = $v5;
		$data['v6'] = $v6;
		$data['v7'] = $v7;
		$data['v8'] = $v8;
		$data['v11'] = $v11;
		$data['v9'] = time();
		$data['v10'] = 0;
		$data['v12'] = 1;
		$data['v13'] = '';
		
		$result = M('User')->add($data);
		if($result){
			$this->ajaxReturn(array('code'=>1));
		}else{
			$this->ajaxReturn(array('code'=>2));
		}
	}
}