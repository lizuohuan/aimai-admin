<!-- 解决layer.open 不居中问题   -->
<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <title>${name}</title>
    <!--引入抽取css文件-->
    <%@include file="../common/public-css.jsp" %>
    <style>
        .preview{height: 350px;width: 400px;margin-right: 10px;margin-bottom: 10px;float: left;text-align: center}
        .preview img{width: 100%;height:210px;border: 1px solid #eee;}

    </style>
</head>
<body ng-app="webApp">
<div style="margin: 15px;">
    <blockquote class="layui-elem-quote"><i class="fa fa-refresh" aria-hidden="true"></i>&nbsp;表单带有 <span class="font-red">“*”</span> 号的为必填项.</blockquote>
    <fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
        <legend>${name}</legend>
    </fieldset>
    <form class="layui-form" action="" id="formData" ng-controller="editCompanyCtr" ng-cloak>

        <div class="layui-form-item layui-hide" id="uploadImgDiv">
            <label class="layui-form-label">资质<span class="font-red">*</span></label>
            <div class="layui-input-inline">
                <div>
                    <input type="file" id="fileImg" name="file" class="layui-upload-file" lay-title="请上传公司资质">
                </div>
                <label class="" style="margin-left: 20px">建议尺寸210*290</label>
            </div>
        </div>

        <div class="layui-form-item layui-hide" id="previewDiv">
            <label class="layui-form-label">公司资质列表</label>
            <div class="layui-input-block" id="preview">
                <div class="preview previewContent" ng-repeat="img in imgUrls">
                    <img imgUrl="{{img.imgUrl}}" src="{{imgUrl}}/{{img.imgUrl}}"><br>
                    <input type="text" value="{{img.imgName}}" placeholder="请输入图片名字" autocomplete="off" class="layui-input" maxlength="50">
                    <button type="button" onclick="deleteImg(this)"
                           class="layui-btn layui-btn-danger"><i class="layui-icon">&#xe640;</i>删除</button>
                </div>
            </div>
        </div>



        <div class="layui-form-item layui-hide" id="contentDiv">
            <label class="layui-form-label">内容<span class="font-red">*</span></label>
            <div class="layui-input-block">
                <textarea class="layui-textarea" id="LAY_demo1" style="display: none"></textarea>
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
<script>
    var form;
    var webApp=angular.module('webApp',[]);
    webApp.controller("editCompanyCtr", function($scope,$http,$timeout){
        $scope.content = null; //公司内容
        $scope.contentId = AM.getUrlParam("id"); //内容id信息
        $scope.imgUrl = AM.ipImg;
        $scope.imgUrls = [];
        AM.ajaxRequestData("post", false, AM.ip + "/content/info", {id:$scope.contentId} , function(result) {
            if (result.flag == 0 && result.code == 200) {
                $scope.content = result.data;

            }
        });

        layui.use(['form', 'layedit', 'laydate', 'upload', 'layedit'], function() {
            form = layui.form(),
                    layer = layui.layer,
                    layedit = layui.layedit
                    ,$ = layui.jquery,
                    laydate = layui.laydate;


            if ($scope.contentId != 2) {
                $("#LAY_demo1").html($scope.content.content);
                $("#contentDiv").show();
                form.render();
            } else {
                var uploadMsg;
                //上传移动端banner图
                layui.upload({
                    url: AM.ipImg + "/res/upload" //上传接口
                    ,elem: '#fileImg'
                    ,before: function(){
                        uploadMsg = layer.msg('上传中，请不要刷新页面', {icon: 16,shade: 0.5, time: 100000000 })
                    }
                    ,success: function(res){ //上传成功后的回调
                        var html = '<div class="preview previewContent">' +
                                '<img imgUrl="'+ res.data.url +'" src="' + AM.ipImg + '/' + res.data.url + '"><br>' +
                                '<input type="text" placeholder="请输入图片名字" autocomplete="off" class="layui-input" maxlength="50"><br>' +
                                "<button type=\"button\" class=\"layui-btn layui-btn-danger\" logo=\"" + res.data.url + "\" onclick=\"deleteImg(this)\"><i class=\"layui-icon\">&#xe640;</i>删除</button></div>";
                        $("#preview").append(html);
                        $("#preview").parent().show();
                        layer.close(uploadMsg);
                        form.render();
                    }
                });
                $("#uploadImgDiv").show();
                if ($scope.content.content == null || $scope.content.content == "") {
                    $("#previewDiv").hide();
                } else {
                    $scope.imgUrls = JSON.parse($scope.content.content);
                    console.log(JSON.parse($scope.content.content));
                    $("#previewDiv").show();
                }
            }

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
            //构建一个默认的编辑器
            var index = layedit.build('LAY_demo1');



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
                data.field.id = $scope.contentId;

                if ($scope.contentId != 2) {
                    data.field.content = layedit.getContent(index);
                } else {
                    var imgs = [];
                    $(".previewContent").each(function(){
                        var ary = {
                            imgUrl:$(this).find("img").attr("imgUrl"),
                            imgName:$(this).find("input").val()
                        }
                        imgs.push(ary);
                    });
                    data.field.content = JSON.stringify(imgs);
                }
                console.log(data.field);
                AM.ajaxRequestData("post", false, AM.ip + "/content/update", data.field , function(result) {
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
        $(object).parent().remove();
        var c = $(".previewContent");
        if (c.length == 0) $("#preview").parent().hide();
        form.render();
    }
</script>
</body>
</html>
