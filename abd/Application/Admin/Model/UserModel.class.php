<?php
namespace Common\Model;
use Think\Model;

/**
 * Class UserModel
 * @package Common\Model
 * 会员信息相关
 */
class UserModel extends Model {
    protected $tableName = 'user';

    /**
     * 查询多条数据
     */
    public function selectUser($where = array(),$order = '',$page_size = '',$parameter = array()){
        if($page_size == ''){
            $result = $this->where($where)->select();
        }else{
            $count = $this->where($where)->count();
            $page = new \Think\Page($count,$page_size);
            $page->parameter = $parameter;
            $page->setConfig('theme',$this->setPageTheme());
            $page_info =$page->show();
            $list = $this->where($where)
                ->limit($page->firstRow,$page_size)
				->order($order)
                ->select();
            $result = array('page'=>$page_info,'list'=>$list);
        }
        return $result;
    }
    /**
     * 添加会员
     */
    public function addUser($data){
        if(empty($data)){
            return false;
        }
        $result = $this->data($data)->add();
        return $result;
    }
    
    /**
     * 查询一条数据
     */
    public function findUser($where){
        $result = $this->where($where)->find();
        return $result;
    }
    /**
     * 编辑会员
     */
    public function editUser($where,$data){
        if(empty($where) || empty($data)){
            return false;
        }
        $result = $this->where($where)->data($data)->save();
        return $result;
    }
    /**
     * 删除会员
     */
    public function deleteUser($where){
        if(empty($where)){
            return false;
        }
        $result = $this->where($where)->delete();
        return $result;
    }

    /**
     * 分页样式
     */
    private function setPageTheme(){
        // $theme = "<ul class='pagination'><li>%TOTAL_ROW%</li><li><a href='/index.php?s=/Admin/User/userList/p/1'>首页</a></li><li>%UP_PAGE%</li>%LINK_PAGE%<li>%DOWN_PAGE%</li><li><a href='/index.php?s=/Admin/User/userList/p/1'>尾页</a></li></ul>";
        $theme = "<ul class='pagination'><li>%TOTAL_ROW%</li><li>%SHOUYE%</li><li>%UP_PAGE%</li>%LINK_PAGE%<li>%DOWN_PAGE%</li><li>%WEIYE%</li></ul>";
        return $theme;
    }
}
