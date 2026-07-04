<?php
/**
 * Created by PhpStorm.
 * User: xuexiaofeng
 * Date: 2015-6-8 0008
 * Time: 15:40
 */
namespace Admin\Controller;
class ManagerController extends AdminBasicController {

    public function login(){
        if(IS_POST){
            if(empty($_POST['account'])){
                $this->error('请输入账号！！');
            }if(empty($_POST['password'])){
                $this->error('验证码错误！！');
            }if(empty($_POST['verify'])){
                $this->error('请输入验证码！！');
            }else{
                $status = M('Admin')->where(array('account'=>I('post.account'),'password'=>md5(I('post.password'))))->getField('status');
                if($status == 4){
                    $this->error('该账号已停用！');
                }
                if($this->check_verify($_POST['verify'])){
                    $login_res = D('Admin')->login(I('post.account'),I('post.password'));
                    if($login_res){
                        $this->success('登陆成功！',U('Index/index'));
                    }else{
                        $this->error('用户名或密码错误！！');
                    }

                }else{
                    $this->error('验证码错误！！');
                }
            }
        }else{
            $aid = session('A_ID');
            if(empty($aid)){
                $this->display('login');
            }else{
                $this->redirect(U('Index/index'));
            }
        }
    }

    /**
     * 退出登录
     */
    public function logOut(){
        session('A_ACCOUNT',null);
        session('A_ID',null);
        session('A_GROUP',null);
        $this->redirect('login');
    }

    /**
     * 生成验证码
     */
    public function verify(){
        $verify = new \Think\Verify(array('length'=>4));
        $verify->entry();
    }

    /**验证码检验
     * $code
     */
    public function check_verify($code,$id=''){
        $verify = new \Think\Verify();
        return $verify->check($code,$id);
    }
}