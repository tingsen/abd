
/**
 * 显示提示框
 */
function showNotification(type,txt){
    if(type == 'error'){
        $('.n-'+type).find('div').html(txt);
        $('.n-'+type).slideDown(400);
    }else{
        $('.'+type).find('div').html(txt);
        $('.'+type).slideDown(400);
    }
    setTimeout(function(){
        $('.notification').slideUp(400);
    },2500);
}

//判断分类 是否允许操作
function ajaxJudge(redirect,cate_id,self_id,obj){
    $.ajax({
        url: redirect,type: 'post',data: {cate_id:cate_id,self_id:self_id},dataType: 'JSON',
        success: function (data) {
            if(data.error != null){
                showNotification('error',data.error);
                $(obj).find('option:first').attr('selected', 'selected').parent('select');
            }
        }
    });
}

//是否显示操作
function  ajaxIsShow(redirect,id,flag,obj){
    $.ajax({
        url: redirect,type: 'post',data: {id:id,flag:flag},dataType: 'JSON',
        success: function (data) {
            if(data.error != null){
                showNotification('error',data.error);
            }else{
                $(obj).parent().find('.is-show-operate').show();
                $(obj).hide();
            }
        }
    });
}

//修改排序
function ajaxEditSort(redirect,id,sort){
    $.ajax({
        url: redirect,type: 'post',data: {id:id,sort:sort},dataType: 'JSON',
        success: function (data) {
            if(data.error != null){
                showNotification('error',data.error);
            }else{
                showNotification('success',data.success);
            }
        }
    });
}
