<!-- 解决layer.open 不居中问题   -->
<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <title>添加视频库视频</title>
    <!--引入抽取css文件-->
    <%@include file="../common/public-css.jsp" %>
    <style>
        .preview{height: 350px;width: 400px;margin-right: 10px;margin-bottom: 10px;float: left;text-align: center}
        .preview img{width: 100%;height:210px;border: 1px solid #eee;}
        .preview video{width: 100%;height:210px;border: 1px solid #eee;}
    </style>
</head>
<body ng-app="webApp">
<div style="margin: 15px;">
    <blockquote class="layui-elem-quote"><i class="fa fa-refresh" aria-hidden="true"></i>&nbsp;表单带有 <span class="font-red">“*”</span> 号的为必填项.</blockquote>
    <fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
        <legend>添加视频库视频</legend>
    </fieldset>
    <form class="layui-form" action="" id="formData" ng-controller="editCompanyCtr" ng-cloak>
        <div class="layui-form-item" id="uploadImgDiv">
            <label class="layui-form-label">视频<span class="font-red">*</span></label>
            <div class="layui-input-inline">
                <input type="file" lay-type="video" id="fileImg" name="file" multiple class="layui-upload-file" lay-title="请上传视频">
            </div>
        </div>
        <div class="layui-form-item layui-hide" id="previewDiv">
            <label class="layui-form-label">视频列表</label>
            <div class="layui-input-block" id="preview">
            </div>
        </div>


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
<script src="<%=request.getContextPath()%>/resources/media/lib/es6-promise.min.js"></script>
<script src="<%=request.getContextPath()%>/resources/media/lib/aliyun-oss-sdk.js"></script>
<script src="<%=request.getContextPath()%>/resources/media/aliyun-upload-sdk-1.3.0.min.js"></script>
<script>
    var form;
    var webApp=angular.module('webApp',[]);
    webApp.controller("editCompanyCtr", function($scope,$http,$timeout){

        layui.use(['form', 'layedit', 'laydate', 'upload', 'layedit'], function() {
            form = layui.form(),
                    layer = layui.layer,
                    layedit = layui.layedit
                    ,$ = layui.jquery,
                    laydate = layui.laydate;

            var uploadMsg;





            //批量上传视频
            layui.upload({
                url: AM.ipVideo + "/res/upload2" //上传接口
                ,elem: '#fileImg'
                ,before: function(){
                    uploadMsg = layer.msg('上传中，请不要刷新页面', {icon: 16,shade: 0.5, time: 100000000 })
                }
                ,success: function(res){ //上传成功后的回调
                    var urls = res.data.url.split(",");
                    for (var i = 0 ; i < urls.length ; i ++) {
                        var html = '<div class="preview previewContent">' +
                                '<video videoUrl="'+urls[i]+'" id="video" controls="controls" src="'+AM.ipVideo + '/' + urls[i] +'"></video><br>' +
                        '<input type="text" placeholder="请输入视频名字" autocomplete="off" class="layui-input" maxlength="50"><br>' +
                        "<button type=\"button\" class=\"layui-btn layui-btn-danger\" onclick=\"deleteImg(this)\"><i class=\"layui-icon\">&#xe640;</i>删除</button></div>";
                        $("#preview").append(html);
                    }
                    $("#preview").parent().show();
                    layer.close(uploadMsg);
                    form.render();
                }
            });

            form.render();

            //监听提交
            form.on('submit(demo1)', function(data) {
                var videos = [];
                var flag = true;
                $(".previewContent").each(function(){
                    var url = $(this).find("video").attr("videoUrl");
                    var name = $(this).find("input").val();
                    if (name == null || name == "") {
                        flag = false;
                    }
                    var ary = {
                        url:url,
                        name:name,
                        seconds:$(this).find("video")[0].duration
                    }
                    videos.push(ary);
                });
                data.field.videoWareHouses = JSON.stringify(videos);
                if (!flag) {
                    layer.msg('请输入视频名', {icon: 2,anim: 6});
                    return false;
                }
                console.log(data.field);

                AM.ajaxRequestData("post", false, AM.ip + "/videoWareHouse/save", data.field , function(result) {
                    if (result.flag == 0 && result.code == 200) {
                        var index =layer.alert('添加成功.', {
                            skin: 'layui-layer-molv' //样式类名
                            ,closeBtn: 0
                            ,anim: 4 //动画类型
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
    });


    //删除视频
    function deleteImg (object) {
        $(object).parent().remove();
        //同时删除视频
        deleteVideo($(object).parent().find("video").attr("videoUrl"));
        var c = $(".previewContent");
        if (c.length == 0) $("#preview").parent().hide();
        form.render();
    }
    //删除视频
    function deleteVideo(url) {
        AM.ajaxRequestData("post", false, AM.ipVideo + "/res/delete", {url: url}, function (result) {

        });
    }
</script>
</body>
</html>
