<?php
namespace Common\Model;
use Think\Model;

/**

 * Class UserModel

 * @package Common\Model

 * 会员信息相关

 */

class CategoryModel extends Model {
    protected $tableName = 'category';

    /**

     * 查询多条数据

     */
    public function selectCategory($where = array(),$order = '',$page_size = '',$parameter = array()){
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

     * 添加账单

     */
    public function addCategory($data){
        if(empty($data)){
            return false;
        }
        $result = $this->data($data)->add();
        return $result;
    }



    /**

     * 查询一条数据

     */
    public function findCategory($where){
        $result = $this->where($where)->find();
        return $result;
    }

    /**

     * 编辑账单

     */
    public function editCategory($where,$data){
        if(empty($where) || empty($data)){
            return false;
        }
        $result = $this->where($where)->data($data)->save();
        return $result;
    }

    /**

     * 删除账单

     */
    public function deleteCategory($where){
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
        $theme = "<ul class='pagination'><li>%TOTAL_ROW%</li><li>%UP_PAGE%</li>%LINK_PAGE%<li>%DOWN_PAGE%</li></ul>";
        return $theme;
    }
}
