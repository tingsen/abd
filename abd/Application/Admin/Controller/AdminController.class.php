<?php

namespace Admin\Controller;
use Think\Controller;

/**
 * Class AdminController
 * @package Admin\Controller
 * 2014-8-18  add by <黑暗中的武者>
 */
class AdminController extends AdminBasicController {

    public $admin_obj = '';
    public $group_obj = '';
    public function _initialize(){
        $this->checkLogin();
        $this->admin_obj = D('Admin');
        $this->group_obj = D('AdminGroup');
    }
    /**
     * 管理员列表
     * 2014-8-18  add by <黑暗中的武者>
     */
    public function adminList(){
        $this->checkAuth('Admin','setAdmin');
        //管理员列表
        $admin_list = $this->admin_obj->selectAdmin('','','');
        if($admin_list){
            foreach($admin_list as $key => $admin){
                //获取组名
                $admin_list[$key]['group_name'] = $this->group_obj->where(array('group_id'=>$admin['group_id']))->getField('group_name');
            }
            $this->assign('admin_list',$admin_list);
        }
        //编辑后返回
        $this->setEditBack(U('Admin/Admin/adminList',$_REQUEST));
        $this->display('adminList');
    }

    /**
     * 添加管理员
     * 2014-8-18  add by <黑暗中的武者>
     */
    public function addAdmin(){
        $this->checkAuth('Admin','addAdmin');
        if(empty($_POST)){
            //获取分组的数据
            $this->assign('group_list',$this->getAdminGroup());
            $this->display('addAdmin');
        }else{
            $data = $this->admin_obj->create();
            if($data){
                //$data['city'] = implode(',',$_POST['city']);
                $data['ctime'] = time();
                $add_res = $this->admin_obj->addAdmin($data);
                if($add_res){
                    $this->success('添加管理员成功',U('Admin/Admin/adminList'));
                }else{
                    $this->error('添加管理员失败');
                }
            }else{
                $this->error($this->admin_obj->getError());
            }
        }
    }

    /**
     * 修改管理员信息
     * 2014-8-18  add by <黑暗中的武者>
     */
    public function editAdmin(){
        $this->checkAuth('Admin','editAdmin');
        if(empty($_POST)){
            $where['a_id'] = I('get.a_id');
            $admin = $this->admin_obj->findAdmin($where);
            if($admin){
                $this->assign('group_list',$this->getAdminGroup());
                $this->assign('admin',$admin);
                $this->display('editAdmin');
            }else{
                $this->error('该管理员不存在或被删除');
            }
        }else{
            $where['a_id'] = I('post.a_id');
            if($_POST['re_password'] != $_POST['password']){
                $this->error('两次密码输入不一致！');
            }
            if(!empty($_POST['password'])){
                $data['password'] = md5(I('post.password'));
            }
            $data['status'] = I('post.status');
            $data['group_id'] = I('post.group_id');
            $data['utime'] = time();
            $upd_res = $this->admin_obj->editAdmin($where,$data);
            if($upd_res){
                $this->success('编辑管理员成功',cookie("EDIT_BACK"));
            }else{
                $this->error('编辑管理员失败');
            }
        }
    }

    /**
     * 删除管理员
     * 2014-8-18  add by <黑暗中的武者>
     */
    public function deleteAdmin(){
        $this->checkAuth('Admin','deleteAdmin');
        if(I('get.a_id') == 1){
            $this->error('该账号不能删除');exit;
        }else{
            $where['a_id'] = I('get.a_id');
            $upd_res = $this->admin_obj->where($where)->delete();
            if($upd_res){
                $this->success('删除成功');
            }else{
                $this->error('本次删除失败');
            }
        }
    }


    /**
     * 是否启用
     */
    public function isShowOperate(){
        $this->checkAuth('Admin','addAdmin');
        //修改条件 ID
        $where['a_id'] = I('post.id');
        //判断修改为显示或者不显示
        if(I('post.flag') == 0){
            $data['status'] = 0;
        }elseif(I('post.flag') == 1){
            $data['status'] = 4;
        }
        $data['utime'] = time();
        //修改操作
        $upd_res = $this->admin_obj->editAdmin($where,$data);
        if($upd_res){
            $this->ajaxMsg('success','编辑成功');
        }else{
            $this->ajaxMsg('error','编辑失败');
        }
    }


    /**
     * 获取分组数据
     * 2014-8-18  add by <黑暗中的武者>
     */
    public function getAdminGroup(){
        $group_list = $this->group_obj->selectAdminGroup();
        return $group_list;
    }

    /**
     * 修改密码
     * 2014-8-18  add by <黑暗中的武者>
     */
    public function editPass(){
        $this->checkAuth('Admin','setAdmin');
        if(empty($_POST)){
            $this->display('editPass');
        }else{
            if($_POST['re_password'] != $_POST['password']){
                $this->error('两次密码输入不一致！');
            }
            $data = $this->admin_obj->create();
            if($data){
                $where['a_id'] = session('A_ID');
                $data['password'] = md5($_POST['password']);
                $data['utime'] = time();
                $upd_res = $this->admin_obj->editAdmin($where,$data);
                if($upd_res){
                    $this->success('修改密码成功',U('Admin/adminList'));
                }else{
                    $this->error('修改密码失败');
                }
            }else{
                $this->error($this->admin_obj->getError());
            }
        }
    }
}