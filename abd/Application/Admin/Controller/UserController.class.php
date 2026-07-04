<?php
namespace Admin\Controller;
use Think\Controller;
set_time_limit(0);

class UserController extends AdminBasicController {

    public $User = '';
    public function _initialize(){
        // $this->checkLogin();
        $this->User = D('User');
        $this->Asset = D('Asset');
    }

    public function addUser(){
        $this->checkAuth('User','addUser');
        if(IS_POST){
            $title = I('title');
            $content = I('content');
            $categoryid = I('categoryid');
            $img_arr = I('cover_id');
            $data['title'] = $title;
            $data['content'] = $content;
            $data['categoryid'] = $categoryid;
            $data['img_arr'] = $img_arr;
            $data['ctime'] = time();
            $result = M('user')->add($data);
            if($result){
                $this->ajaxReturn(array('code'=>1));
            }else{
                $this->ajaxReturn(array('code'=>2));
            }
        }else{
            $this->display('addUser');
        }
    }
    /**
     * 案例
     */
    public function zList(){
        $pageNum = 10;
        $this->checkAuth('User','list');
        $title = I('title');
        if(!empty($title)){
            $where['title']=array('like','%'.$title.'%');
            $this->assign('v8',$title);
        }
        $user_count = $this->User->count();
        $user_list = $this->User->selectUser($where,'id DESC',$pageNum);
        if($user_list['list']){
            $this->assign('page',$user_list['page']);
            $this->assign('user_list',$user_list['list']);
        }
        $this->assign('user_count',$user_count);
        $this->display('zList');
    }

    /**
     * 修改
     */
    public function editZUser(){
        $this->checkAuth('User','editUser');
        if(IS_POST){
            $title = I('title');
            $content = I('content');
            $categoryid = I('categoryid');
            $img_arr = I('cover_id');
            $where['id'] = I('id');
            $data['title'] = $title;
            $data['content'] = $content;
            $data['categoryid'] = $categoryid;
            $data['img_arr'] = $img_arr;
            $data['ctime'] = time();
            $result = $this->User->editUser($where,$data);

            if($result){
                $this->ajaxReturn(array('code'=>1));
            }else{
                $this->ajaxReturn(array('code'=>2));
            }
        }else{
            $id = I('request.id');
            $userinfo = $this->User->where(array('id'=>$id))->find();
            $this->assign('user',$userinfo);
            $img_arr = explode(',',$userinfo['img_arr']);
            $this->assign('img_arr',$img_arr);
            $this->display("editZUser");
        }
    }

    public function info(){
        $id = I('request.id');
        $userinfo = $this->User->where(array('id'=>$id))->find();
        if($userinfo){
            $this->ajaxReturn(array('code'=>200,'msg'=>'成功','data'=>$userinfo));
        }else{
            $this->ajaxReturn(array('code'=>1001,'msg'=>'失败'));
        }
    }

    /**
     * 删除
     */
    public function deleteUser(){
        $this->checkAuth('User','deleteUser');
        if(empty($_REQUEST['id'])){
            $this->error('您未选择任何操作对象');
        }
        $where['id'] = array('IN',I('request.id'));
        $res = $this->User->deleteUser($where);
        if($res){
            $this->success('删除操作成功');
        }else{
            $this->error('删除操作失败');
        }
    }


    //保存图片
    public function save_cover(){
        //获得文件/格式
        //$file = $_FILES["jUploaderFile"]["tmp_name"];
        $file = I('jUploaderFile');
        $upload = new \Think\Upload();
        $max_size = I('get.size', 1024*1024*8, 'int');
        $upload->maxSize  = $max_size ;// 设置附件上传大小
        $upload->exts  = array('jpg', 'gif', 'png', 'jpeg');// 设置附件上传类型
        //$upload->rootPath = './Uploads/';
        $upload->savePath = I('get.type') .'/';
        $upload->subName = array('date', 'Y-m');
        $result = $upload->uploadOne($_FILES["jUploaderFile"]);

        #上传到数据库
        if($result['name']) {
            $data = array(
                'name' => $result['name'],
                'size' => $result['size'],
                'format_type' => $result['type'],
                'file_path' => $result['savepath'],
                'file_name' => $result['savename'],
                'relateable_id'	=> I('get.id'),
                'relateable_type'	=> I('get.type'),
                'sort'	=>	0
            );

            $result = M('assets')->add($data);

            if ($result) {
                $info = array('state'=>true, 'info'=>'创建成功!', 'asset_id'=>$result, 'result'=>$result['result'],'savepath'=>$data['file_path'].$data['file_name']);
            }else {
                $info = array('state'=>false, 'info'=>'写入数据库错误!');
                unlink(absolute_upload_path($result['savepath'] . $result['savename']));
            }
        }else{
            $info = array('state'=>false, 'info'=>$result['info']);
        }


        $this->ajaxReturn(json_encode($info), 'eval');
    }


    /**
     * 列表
     */
    public function sList(){
        $pageNum = 10;
        $this->checkAuth('User','list');
        $v8 = I('v8');
        $v11 = 1;
        if(!empty($v8)){
            $where['v8']=array('like','%'.$v8.'%');
            $this->assign('v8',$v8);
        }
        $where['v11']=$v11;
        $user_count = $this->User->count();
        $user_list = $this->User->selectUser($where,'id DESC',$pageNum,$parameter);
        if($user_list['list']){
            $this->assign('page',$user_list['page']);
            $this->assign('user_list',$user_list['list']);
        }
        $this->assign('user_count',$user_count);
        $this->display('sList');
    }

    /**
     * 修改联系我们申请
     */
    public function editSUser(){
        $this->checkAuth('User','editUser');
        if(IS_POST){
            $oldStatus = $this->User->where(array('id'=>I('id')))->getField('v12');
            $newStatus = I('v12');
            $emails = I('v8');
            $where['id'] = I('id');
            $data['v8'] = $emails;
            $data['v10'] = I('v10');
            $data['v12'] = $newStatus;
            $data['v13'] = I('v13');
            $result = $this->User->editUser($where,$data);
            if($oldStatus ==1){
                // 发送回复邮件
                $title = '社区申请审核通知';
                if($newStatus == 2){
                    $content = I('v13');
                }
                if($newStatus == 3){
                    $content = '社区申请审核拒绝';
                }
                sendMail($emails,$title,$content);
            }
            if($result){
                $this->ajaxReturn(array('code'=>1));
            }else{
                $this->ajaxReturn(array('code'=>2));
            }
        }else{
            $id = I('request.id');
            $userinfo = $this->User->where(array('id'=>$id))->select();
            $this->assign('user',$userinfo[0]);
            $this->display("editSUser");
        }
    }


    /**
     * 前台查询会员信息
     */
    public function insertUser(){
        if(IS_POST){
            $username = I('username');
            $userinfo = $this->User->where(array('username'=>$username))->select();
            if(empty($userinfo)){
                $this->ajaxReturn(array('status'=>0));
            }else{
                $Order=M('Order');
                $order = $Order->where(array('dengji'=>$userinfo[0]['userrank']))->select();
                $rankMoney = 0;
                if(!empty($order)){
                    $rankMoney = $order[0]['rankmoney'];
                }
                $this->ajaxReturn(array('userrank'=>$userinfo[0]['userrank'],'rankmoney'=>$rankMoney,'money'=>$userinfo[0]['money'],'addtotalmoney'=>$userinfo[0]['addtotalmoney'],'chanext'=>$userinfo[0]['chanext']));
            }
        }
    }
    //导入操作
    public function impUser(){
        if(IS_POST){
            //设置编码防止乱码
            header("Content-Type:text/html;charset=utf-8");
            $upload = new \Think\Upload();// 实例化上传类
            $upload->maxSize   =     3145728 ;// 设置附件上传大小
            $upload->exts      =     array('xls','xlsx','csv');// 设置附件上传类
            $upload->rootPath  =     'Uploads/';
            $upload->savePath  =     ''; // 设置附件上传目录
            // 上传文件
            $info   =   $upload->uploadOne($_FILES['file']);
            $filename = 'Uploads/'.$info['savepath'].$info['savename'];
            $exts = $info['ext'];
            // var_dump($info);
            if(!$info) {// 上传错误提示错误信息
                $this->error($upload->geterror());
            }else{// 上传成功
                $this->data_import($filename, $exts);
            }
        }
    }
    public function data_import($filename, $exts='xls')
    {
        //导入PHPExcel类库，因为PHPExcel没有用命名空间，只能inport导入
        vendor("PHPExcel.PHPExcel");
        //创建PHPExcel对象，注意，不能少了\
        $PHPExcel=new \PHPExcel();
        //如果excel文件后缀名为.xls，导入这个类
        if($exts == 'xls'){
            import("Org.Util.PHPExcel.Reader.Excel5");
            $PHPReader=new \PHPExcel_Reader_Excel5();
        }else if($exts == 'xlsx'){
            import("Org.Util.PHPExcel.Reader.Excel2007");
            $PHPReader=new \PHPExcel_Reader_Excel2007();
        }else if($exts == 'csv'){
            import("Org.Util.PHPExcel.Reader.CSV");
            $PHPReader=new \PHPExcel_Reader_CSV();
        }

        //载入文件
        $PHPExcel=$PHPReader->load($filename);
        //获取表中的第一个工作表，如果要获取第二个，把0改为1，依次类推
        $currentSheet=$PHPExcel->getSheet(0);
        //获取总列数
        $allColumn=$currentSheet->getHighestColumn();
        //获取总行数
        $allRow=$currentSheet->getHighestRow();
        //循环获取表中的数据，$currentRow表示当前行，从哪行开始读取数据，索引值从0开始
        for($currentRow=3;$currentRow<=$allRow;$currentRow++){
            $address="D".$currentRow;
            $cell=$currentSheet->getCell($address)->getValue();
            $data[$currentRow]["A"] = (string)$cell;

            $address2="G".$currentRow;
            $cell2=$currentSheet->getCell($address2)->getValue();
            $data[$currentRow]["B"] = (string)$cell2;
        }
        $this->save_import($data);
    }
    //保存导入数据
    public function save_import($data)
    {
        $Order=M('Order');
        $order_list=$Order->select();
        foreach ($data as $k=>$v){
            $info['username'] = $v['A'];
            $info['money'] = $v['B'];
            $info['ctime'] = time();
            if(empty($info['username']) || empty($info['money']) || $info['money'] == '0' || $info['money'] == 0){
                continue;
            }

            $datawhere['username'] = $info['username'];
            $userinfo = M('User')->where($datawhere)->select();

            if(empty($userinfo)){
                $money = floatval($info['money']);
                $flag = 1;
                $min_money = 6000000000;
                foreach ($order_list as $k1=>$v1){
                    $min = floatval($order_list[$k1]['minmoney']);
                    $max = floatval($order_list[$k1]['maxmoney']);
                    if($money >= $min && $money < $max){
                        $info['userrank'] = $order_list[$k1]['dengji'];
                        $info['addmoney'] = $order_list[$k1]['addmoney'];
                        $info['rankmoney'] = $order_list[$k1]['rankmoney'];
                        $info['addtotalmoney'] = $order_list[$k1]['addmoney'];
                        $info['chanext'] = $max - $money;
                        $info['rankis'] = 1;
                        $info['rmoney'] = $order_list[$k1]['rankmoney'];
                        $flag = 2;
                        break;
                    }
                    if($min_money > $min){
                        $min_money = $min;
                    }
                }
                if($flag == 1){
                    $info['userrank'] = "0";
                    $info['addmoney'] = "0";
                    $info['addtotalmoney'] = "0";
                    $info['rankmoney'] = "0";
                    $info['rankis'] = 2;
                    $info['rmoney'] = "0";
                    $info['chanext'] = $min_money - $money;
                }
                $res = M('User')->add($info);
            }else{
                $where['id'] = $userinfo[0]['id'];
                $money = floatval($info['money']) + floatval($userinfo[0]['money']);
                $flag = 1;
                $min_money = 6000000000;
                foreach ($order_list as $k1=>$v1){
                    $min = floatval($order_list[$k1]['minmoney']);
                    $max = floatval($order_list[$k1]['maxmoney']);
                    if($money >= $min && $money < $max){
                        $info['userrank'] = $order_list[$k1]['dengji'];
                        $info['addmoney'] = $order_list[$k1]['addmoney'];
                        $info['addtotalmoney'] = $order_list[$k1]['addmoney'] + floatval($userinfo[0]['addtotalmoney']);

                        if($userinfo[0]['userrank'] == $order_list[$k1]['dengji']){
                            $info['rankmoney'] = floatval($userinfo[0]['rankmoney']);
                            $info['rankis'] = 2;
                            $info['rmoney'] = $order_list[$k1]['rankmoney'];
                        }else{
                            $info['rankmoney'] = floatval($userinfo[0]['rankmoney']) + floatval($order_list[$k1]['rankmoney']);
                            $info['rankis'] = 1;
                            $info['rmoney'] = $order_list[$k1]['rankmoney'];
                        }
                        $info['chanext'] = $max - $money;
                        $info['money'] = $money;
                        $flag = 2;
                        break;
                    }
                    if($min_money > $min){
                        $min_money = $min;
                    }
                }
                if($flag == 1){
                    $info['userrank'] = "0";
                    $info['addmoney'] = "0";
                    $info['addtotalmoney'] = "0";
                    $info['rankmoney'] = "0";
                    $info['rankis'] = 2;
                    $info['rmoney'] = "0";
                    $info['chanext'] = $min_money - $money;
                    $info['money'] = $money;
                }
                $result = $this->User->editUser($where,$info);
            }
        }
        $this->success('数据导入成功');
    }
    /**
     * 导出会员列表
     */
    public function expList(){
        $xlsName  = "用户数据表";
        $xlsCell  = array(
            array('username','会员账号'),
            array('userrank','等级'),
            array('money','有效投注'),
            array('addmoney','赠送金额'),
            array('ctime','是否已派金'),
            array('rankis','是否本次晋级'),
        );
        $xlsData  = $this->User->Field('username,userrank,money,addmoney,ctime,rankis')->order('money asc')->select();
        $nowdata = date("Y-m").'-01 00:00:00';
        $nowsjc = strtotime($nowdata);
        foreach ($xlsData as $k=>$v){
            $usersjc = $xlsData[$k]['ctime'];
            if($nowsjc-$usersjc<0){
                $xlsData[$k]['ctime'] = '已派金';
            }else{
                $xlsData[$k]['ctime'] = '未派金';
            }
            $userrankis = $xlsData[$k]['rankis'];
            if($userrankis == "1"){
                $xlsData[$k]['rankis'] = '是';
            }else{
                $xlsData[$k]['rankis'] = '否';
            }
        }
        $this->exportExcel($xlsName,$xlsCell,$xlsData);
    }
    //导出操作
    public function exportExcel($expTitle,$expCellName,$expTableData){
        $xlsTitle = iconv('utf-8', 'gb2312', $expTitle);//文件名称
        $fileName = $expTitle.date('_YmdHis');//or $xlsTitle 文件名称可根据自己情况设定
        $cellNum = count($expCellName);
        $dataNum = count($expTableData);
        vendor("PHPExcel.PHPExcel");
        $objPHPExcel = new \PHPExcel();
        $cellName = array('A','B','C','D','E','F','G','H','I','J','K','L','M','N');
        for($i=0;$i<$cellNum;$i++){
            $objPHPExcel->setActiveSheetIndex(0)->setCellValue($cellName[$i].'1', $expCellName[$i][1]);
        }
        // Miscellaneous glyphs, UTF-8
        for($i=0;$i<$dataNum;$i++){
            for($j=0;$j<$cellNum;$j++){
                $objPHPExcel->getActiveSheet(0)->setCellValue($cellName[$j].($i+2), $expTableData[$i][$expCellName[$j][0]]);
            }
        }
        header('pragma:public');
        header('Content-type:application/vnd.ms-excel;charset=utf-8;name="'.$xlsTitle.'.xlsx"');
        header("Content-Disposition:attachment;filename=$fileName.xls");//attachment新窗口打印inline本窗口打印
        $objWriter = \PHPExcel_IOFactory::createWriter($objPHPExcel, 'Excel5');
        $objWriter->save('php://output');
        exit;
    }

}
