function setCookie(name,value){
    var Days = 30;
    var exp = new Date();
    exp.setTime(exp.getTime() + Days*24*60*60*1000);
    document.cookie = name + "="+ escape (value) + ";expires=" + exp.toGMTString();
}
function getCookie(name){
    var arr,reg=new RegExp("(^| )"+name+"=([^;]*)(;|$)");
    if(arr=document.cookie.match(reg))
    return unescape(arr[2]);
    else
    return null;
}
function delCookie(name){
    var exp = new Date();
    exp.setTime(exp.getTime() - 1);
    var cval=getCookie(name);
    if(cval!=null)
    document.cookie= name + "="+cval+";expires="+exp.toGMTString();
}
function IEVersion() {
    var userAgent = navigator.userAgent; //取得浏览器的userAgent字符串  
    var isIE = userAgent.indexOf("compatible") > -1 && userAgent.indexOf("MSIE") > -1; //判断是否IE<11浏览器  
    var isEdge = userAgent.indexOf("Edge") > -1 && !isIE; //判断是否IE的Edge浏览器  
    var isIE11 = userAgent.indexOf('Trident') > -1 && userAgent.indexOf("rv:11.0") > -1;
    if(isIE || isIE11) {
        // var reIE = new RegExp("MSIE (\\d+\\.\\d+);");
        //     reIE.test(userAgent);
        //     var fIEVersion = parseFloat(RegExp["$1"]);
        //     if(fIEVersion == 7) {
        //         return 7;
        //     } else if(fIEVersion == 8) {
        //         return 8;
        //     } else if(fIEVersion == 9) {
        //         return 9;
        //     } else if(fIEVersion == 10) {
        //         return 10;
        //     } else {
        //         return 6;//IE版本<=7
        //     }   
        // } else if(isEdge) {
        //     return 'edge';//edge
        // } else if(isIE11) {
        //     return 11; //IE11  
        return true;
    }else{
        return false;//不是ie浏览器
    }
}
var puBlic={
    dom: {},
    params:{
        isfirst:false,
        isMapTap:false,
        curWidth:null,
        language:'en',
        newsSwiper:null,
        curPageNum:1,
        partCurNum:1,
        pagesTotal:null,
        curTypeId:null,
        baseUrl:null,
        windowWidth:null,
        isIe:false,
        curNewsId:null
    },
    init: function() {
        this.initDom();
        this.bindEvent();
        this.initParams();
        this.load();
    },
    initDom: function() {
        var dom = this.dom;
        dom.works_todo = $('.works-todo')
        dom.works_section = $('.works-section')
        dom.contact_ul = $('.contact-ul')
        dom.contact_ul_li = $('.contact-ul li')
        dom.contact_msg_p = $('.contact-msg').children('p')
        dom.contact_map_name = $('.contact-map .map-name')
        dom.contact_map = $('.contact-map')
        dom.about_partner = $('#partnerList')
        dom.about_section_li = $('.section-ul li')
        dom.about_carees_ul = $('.carees-ul')
        dom.nav_li = $('.nav-list li')
        dom.language = $('.language')
        dom.worksIntro = $('#worksIntro')
        dom.works_img_section = $('.works-img-section')
        dom.works_list = $('.works-list')
        dom.award_cut = $('.award-cut')
        dom.partype = $('#parType')
        dom.lastNewsList = $('#lastNewsList')
        dom.workscroll = $('.works-scroll')
        dom.award_div_p = $('.award_div').find('p')
    },
    initParams:function () {
        var params = this.params;
        params.language = getCookie('language') || 'en';
        params.baseUrl = $('#base_url').val();
        params.windowWidth = $(window).width();
        params.isIe = IEVersion();
        params.curNewsId = $('#curNewsIds').val();
        
    },
    load: function() {
        setCookie('windowWidth',$(window).width())
    },
    bindEvent:function () {
        var dom = this.dom;
        var params = this.params
        var that = this

        //zn/en

        dom.language.on('click','a',function() {
            $(this).addClass('check').removeClass()
            setCookie('language',$(this).attr('lagua'))
            location.reload()
        })

        //nav li hover
        dom.nav_li.hover(
            function () {
                if(params.language=='cn'){
                    $(this).children('a').find('font').hide()
                }
                params.curWidth = $(this).children('a').attr('curWidth')
                $(this).children('a').stop().animate({'width':'100%'},500)
            },
            function () {
                var that = this;
                $(this).children('a').stop().animate({'width':params.curWidth},500,function () {
                    if(params.language=='cn'){
                        $(that).children('a').find('font').show()
                    }
                })
            }
        )
        $('body').on("mouseenter mouseleave",".award_div p",function(event){
         　　if(event.type == "mouseenter"){
            　　　　$(this).parent().parent().parent().parent().parent().siblings('.award_img_hide').show().siblings('.award_img_show').hide() 
         　　}else if(event.type == "mouseleave"){
            　　　　$(this).parent().parent().parent().parent().parent().siblings('.award_img_hide').hide().siblings('.award_img_show').show()
         　　};
         });

         $('body').on("mouseenter",".award_img_show",function(event){
            　　if(event.type == "mouseenter"){
               　　　　$(this).hide().siblings('.award_img_hide').show() 
            　　}
            });
            $('body').on("mouseleave",".award_img_hide",function(event){
                　　if(event.type == "mouseleave"){
                   　　　　$(this).hide().siblings('.award_img_show').show() 
                　　}
                });
 
        //work scroll
        var isMove = false;//mousedown标记
        dom.workscroll.on('mousedown','.scroll-active',function (event) {
            var event = event || window.event;
            sHeight = $(this).height();
            spHeight = $(this).parent().height();
            mY = event.pageY;
            dY = $(this).parent().offset().top;
            curTop = $(this).position().top
            var syHeight = mY - dY-curTop
            isMove = true;//鼠标拖拽启动
            var imgHeight = 0;
            $.each($('.works-img-section').children('img'),function (index,item) {
                imgHeight += $(item).height()
            })
            $(document).mousemove(function (e) {
                var deltaY = e.pageY-dY-syHeight
                var curScrollTop = imgHeight*deltaY/(spHeight-syHeight) 
                if (isMove) {
                    if (deltaY < 0) {
                        $('.scroll-active').css('top',0)
                    }else if(deltaY >= 145) {
                        $('.scroll-active').css('top','75%')
                    }else{
                        $('.scroll-active').css('top',deltaY+'px')
                    }
                    $('.works-img-section').scrollTop(curScrollTop)
                }
            }).mouseup(
                function () {
                $(document).off('mousemove');
                isMove = false;
            });
        })

        //work hover
        dom.worksIntro.on('mouseenter mouseleave',
            function(event) {
                if($(event.target).hasClass('works-img')) { 
                    if(event.type == 'mouseenter'){
                        if(params.isIe){
                            if(params.windowWidth <= 1440 && params.windowWidth > 1370) {
                                $('.works-img-section').addClass('works-ie-1440-active')
                            }
                            if(params.windowWidth<=1556 && params.windowWidth>=1500){
                                $('.works-img-section').addClass('works-ie-1536-active')
                            }
                            if(params.windowWidth >= 1920){
                                $('.works-img-section').addClass('works-ie-1920-active')
                            }
                        }else{
                            $('.works-img-section').addClass('works-img-section-active')
                        }
                        
                        $('body').addClass('html-body-overflow')
                        $('.works-scroll').hide(function () {
                            if(params.windowWidth > 1450 && params.windowWidth < 1680){
                                $('.works-scroll').css({
                                    'top':'35%',
                                    'left':'-2.5rem'
                                }).show(0)
                            }else if (params.windowWidth <= 1440 && params.windowWidth > 1380 ){
                                $('.works-scroll').css({
                                    'top':'35%',
                                    'left':'-2.5rem'
                                }).show(0)
                            }else if (params.windowWidth < 1370 ){
                                $('.works-scroll').css({
                                    'top':'35%',
                                    'left':'-2.5rem'
                                }).show(0)
                            }else{
                                $('.works-scroll').css({
                                    'top':'40%',
                                    'left':'-2.5rem'
                                }).show(0)
                            }
                            
                        })
                        
                        that.listenScrollToBottom($('#worksIntro').find('.works-img-section').get(0))
                    }else{
                        if(params.isIe){
                            if(params.windowWidth <= 1440 && params.windowWidth > 1370) {
                                $('.works-img-section').removeClass('works-ie-1440-active')
                            }
                            if(params.windowWidth<=1556 && params.windowWidth>=1500){
                                $('.works-img-section').removeClass('works-ie-1536-active')
                            }
                            if(params.windowWidth >= 1920){
                                $('.works-img-section').removeClass('works-ie-1920-active')
                            }
                        }else{
                            $('.works-img-section').removeClass('works-img-section-active')
                        }
                        
                        $('body').removeClass('html-body-overflow')
                        if (params.windowWidth <= 1440){
                            $('.works-scroll').hide(0,function () {
                                $('.works-scroll').css({
                                    'top':'60%',
                                    'left':'0'
                                }).show(0)
                                
                            })
                        }else{
                            $('.works-scroll').hide(0,function () {
                                $('.works-scroll').css({
                                    'top':'60%',
                                    'left':'0'
                                }).show(0)
                                
                            })
                        }
                        
                        
                    }
                }
                
                
            }
        
        )
        //work type
        dom.works_list.on('click','li',function () {
            // params.curPageNum = 1
            // params.curTypeId = $(this).attr('curId')
            // $(this).addClass('active').siblings().removeClass('active')
            // that.getWorkList(params.curTypeId,1)
        })


        //work todo ul
        dom.works_todo.on('click','li',function () {
            $(this).addClass('active').siblings().removeClass('active')
            that.getWorkCase($(this).attr('case'))
        })

        //contact js
        dom.contact_ul_li.on({
            'mouseenter' : function () {
                $(this).addClass('active').siblings().removeClass('active')
                dom.contact_msg_p.eq($(this).index()).addClass('animated fadeInDown').show().siblings().removeClass('animated fadeInDown').hide()
                if($(this).attr('point')){     
                    dom.contact_map_name.removeClass('active animated infinite heartBeat').children('.map-point').removeClass('animated infinite heartBeat map-address') 
                    dom.contact_map_name.eq($(this).attr('point')).addClass('active animated infinite heartBeat').children('.map-point').addClass('animated infinite heartBeat map-address')
                }
            }
        })
        //contact map point
        dom.contact_map_name.hover(
            function () {
                $(this).addClass('active').children('.map-point').addClass('animated infinite fadeInDown map-address')
            },
            function () {
                if(params.isMapTap){
                    $(this).children('.map-point').removeClass('animated infinite fadeInDown')
                }else{
                    $(this).removeClass('active').children('.map-point').removeClass('animated infinite fadeInDown map-address')
                }
            }
        )
        //contact ul click
        dom.contact_ul.on('click','li',function () {
            $(this).addClass('active').siblings().removeClass('active')
            dom.contact_msg_p.eq($(this).index()).addClass('animated fadeInDown').show().siblings().removeClass('animated fadeInDown').hide()
            dom.contact_map_name.removeClass('active animated infinite heartBeat').children('.map-point').removeClass('animated infinite heartBeat map-address')
            if($(this).attr('point')){      
                dom.contact_map_name.eq($(this).attr('point')).addClass('active animated infinite heartBeat').children('.map-point').addClass('animated infinite heartBeat map-address')
            }
        })
        $('.contact-ul li:first').click()
        //contact map click
        dom.contact_map.on('click','.map-name',function () {
            params.isMapTap = true
            dom.contact_map_name.removeClass('active animated infinite heartBeat').children('.map-point').removeClass('animated infinite heartBeat map-address')
            $(this).addClass('active animated infinite heartBeat').children('.map-point').addClass('animated infinite heartBeat map-address')
            if($(this).attr('point')){  
                dom.contact_ul_li.eq($(this).attr('point')).click()
            }
        })

         //about partner hover
         dom.about_partner.on('mouseenter mouseleave','li',
            function(event) {
                if(event.type == 'mouseenter'){
                    $(this).find('.curPartner').hide().siblings('.hdPartner').show()
                }else{
                    $(this).find('.curPartner').show().siblings('.hdPartner').hide()
                }
                
            }

        )
        //about carees
        dom.about_carees_ul.on('click','li h3',function () {
            if($(this).children('.unfold').hasClass('fold')){
                $(this).children('.unfold').removeClass('fold')
                $(this).siblings('.carees-msg').hide({duration: 400})
                $(this).removeClass()
                return false
            }
            $(this).addClass('active').parent().siblings().children('h3').removeClass()
            dom.about_carees_ul.find('.carees-msg').hide({duration: 400})
            dom.about_carees_ul.find('.unfold').removeClass('fold')
            $(this).children('.unfold').addClass('fold')
            $(this).siblings('.carees-msg').show()
        })
        $('.carees-ul li:first h3').click();

        //aboutus honner cut
        dom.award_cut.on('click','.award-btn',function(){
            //that.allPaging(that.getAwardList)
            var curTotalPage = $('#pageNums').val();
            if(curTotalPage == 1) { return false }
            if($(this).hasClass('award-next')){
                if(++params.partCurNum>curTotalPage){
                    curPagesNum = curTotalPage
                    return false
                }
            }
            if($(this).hasClass('award-prev')){
                if(--params.partCurNum<=0){
                    params.partCurNum = 1
                    return false
                }
            }
            that.getAwardList(params.partCurNum)
        })
        //aboutus partner  type
        dom.partype.on('click','p',function () {
            $(this).addClass('active').siblings('p').removeClass('active')
            that.getParterList($(this).attr('type'))
        })
        //news cut
        // dom.lastNewsList.on('click','a',function () {
        //     $(this).addClass('active').siblings('a').removeClass('active')
        //     that.getNewsContent($(this).attr('newid'))
        // })
     
    },
    //slide judge
    JudgeSlide : function (id) {
        var hasVertical = $('#swiper'+id).find('.swiper-slide-active img').attr('vertical') ? true : false
        var hasContent = $('#swiper'+id).find('.swiper-slide-active img').attr('content') ? true : false
        if(hasVertical && hasContent){
            $('#swiper'+id).find('.swiper-pagination').animate({'left':'90px'},100)
            $('#swiper'+id).find('.swiper-slide-active img').removeClass().addClass('works-img works-img-vertical-active')
            
        }else if(hasVertical && !hasContent){
            $('#swiper'+id).find('.swiper-pagination').animate({'left':'90px'},100)
            $('#swiper'+id).find('.swiper-slide-active img').removeClass().addClass('works-img works-img-content-vertical-active')
        }else if(!hasVertical && !hasContent){
            $('#swiper'+id).find('.swiper-slide-active img').removeClass().addClass('works-img works-img-content-vertical-active')
            $('#swiper'+id).find('.swiper-pagination').animate({'left':'-270px'},100)
        }else if(!hasVertical && hasContent){
            $('#swiper'+id).find('.swiper-slide-active img').removeClass().addClass('works-img works-img-active')
            $('#swiper'+id).find('.swiper-pagination').animate({'left':'-270px'},100)
        }
    },
  
    //news swiper func
    newsCutSwiper : function (id){
        var params = this.params
        params.newsSwiper = new Swiper ('#swiper'+id, {
            autoplay:{
                delay:2000
            },
            loop:true,
            direction: 'horizontal', // 垂直切换选项
            navigation: {
                nextEl: '.swiper-button-next',
                prevEl: '.swiper-button-prev',
            },
            mousewheel: true,
            observer:true,
            observeParents:true,
            on: {
                init: function(){
                    //Swiper初始化了
                    var that = this;
                    
                },
                slideChangeTransitionEnd: function(){
                    this.update();  
                    this.navigation.update();
                    $('#pagesNum').html('0'+(this.realIndex+1))
                }
            }
        })
         
    },
    //paging
    allPaging : function (callback) {
        var params = this.params
        params.pagesTotal = $('#curPages').val()  //5
        params.curTypeId = $('#curType').val()
        $('.tabs-up').click(function () {
            if(--params.curPageNum<=0){
                params.curPageNum = 1
                return false
            }
            callback(params.curTypeId,params.curPageNum)
        })

        $('.tabs-down').click(function () {
            if(++params.curPageNum>params.pagesTotal){
                params.curPageNum = params.pagesTotal
                return false
            }
            callback(params.curTypeId,params.curPageNum)
        })
    },
    //work list
    getWorkList : function (typeid,p) {
        var that = this;
        var firstCase = null;
        $.ajax({
            type:'POST',
            url:'/api/worklist',
            data:{categoryId:typeid,page:p,limit:16},
            success:function(req){
                var str = '';
                $('#curType').val(typeid)
                if(req.code == 200 && req.pages>=0) {
                    if(req.pages <= 1 ){ $('.worksBtn').hide()}else{$('.worksBtn').show()}
                    $.each(req.list,function (index,item) {
                        if(index == 0) {firstCase = item.caseId}
                        str += '<li case="'+item.caseId+'"  '+(index==0?"class='active'":"")+'>'+(puBlic.params.language=='en'?item.enTitle:item.title)+'</li>'
                    })
                    $('#workTodo').html(str)
                    $('#curPages').val(req.pages)
                    if(p==1){
                        puBlic.getWorkCase(firstCase)
                    }
                    
                }
                
            }

        })
    },
    // work case
    getWorkCase : function (caseid) {
        var params = puBlic.params
        $.ajax({
            type:'POST',
            url:'/api/workscase',
            data:{caseId:caseid},
            success:function(req){
                var str = '';
                $.each(JSON.parse(req.imgUrls),function (index,item) {
                    str += '<img src="'+params.baseUrl+item.src+'" class="works-img" title="'+(params.language=='en'?req.titleEn:req.title)+'" alt="'+(params.language=='en'?req.titleEn:req.title)+'">'
                })
                $('#worksIntro').html('<div class="works-contents">'+(puBlic.params.language=='en'?req.enContent:req.content)+'</div><div class="works-img-section animated fadeIn" id="worksImg">'+str+'</div>')
                $('.scroll-active').css('top','0%')
            }

        })
    },
    //awardlist
    getAwardList : function (p) {
        var params = puBlic.params
        $.ajax({
            type:'POST',
            url:'/api/awardlist',
            data:{page:p,limit:4},
            success:function(req){
                var str = '';
                var str2 = '';
                var str3 = ''
                var curItemLength;
                $('#awardList').html('')
                $.each(req.list,function (index,item) {
                    str = ''
                    str2 = '';
                    curItemLength = item.list.length
                    $.each(item.list,function (nodeinx,node) {  
                        str2 += '<a href="/work?typeId='+node.categoryId+'&caseId='+node.caseId+'"><p class="wow fadeInDown" data-wow-delay="'+(nodeinx*0.6)+'s"><span></span>'+(puBlic.params.language=='en'?node.awardsNameEn:node.awardsName)+'</p></a>'
                    })
                    str = '<li><div class="award_div">'+str2+'</div>'+(curItemLength>6?"<p class='award-unfold animated infinite fadeIn'></p>":'')+'</li>'
                    str3 += '<div class="award_section"><img src="'+(params.baseUrl+(JSON.parse(item.awards.imgHUrl)).src)+'" alt="" class="award_img award_img_show wow fadeInLeft" data-wow-delay="'+(index*0.3)+'s"><img src="'+(params.baseUrl+(JSON.parse(item.awards.imgCUrl)).src)+'" alt="" class="award_img award_img_hide"><div class="award_section_r"><h3 class="wow fadeInDown" data-wow-delay="'+(index*0.4)+'s">'+(puBlic.params.language=='en'?item.awards.awardsNameEn:item.awards.awardsName)+'</h3><p class="wow fadeInDown" data-wow-delay="'+(index*0.6)+'s">'+(puBlic.params.language=='en'?item.awards.awardsDescribeEn:item.awards.awardsDescribe)+'</p><ul class="award-ul" >'+str+'</ul></div></div>'
                }) 
                $('#awardList').html(str3)
                $('#awardCurNum').html('0'+p)
            }

        })
    },
    //aboutus partner
    getParterList : function (type) { 
        var params = puBlic.params
        $("#partnerList").mCustomScrollbar("destroy")
        $.ajax({
            type:'POST',
            url:'/api/parterList',
            data:{partnerType:type},
            success:function(req){
                var str = '';
                $.each(req,function (index,item) {
                    str += '<li><a target="_blank" rel="nofollow me noopener noreferrer" href="'+item.addressUrl+'"><img class="curPartner" src="'+params.baseUrl+JSON.parse(item.imgHUrl).src+'"><img class="hdPartner" src="'+params.baseUrl+JSON.parse(item.imgCUrl).src+'"></a></li>'
                })  
                $('#partnerList').html(str)
                $("#partnerList").mCustomScrollbar({
                    axis:"y" ,
                    scrollInertia:600,
                    scrollButtons:{enable:true}
                });

            }

        })
    },
    //news conent
    getNewsContent : function (id) {
        var params = puBlic.params
        params.curNewsId = id
        var that = this
        $.ajax({
            type:'POST',
            url:'/api/newscontent',
            data:{newsId:id},
            success:function(req){
                var str = '';
                params.newsSwiper.destroy()
                if(JSON.parse(req.imgUrls).length>0){
                    $.each(JSON.parse(req.imgUrls),function (index,item) {
                        str += '<div class="swiper-slide"><img src="'+params.baseUrl+item.src+'" alt="'+(params.language=='en'?req.titleEn:req.title)+'" title="'+(params.language=='en'?req.titleEn:req.title)+'"></div>'
                    }) 
                }
                 
                $('#pagesNum').html('01')
                $('#newsLength').html('0'+JSON.parse(req.imgUrls).length)
                $('#newsTitle').html(params.language=='en'?req.titleEn:req.title)
                $('#newsDate').html(req.publishDate)
                $('#newsMain').html('<p>'+(params.language=='en'?req.contentEn:req.content)+'</p>')
                $('#swiper0').children('.swiper-wrapper').html(str)
                that.newsCutSwiper(0)
            }

        })
    },
    //news List
    getNewsList : function (curTypeId,p) {
        var params = puBlic.params
        $.ajax({
            type:'POST',
            url:'/api/newsList',
            data:{"categoryId":curTypeId,'page':p,'limit':10},
            success:function(req){
                var str = '';
                $.each(req.list,function (index,item) {
                    str += '<a '+(item.newsId==params.curNewsId?'class="active"':"")+'  newid="'+item.newsId+'" title="'+(params.language=='en'?item.titleEn:item.title)+'">'+(params.language=='en'?item.titleEn:item.title)+'</a>'
                }) 
                $('#lastNewsList').html(str)
            }

        })
    },
    //news ReleaseList
    getReleaseList : function (curTypeId,p) {
        var params = puBlic.params
        $.ajax({
            type:'POST',
            url:'/api/newsList',
            data:{"categoryId":curTypeId,'page':p,'limit':10},
            success:function(req){
                var str = '';
                $.each(req.list,function (index,item) {
                    str += '<li><a href="'+item.linkAddress+'" target="_blank">'+(params.language=='en'?item.titleEn:item.title)+'<span>'+(params.language=='en'?item.sourceEn:item.source)+'</span></a></li>'
                }) 
                $('#lastNewsList').html(str)
            }

        })
    },
    //scrill throttle
    throttle: function (ele) {
        var isRunning = false 
        return function() {
            if (isRunning) return
                isRunning = true
                // requestAnimationFrame:回调间隔 = 浏览器重绘频率
                window.requestAnimationFrame(function(timestamp) { 
                $('.scroll-active').css('top',(((ele.scrollTop + ele.clientHeight)/ele.scrollHeight)-0.25)*100+'%')
                if(ele.scrollTop + ele.clientHeight >= ele.scrollHeight) { // 检测是否滚动到元素底部
                    $('.scroll-active').css('top','75%')
                }
                if(ele.scrollTop == 0){ //顶部
                    $('.scroll-active').css('top','0%')
                }                    
                isRunning = false
            })
        }
    },
    // listen scroll
    listenScrollToBottom : function (ele , callback) {
        var that = this
        if(ele === null || ele === undefined) { // 节点不存在：抛出错误
            throw new Error('Undefined COM')
            return 
        }
        ele.addEventListener("scroll" , that.throttle(ele) , false) // 监听 scroll 事件
    }
    
};
$(function () {
    puBlic.init()
})
