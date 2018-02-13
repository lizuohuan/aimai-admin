<!-- 解决layer.open 不居中问题   -->
<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <title>公司信息</title>
    <!--引入抽取css文件-->
    <%@include file="../common/public-css.jsp" %>
    <style>
        .preview{height: 250px;width: 400px;margin-right: 10px;margin-bottom: 10px;float: left;text-align: center}
        .preview img{width: 100%;height:210px;border: 1px solid #eee;}

    </style>
</head>
<body ng-app="webApp">
<div style="margin: 15px;">
    <blockquote class="layui-elem-quote"><i class="fa fa-refresh" aria-hidden="true"></i>&nbsp;表单带有 <span class="font-red">“*”</span> 号的为必填项.</blockquote>
    <fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
        <legend>公司信息</legend>
    </fieldset>
    <form class="layui-form" action="" id="formData" ng-controller="editCompanyCtr" ng-cloak>

        <div class="layui-form-item" id="uploadImgDiv">
            <label class="layui-form-label">公司logo<span class="font-red">*</span></label>
            <div class="layui-input-inline">
                <div>
                    <input type="file" id="fileImg" name="file" class="layui-upload-file" lay-title="请上传公司logo">
                </div>
                <label class="" style="margin-left: 20px">建议尺寸200*30</label>
            </div>
        </div>

        <div class="layui-form-item" id="previewDiv">
            <label class="layui-form-label">预览公司logo</label>
            <div class="layui-input-block" id="preview">
                <div class="preview" ng-if="company.logo != null">
                    <img src="{{imgUrl}}/{{company.logo}}"><br>
                    <button type="button" onclick="deleteImg(this)"
                            logo="{{company.logo}}" class="layui-btn layui-btn-danger"><i class="layui-icon">&#xe640;</i>删除</button>
                </div>
            </div>
        </div>

        <div class="layui-form-item">
            <label class="layui-form-label">公司名称 <span class="font-red">*</span></label>
            <div class="layui-input-block">
                <input type="text" value="{{company.name}}" name="name" lay-verify="required" placeholder="请输入公司名称" autocomplete="off" class="layui-input" maxlength="50">
            </div>
        </div>

        <div class="layui-form-item">
            <label class="layui-form-label">服务热线</label>
            <div class="layui-input-block">
                <input type="text" value="{{company.mobile}}" name="mobile" placeholder="请输入服务热线" autocomplete="off" class="layui-input" maxlength="50">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">传真</label>
            <div class="layui-input-block">
                <input type="text" value="{{company.fax}}" name="fax" placeholder="请输入传真" autocomplete="off" class="layui-input" maxlength="50">
            </div>
        </div>

        <div class="layui-form-item">
            <label class="layui-form-label">邮箱</label>
            <div class="layui-input-block">
                <input type="text" value="{{company.email}}" name="email" placeholder="请输入邮箱" autocomplete="off" class="layui-input" maxlength="50">
            </div>
        </div>


        <div class="layui-form-item">
            <label class="layui-form-label">公司网址</label>
            <div class="layui-input-block">
                <input type="text" value="{{company.url}}" name="url" placeholder="请输入公司网址" autocomplete="off" class="layui-input" maxlength="50">
            </div>
        </div>

        <div class="layui-form-item">
            <label class="layui-form-label">公司地址</label>
            <div class="layui-input-block">
                <input type="text" value="{{company.address}}" name="address" placeholder="请输入公司地址" autocomplete="off" class="layui-input" maxlength="50">
            </div>
        </div>

        <div class="layui-form-item">
            <label class="layui-form-label">公司介绍<span class="font-red">*</span></label>
            <div class="layui-input-block">
                <textarea name="context" class="layui-textarea" id="LAY_demo1" style="display: none"></textarea>
            </div>
        </div>
        <input type="hidden" name="logo" value="{{company.logo}}" id="logo">

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
<script>

    var webApp=angular.module('webApp',[]);
    webApp.controller("editCompanyCtr", function($scope,$http,$timeout){
        $scope.company = null; //公司信息
        $scope.imgUrl = AM.ipImg;
        AM.ajaxRequestData("post", false, AM.ip + "/company/info", {} , function(result) {
            if (result.flag == 0 && result.code == 200) {
                $scope.company = result.data;
                $("#LAY_demo1").html($scope.company.introduce);
            }
        });

        layui.use(['form', 'layedit', 'laydate', 'upload', 'layedit'], function() {
            var form = layui.form(),
                    layer = layui.layer,
                    layedit = layui.layedit
                    ,$ = layui.jquery,
                    laydate = layui.laydate;


            if ($scope.company.logo != null) {
                $("#uploadImgDiv").hide();
            } else {
                $("#previewDiv").hide();
            }
            var uploadMsg;
            //上传公司logo
            layui.upload({
                url: AM.ipImg + "/res/upload?type=logo" //上传接口
                ,elem: '#fileImg'
                ,before: function(){
                    uploadMsg = layer.msg('上传中，请不要刷新页面', {icon: 16,shade: 0.5, time: 100000000 })
                }
                ,success: function(res){ //上传成功后的回调
                    console.log(res.data.url);
                    var urls = $("#logo").val().split(",");
                    if (urls[0] == "") {
                        urls = [];
                    }
                    urls.push(res.data.url);
                    $("#logo").val(urls.toString());
                    var html = '<div class="preview">' +
                            '<img src="' + AM.ipImg + '/' + res.data.url + '"><br>' +
                            "<button type=\"button\" class=\"layui-btn layui-btn-danger\" logo=\"" + res.data.url + "\" onclick=\"deleteImg(this,0)\"><i class=\"layui-icon\">&#xe640;</i>删除</button></div>";
                    $("#preview").append(html);
                    $("#preview").parent().show();
                    $("#uploadImgDiv").hide();
                    layer.close(uploadMsg);
                    form.render();
                }
            });


            //添加富文本编辑器的上传图片接口
            layedit.set({
                uploadImage: {
                    url: AM.ipImg + "/res/upload2", //上传接口
                    type: 'post', //默认post
                },
                uploadVideo: {
                    url: AM.ipVideo + "/res/upload3", //上传接口
                    type: 'post', //默认post
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

            //构建一个默认的编辑器
            var index = layedit.build('LAY_demo1');

            form.render();

            //监听提交
            form.on('submit(demo1)', function(data) {
                data.field.id = $scope.company.id;
                data.field.introduce = layedit.getContent(index);
                if (data.field.logo == "") {
                    layer.msg('请上传公司logo.', {icon: 2,anim: 6});
                    return false;
                }
                console.log(data.field);
                AM.ajaxRequestData("post", false, AM.ip + "/company/update", data.field , function(result) {
                    if (result.flag == 0 && result.code == 200) {
                        var index =layer.alert('修改成功.', {
                            skin: 'layui-layer-molv' //样式类名
                            ,closeBtn: 0
                            ,anim: 4 //动画类型
                        }, function(){
                            layer.close(index);
                        });
                    }
                });
                return false;
            });
        });
    });


    //删除图片
    function deleteImg (object) {
        var url = $(object).attr("logo");
        var logos = $("#logo").val().split(",");
        for (var i = 0; i < logos.length; i++) {
            if (logos[i] == url) {
                logos.splice(i, 1);
                $(object).parent().fadeOut();
                break;
            }
        }
        if (logos.length == 0) $("#preview").parent().hide();
        console.log(logos);
        $("#logo").val(logos.toString());
        $("#uploadImgDiv").show();
    }
</script>
</body>
</html>
