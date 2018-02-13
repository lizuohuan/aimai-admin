<!-- 解决layer.open 不居中问题   -->
<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <title>修改试卷</title>
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
        <legend>修改试卷</legend>
    </fieldset>
    <form class="layui-form" action="" id="formData" ng-controller="editPaperCtr" ng-cloak>

        <div class="layui-form-item">
            <label class="layui-form-label">添加试卷<span class="font-red">*</span></label>
            <div class="layui-input-inline">
                <input type="text" name="paperTitle" disabled value="{{paper.paperTitle}}" lay-verify="required" placeholder="请输入试卷名称" autocomplete="off" class="layui-input" maxlength="50">
            </div>
        </div>


        <div class="layui-form-item">
            <label class="layui-form-label">选择类型</label>
            <div class="layui-input-inline">
                <select name="type" lay-verify="required" disabled  lay-filter="typeChange" >
                    <!--0：练习题  1：模拟题 2：考试题  -->
                    <option value="">选择类型</option>
                    <option value="0">练习题</option>
                    <option value="1">模拟题</option>
                    <option value="2">考试题</option>
                </select>
            </div>
        </div>


        <div class="layui-form-item">
            <label class="layui-form-label">选择课程/课件<span class="font-red">*</span></label>
            <div class="layui-input-inline">
                <div class="layui-input-inline">
                    <input type="text" name="targetName" disabled value="{{paper.targetName}}" lay-verify="required" placeholder="请输入试卷名称" autocomplete="off" class="layui-input" maxlength="50">
                </div>
            </div>
        </div>

        <div class="layui-form-item" id="useTimeDiv">
            <label class="layui-form-label">用时<span class="font-red">*</span></label>
            <div class="layui-input-inline">
                <input type="number" id="useTimeInput" value="{{paper.useTime}}" name="useTime" placeholder="输入用时(单位：小时)" autocomplete="off" class="layui-input" lay-verify="required" >
            </div>
        </div>


        <div class="layui-form-item" >
            <label class="layui-form-label">及格分数<span class="font-red">*</span></label>
            <div class="layui-input-inline">
                <input type="number" value="{{paper.passScore}}" name="passScore" placeholder="及格分数" autocomplete="off" class="layui-input" lay-verify="required"  >
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

    var webApp=angular.module('webApp',[]);
    webApp.controller("editPaperCtr", function($scope,$http,$timeout){
        $scope.paper = null; //题库信息
        $scope.paperId = AM.getUrlParam("id");
        AM.ajaxRequestData("post", false, AM.ip + "/paper/info", {id : $scope.paperId} , function(result) {
            if (result.flag == 0 && result.code == 200) {
                $scope.paper = result.data;
            }
        });
        layui.use(['form', 'layedit', 'laydate', 'upload', 'layedit'], function() {
            var form = layui.form(),
                    layer = layui.layer,
                    layedit = layui.layedit
                    ,$ = layui.jquery,
                    laydate = layui.laydate;

            //自定义验证规则
            form.verify({
                isNumber: function(value) {
                    if(value.length > 0 && !YZ.isNumber.test(value)) {
                        return "请输入一个整数";
                    }
                },
            });

            $("select[name='type'] option").each(function(){
                if ($(this).val() == $scope.paper.type) {
                    $(this).attr("selected", true);
                }
            });

            if ($scope.paper.type == 0) {
                $("#useTimeDiv").hide();
                $("#useTimeInput").removeAttr("lay-verify");
            } else {
                $("#useTimeDiv").show();
                $("#useTimeInput").attr("lay-verify","required");
            }

            form.render();

            //监听提交
            form.on('submit(demo1)', function(data) {
                data.field.id=$scope.paperId;
                data.field.useTime =  parseInt(data.field.useTime * 60 * 60);
                AM.ajaxRequestData("post", false, AM.ip + "/paper/update", data.field , function(result) {
                    if (result.flag == 0 && result.code == 200) {
                        layer.alert('更新成功.', {
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
    });


</script>
</body>
</html>
