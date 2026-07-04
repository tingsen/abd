<?php
namespace Admin\Controller;
use Think\Controller;
/**
 * Class ConfigController
 * @package Admin\Controller
 */
class ConfigController extends AdminBasicController{

    public $config_obj = '';
    public function _initialize(){
        $this->checkLogin();
        $this->config_obj = D('Config');
    }

    /**
     * 网站配置
     */
    public function config(){
        $this->checkAuth('Config','setConfig');
        if(empty($_POST)){
            $config = $this->config_obj->findConfig();
            $this->assign('config',$config);
            $this->display('config');
        }else{
            $this->checkAuth('Config','config');
            $data = $this->config_obj->create();
            if($data){
                if(!empty($_FILES['wap_site_logo']['name']) && empty($_FILES['site_logo']['name'])) {
                    $res = uploadFile('', 'Config');
                    $data['wap_site_logo'] = $res['success'];
                }if(empty($_FILES['wap_site_logo']['name']) && !empty($_FILES['site_logo']['name'])) {
                    $res = uploadFile('', 'Config');
                    $data['site_logo'] = $res['success'];
                }if(!empty($_FILES['wap_site_logo']['name']) && !empty($_FILES['site_logo']['name'])) {
                    $res = uploadFile('', 'Config');
                    $logo = explode(',',$res['success']);
                    if(empty($res['error'])){
                        $data['wap_site_logo'] = $logo[1];
                        $data['site_logo'] = $logo[0];
                    }else{
                        $this->error($res['error']);
                    }
                }
                $res = $this->config_obj->editConfig($data);
                if($res){
                    $this->success('保存成功！');
                }else{
                    $this->error('您未修改任何值！');
                }
            }else{
                $this->error($this->config_obj->getError());
            }
        }
    }

    /**
     * 第三方信息
     */
    public function loginOther(){
        $this->checkAuth('Config','setConfig');
        if(empty($_POST)){
            $config = $this->config_obj->findConfig();
            $this->assign('config',$config);
            $this->display('loginOther');
        }else{
            $this->checkAuth('Config','config');
            $data = $this->config_obj->create();
            if($data){
                $res = $this->config_obj->editConfig($data);
                if($res){
                    $this->success('保存成功！');
                }else{
                    $this->error('您未修改任何值！');
                }
            }else{
                $this->error($this->config_obj->getError());
            }
        }
    }

    /**
     * 短信服务
     */
    public function sms(){
        $this->checkAuth('Config','setConfig');
        if(empty($_POST)){
            $config = $this->config_obj->findConfig();
            $this->assign('config',$config);
            $this->display('sms');
        }else{
            $this->checkAuth('Config','config');
            $data = $this->config_obj->create();
            if($data){
                $res = $this->config_obj->editConfig($data);
                if($res){
                    $this->success('保存成功！');
                }else{
                    $this->error('您未修改任何值！');
                }
            }else{
                $this->error($this->config_obj->getError());
            }
        }
    }

    //默认图片
    public function defaultimg(){
        if(IS_POST){
            $img_type = $_FILES['defaultimg'];
            if($img_type['type'] != 'image/png'){
                $this->error('图片格式错误，请上传png格式的。');
            }
            $img = '/home/wwwroot/www.ujiao.com/Uploads/default.png';
            if(file_exists($img)){
                mkdir($img,0777);
                if(unlink($img)){
                    if(!empty($_FILES['defaultimg']['name'])){
                        $this->upload();
                    };
                };
            }else{
                if(!empty($_FILES['defaultimg']['name'])){
                    $this->upload();
                };
            }
        }else{
            $this->assign('defaultimg','default.png');
            $this->display('defaultimg');
        }
    }

    /**
     * 上传操作
     * @return array|bool
     */
    private function upload(){
        if(!empty($_FILES)){
            $config = array(
                'maxSize'    =>    3145728,
                'rootPath'   =>    'Uploads',
                'savePath'   =>    '/',
                'saveName'   =>    'default',
                'exts'       =>    array('png'),
                'autoSub'    =>    true,
                'subName'    =>    '',
            );
            $upload = new \Think\Upload($config);
            $file = $upload->upload();
            if(!$file){
                $this->error($upload->getError());
            }else{
                $this->success('上传成功');
            }
        }
    }

}