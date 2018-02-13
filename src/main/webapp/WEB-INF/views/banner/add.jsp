<!-- 解决layer.open 不居中问题   -->
<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <title>添加banner</title>
    <!--引入抽取css文件-->
    <%@include file="../common/public-css.jsp" %>
    <style>
        .preview{height: 250px;width: 678px;margin-right: 10px;margin-bottom: 10px;float: left;text-align: center}
        .preview img{width: 100%;height:210px;border: 1px solid #eee;}
        #edui1{z-index: 9 !important;}
    </style>
</head>
<body>
<div style="margin: 15px;">
    <blockquote class="layui-elem-quote"><i class="fa fa-refresh" aria-hidden="true"></i>&nbsp;表单带有 <span class="font-red">“*”</span> 号的为必填项.</blockquote>
    <fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
        <legend>添加banner</legend>
    </fieldset>
    <form class="layui-form" action="" id="formData">


        <div class="layui-form-item" id="uploadImgDivApp">
            <label class="layui-form-label">移动端banner图<span id="spanImgApp" class="font-red">*</span></label>
            <div class="layui-input-inline">
                <div>
                    <input type="file" id="fileAppImg" name="file" class="layui-upload-file" lay-title="上传移动端banner图">
                </div>
                <label class="" style="margin-left: 20px">建议尺寸300*200</label>
            </div>
        </div>

        <div class="layui-form-item layui-hide">
            <label class="layui-form-label">预览</label>
            <div class="layui-input-block" id="previewApp">

            </div>
        </div>


        <div class="layui-form-item" id="uploadImgDivPC">
            <label class="layui-form-label">PC端banner图<span class="font-red">*</span></label>
            <div class="layui-input-inline">
                <div>
                    <input type="file" id="filePCImg" name="file" class="layui-upload-file" lay-title="上传PC端banner图">
                </div>
                <label class="" id="pcSize"  style="margin-left: 20px">建议尺寸1920*678</label>
            </div>
        </div>



        <div class="layui-form-item layui-hide">
            <label class="layui-form-label">预览</label>
            <div class="layui-input-block" id="previewPC">

            </div>
        </div>

        <div class="layui-form-item">
            <label class="layui-form-label">类型<span class="font-red">*</span></label>
            <div class="layui-input-inline">
                <select name="isBanner" id="isBanner" lay-verify="required" lay-filter="isBanner" lay-search>
                    <option value="">请选择类型</option>
                    <option value="0">PC广告</option>
                    <option value="1">banner</option>
                </select>
            </div>
        </div>

        <div class="layui-form-item layui-hide" id="locationDiv">
            <label class="layui-form-label">显示位置<span class="font-red">*</span></label>
            <div class="layui-input-inline">
                <select name="location" id="location" lay-filter="location" lay-verify="required" lay-search>
                    <option value="">请选择显示位置</option>
                    <option value="1">PC端上</option>
                    <option value="2">PC端左</option>
                    <option value="3">PC端底</option>
                </select>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">标题 <span class="font-red">*</span></label>
            <div class="layui-input-block">
                <input type="text" name="title" lay-verify="required" placeholder="请输入标题" autocomplete="off" class="layui-input" maxlength="50">
            </div>
        </div>

        <div class="layui-form-item">
            <label class="layui-form-label">责任编辑人</label>
            <div class="layui-input-block">
                <input type="text" name="editor" placeholder="请输入责任编辑人" autocomplete="off" class="layui-input" maxlength="50">
            </div>
        </div>

        <div class="layui-form-item">
            <label class="layui-form-label">内容<span class="font-red">*</span></label>
            <div class="layui-input-block">
                <%--<textarea name="context" class="layui-textarea" id="LAY_demo1" style="display: none"></textarea>--%>
                    <script id="editor" style="height:500px;width:100%" name="content" type="text/plain">
                    </script>
            </div>
        </div>

        <div class="layui-form-item">
            <label class="layui-form-label">来源</label>
            <div class="layui-input-block">
                <input type="text" name="source" placeholder="请输入来源" autocomplete="off" class="layui-input" maxlength="50">
            </div>
        </div>


        <div class="layui-form-item">
            <label class="layui-form-label">是否是外链</label>
            <div class="layui-input-block">
                <input type="radio" name="isLink" value="0" title="否" checked="">
                <input type="radio" name="isLink" value="1" title="是">
            </div>
        </div>

        <div class="layui-form-item">
            <label class="layui-form-label">外链地址</label>
            <div class="layui-input-block">
                <input type="text" name="linkUrl" placeholder="请输入外链地址" autocomplete="off" class="layui-input" maxlength="50">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">到期时间<span class="font-red">*</span></label>
            <div class="layui-input-inline">
                <input type="text" id="validitys" name="validitys"  readonly lay-verify="" placeholder="请输入到期时间" autocomplete="off" class="layui-input" maxlength="20">
            </div>
        </div>

        <input type="hidden" name="apiImage" id="apiImage">
        <input type="hidden" name="pcImage" id="pcImage">

        <div class="layui-form-item">
            <div class="layui-input-block">
                <button class="layui-btn" lay-submit="" lay-filter="demo1">立即提交</button>
                <button type="reset" class="layui-btn layui-btn-primary">重置</button>
            </div>
        </div>
    </form>
</div>
<!--引入抽取公共js-->
<%@include file="../common/public-js.jsp" %>
<!-- 配置文件 -->
<script type="text/javascript" src="<%=request.getContextPath()%>/ue/ueditor.config.js"></script>
<!-- 编辑器源码文件 -->
<script type="text/javascript" src="<%=request.getContextPath()%>/ue/ueditor.all.js"></script>
<script src="<%=request.getContextPath()%>/ue/lang/zh-cn/zh-cn.js"></script>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/ue/themes/default/css/ueditor.css" />
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/ue/themes/default/css/ueditor.min.css" />
<script>


    layui.use(['form', 'layedit', 'laydate', 'upload', 'layedit'], function() {
        var form = layui.form(),
                layer = layui.layer,
                layedit = layui.layedit
                ,$ = layui.jquery,
                laydate = layui.laydate;

        UE.getEditor('editor');
        var uploadMsg;
        //上传移动端banner图
        layui.upload({
            url: AM.ipImg + "/res/upload" //上传接口
            ,elem: '#fileAppImg'
            ,before: function(){
                uploadMsg = layer.msg('上传中，请不要刷新页面', {icon: 16,shade: 0.5, time: 100000000 })
            }
            ,success: function(res){ //上传成功后的回调
                console.log(res.data.url);
                var urls = $("#apiImage").val().split(",");
                if (urls[0] == "") {
                    urls = [];
                }
                urls.push(res.data.url);
                $("#apiImage").val(urls.toString());
                var html = '<div class="preview">' +
                        '<img src="' + AM.ipImg + '/' + res.data.url + '"><br>' +
                        "<button type=\"button\" class=\"layui-btn layui-btn-danger\" apiImage=\"" + res.data.url + "\" onclick=\"deleteImg(this,0)\"><i class=\"layui-icon\">&#xe640;</i>删除</button></div>";
                $("#previewApp").append(html);
                $("#previewApp").parent().show();
                $("#uploadImgDivApp").hide();
                layer.close(uploadMsg);
                form.render();
            }
        });

        //上传PC端banner图
        layui.upload({
            url: AM.ipImg + "/res/upload" //上传接口
            ,elem: '#filePCImg'
            ,before: function(){
                uploadMsg = layer.msg('上传中，请不要刷新页面', {icon: 16,shade: 0.5, time: 100000000 })
            }
            ,success: function(res){
                console.log(res.data.url);
                var urls = $("#pcImage").val().split(",");
                if (urls[0] == "") {
                    urls = [];
                }
                urls.push(res.data.url);
                $("#pcImage").val(urls.toString());
                var html = '<div class="preview">' +
                        '<img src="' + AM.ipImg + '/' + res.data.url + '"><br>' +
                        "<button type=\"button\" class=\"layui-btn layui-btn-danger\" pcImage=\"" + res.data.url + "\" onclick=\"deleteImg(this,1)\"><i class=\"layui-icon\">&#xe640;</i>删除</button></div>";


                $("#previewPC").append(html);
                $("#previewPC").parent().show();
                layer.close(uploadMsg);
                $("#uploadImgDivPC").hide();
            }
        });


        //添加富文本编辑器的上传图片接口
//        layedit.set({
//            uploadImage: {
//                url: AM.ipImg + "/res/upload2", //上传接口
//                type: 'post', //默认post
//            },
//            uploadVideo: {
//                url: AM.ipVideo + "/res/upload3", //上传接口
//                type: 'post', //默认post
//            }
//        });

        //自定义验证规则
        form.verify({
            isNumber: function(value) {
                if(value.length > 0 && !AM.isNumber.test(value)) {
                    return "请输入一个整数";
                }
            },
        });

        //构建一个默认的编辑器
//        var index = layedit.build('LAY_demo1');

        form.render();
        //监听类型
        form.on('select(isBanner)', function(data) {
            if (data.value == 0) {
                $("#locationDiv").show()
                $("#spanImgApp").html("");
                if ($("#location").val() == 1) {
                    $("#pcSize").html("建议尺寸1200*160");
                } else if ($("#location").val() == 2) {
                    $("#pcSize").html("建议尺寸160*678");
                } else if ($("#location").val() == 3) {
                    $("#pcSize").html("建议尺寸1200*160");
                } else {
                    $("#pcSize").html("建议尺寸1200*160");
                }
                $("#location").attr("lay-verify","required");

            } else {
                $("#locationDiv").hide()
                $("#spanImgApp").html("*");
                $("#pcSize").html("建议尺寸1920*678");
                $("#location").removeAttr("lay-verify");
            }
            form.render();
        });
        //监听类型
        form.on('select(location)', function(data) {
            if (data.value == 1) {
                $("#pcSize").html("建议尺寸1200*160");
            } else if (data.value == 2) {
                $("#pcSize").html("建议尺寸160*678");
            } else if (data.value == 3) {
                $("#pcSize").html("建议尺寸1200*160");
            } else {
                $("#pcSize").html("建议尺寸1200*160");
            }
            form.render();
        });


        var validitys = {
            max: '2099-06-16 23:59:59'
            ,format: 'YYYY-MM-DD hh:mm:ss'
            ,istoday: false
            ,choose: function(datas){
//                validityEndTimes.start = datas //将结束日的初始值设定为开始日
            }
        };
        document.getElementById('validitys').onclick = function(){
            validitys.elem = this;
            laydate(validitys);
        }

        //监听提交
        form.on('submit(demo1)', function(data) {
            data.field.content = UE.getEditor('editor').getContent();
            if (data.field.isBanner == 1 && data.field.apiImage == "") {
                layer.msg('移动端banner图.', {icon: 2,anim: 6});
                return false;
            }
            if (data.field.pcImage == "") {
                layer.msg('PC端banner图.', {icon: 2,anim: 6});
                return false;
            }
            if (data.field.content == "") {
                layer.msg('请输入内容.', {icon: 2,anim: 6});
                return false;
            }

            if(data.field.isLink == 1 && data.field.linkUrl == ""){
                layer.msg('输入外链地址.', {icon: 2,anim: 6});
                return false;
            }
            console.log(data.field);

            AM.ajaxRequestData("post", false, AM.ip + "/banner/save", data.field , function(result) {
                if (result.flag == 0 && result.code == 200) {
                    layer.alert('添加成功.', {
                        skin: 'layui-layer-molv' //样式类名
                        ,closeBtn: 0
                        ,anim: 3 //动画类型
                    }, function(){
                        //关闭iframe页面
                        var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
                        parent.layer.close(index);
                        window.parent.closeNodeIframe();
                    });
                }
            });
            return false;
        });
    });

    //删除图片
    function deleteImg (object,type) {
        if (type == 0) {
            var url = $(object).attr("apiImage");
            var apiImages = $("#apiImage").val().split(",");
            for (var i = 0; i < apiImages.length; i++) {
                if (apiImages[i] == url) {
                    apiImages.splice(i, 1);
                    $(object).parent().fadeOut();
                    break;
                }
            }
            if (apiImages.length == 0) $("#previewApp").parent().hide();
            console.log(apiImages);
            $("#apiImage").val(apiImages.toString());
            $("#uploadImgDivApp").show();
        } else if (type == 1){
            var url = $(object).attr("pcImage");
            var pcImages = $("#pcImage").val().split(",");
            for (var i = 0; i < pcImages.length; i++) {
                if (pcImages[i] == url) {
                    pcImages.splice(i, 1);
                    $(object).parent().fadeOut();
                    break;
                }
            }
            if (pcImages.length == 0) $("#previewPC").parent().hide();
            console.log(pcImages);
            $("#pcImage").val(pcImages.toString());
            $("#uploadImgDivPC").show();
        }
    }
</script>
</body>
</html>
