<?php

namespace Admin\Controller;
use Think\Controller;

/**
 * Class AdminBasicController
 * @package Admin\Controller
 * 父类  添加登陆验证  权限等
 */
class AdminBasicController extends Controller {

    /**
     * 初始化
     */
    public function _initialize(){}

    /**
     * 判断登陆
     */
    public function checkLogin(){
        session('[regenerate]');   //重新生成sessionID
        $session = session('A_ID');
        if(empty($session)){
            redirect(U('Manager/login'));exit;
        }
    }

    /**
     * 检查权限
     * @param string $model
     * @param string $method
     * @param bool $ajax
     */
    function checkAuth($model = '', $method = '', $ajax = false){
        //参数为空时 无权限
        if(empty($model) || empty($method)){
            if(!$ajax){
                $this->error('没有权限');exit;
            }else{
                $this->ajaxMsg('error','没有权限');
            }
        }else{
            //对管理员的操作 只有超级管理员能够进行
            $method_arr = array('addAdmin','editAdmin','deleteAdmin','editGroup','addGroup','deleteGroup');
            if(session('A_ID') != 1 && in_array($method,$method_arr)){
                if(!$ajax){
                    $this->error('没有权限');exit;
                }else{
                    $this->ajaxMsg('error','没有权限');
                }
            }
            if(session('A_ID') != 1){
                $action = D('AdminAction');
                $action_id = $action->where(array('model'=>$model,'method'=>$method))->getField('action_id');
                if(!empty($action_id)){
                    $admin = D('Admin');
                    //获取当前管理员组ID
                    $group_id = $admin->where(array('a_id'=>session('A_ID')))->getField('group_id');
                    //获取该组的权限
                    $group = D('AdminGroup');
                    $permission = $group->where(array('group_id'=>$group_id,'status'=>0))->getField('permission');
                    $permission = unserialize($permission);
                    //判断是否有权限
                    if(!in_array($action_id,$permission)){
                        if(!$ajax){
                            $this->error('没有权限');exit;
                        }else{
                            $this->ajaxMsg('error','没有权限');
                        }
                    }
                }
            }
        }
    }

    /**
     * 编辑后返回列表跳转路径设置
     */
    public function setEditBack($url){
        cookie("EDIT_BACK",$url,array('expire'=>36000));
    }

    /**
     * ajax返回数据
     * 2014-6-7
     */
    public function ajaxMsg($f,$m){
        $msg[$f] = $m;
        $this->ajaxReturn($msg,Json);
    }

    /**
     * 分页配置信息
     */
    public function getPageNumber(){
        $page_number = D('Config')->where(array('conf_id'=>1))->getField('page_number');
        return $page_number;
    }

}