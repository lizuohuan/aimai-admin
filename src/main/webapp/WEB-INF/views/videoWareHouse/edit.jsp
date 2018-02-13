<!-- 解决layer.open 不居中问题   -->
<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <title>修改视频</title>
    <!--引入抽取css文件-->
    <%@include file="../common/public-css.jsp" %>
    <style>
        .preview{height: 250px;width: 400px;margin-right: 10px;margin-bottom: 10px;float: left;text-align: center}
        .preview img{width: 100%;height:210px;border: 1px solid #eee;}
        .preview video{width: 100%;height:210px;border: 1px solid #eee;}
    </style>
</head>
<body ng-app="webApp">
<div style="margin: 15px;">
    <blockquote class="layui-elem-quote"><i class="fa fa-refresh" aria-hidden="true"></i>&nbsp;表单带有 <span class="font-red">“*”</span> 号的为必填项.</blockquote>
    <fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
        <legend>修改视频</legend>
    </fieldset>
    <form class="layui-form" action="" id="formData" ng-controller="editVideoCtr" ng-cloak>

        <div class="layui-form-item">
            <label class="layui-form-label">视频名<span class="font-red">*</span></label>
            <div class="layui-input-inline">
                <input type="text" name="name" value="{{videoWareHouse.name}}" lay-verify="required" placeholder="请输入课件名" autocomplete="off" class="layui-input" maxlength="50">
            </div>
        </div>
        <div class="layui-form-item" id="uploadImgDiv">
            <label class="layui-form-label">视频<span class="font-red">*</span></label>
            <div class="layui-input-inline">
                <input type="file" lay-type="video" id="fileImg" name="file" class="layui-upload-file" lay-title="请上传视频">
            </div>
        </div>
        <div class="layui-form-item layui-hide" id="previewDiv">
            <label class="layui-form-label">预览</label>
            <div class="layui-input-block" id="preview">
            </div>
        </div>

        <div class="layui-form-item">
            <div class="layui-input-block">
                <button class="layui-btn" lay-submit="" lay-filter="demo1">立即提交</button>
                <button type="reset" class="layui-btn layui-btn-primary">重置</button>
            </div>
        </div>

        <input id="oldVideoUrl" style="display: none;" value="{{videoWareHouse.url}}">
    </form>
</div>
<!--引入抽取公共js-->
<%@include file="../common/public-js.jsp" %>
<script>

    var form;
    var webApp=angular.module('webApp',[]);
    webApp.controller("editVideoCtr", function($scope,$http,$timeout){

        $scope.id = AM.getUrlParam("id");
        $scope.imgUrl = AM.ipImg;
        $scope.videoUrl = AM.ipVideo;

        AM.ajaxRequestData("get", false, AM.ip + "/videoWareHouse/info", {id : $scope.id}  , function(result) {
            $scope.videoWareHouse = result.data;
        });

        layui.use(['form', 'layedit', 'laydate', 'upload', 'layedit'], function() {
            form = layui.form(),
                    layer = layui.layer,
                    layedit = layui.layedit
                    ,$ = layui.jquery,
                    laydate = layui.laydate;

            if ($scope.videoWareHouse.url != null) {
                $("#uploadImgDiv").hide();
                var html = '<div class="preview previewContent">' +
                        '<video videoUrl="'+$scope.videoWareHouse.url+'" id="video" controls="controls" src="'+AM.ipVideo + '/' + $scope.videoWareHouse.url +'"></video><br>' +
                        "<button type=\"button\" class=\"layui-btn layui-btn-danger\" " +
                        "onclick=\"deleteImg(this)\"><i class=\"layui-icon\">&#xe640;</i>删除</button></div>";
                $("#preview").append(html);
                $("#preview").parent().show();
                form.render();
            }

            var uploadMsg;

            //上传图片
            layui.upload({
                url: AM.ipVideo + "/res/upload" //上传接口
                ,elem: '#fileImg'
                ,before: function(){
                    uploadMsg = layer.msg('上传中，请不要刷新页面', {icon: 16,shade: 0.5, time: 100000000 })
                }
                ,success: function(res){ //上传成功后的回调
                    console.log(res.data.url);
                    var html = '<div class="preview previewContent">' +
                            '<video videoUrl="'+res.data.url+'" id="video" controls="controls" src="'+AM.ipVideo + '/' + res.data.url +'"></video><br>' +
                            "<button type=\"button\" class=\"layui-btn layui-btn-danger\" cover=\"" + res.data.url + "\" onclick=\"deleteImg(this)\"><i class=\"layui-icon\">&#xe640;</i>删除</button></div>";
                    $("#preview").append(html);
                    $("#preview").parent().show();
                    $("#uploadImgDiv").hide();
                    layer.close(uploadMsg);
                    form.render();
                }
            });


            //自定义验证规则
            form.verify({
                isNumber: function(value) {
                    if(value.length > 0 && !AM.isNumber.test(value)) {
                        return "请输入一个整数";
                    }
                },
            });

            form.render();



            //监听提交
            form.on('submit(demo1)', function(data) {

                var flag = true;
                var url = null;
                $(".previewContent").each(function(){
                    url = $(this).find("videoUrl").attr("videoUrl");
                });
                data.field.url = url;
                data.field.id = $scope.id;
                data.field.seconds = parseInt(Number(document.getElementById("video").duration));
                console.log(data.field);
                AM.ajaxRequestData("post", false, AM.ip + "/videoWareHouse/update", data.field  , function(result) {
                    if (result.flag == 0 && result.code == 200) {
                        layer.alert('修改成功.', {
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

        var oldVideoUrl = $("#oldVideoUrl").val();
        if (null != oldVideoUrl && oldVideoUrl != $(object).parent().find("video").attr("videoUrl")) {
            deleteVideo($(object).parent().find("video").attr("videoUrl"));
        }

        var c = $(".previewContent");
        if (c.length == 0){$("#previewDiv").hide(); $("#uploadImgDiv").show();}
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
