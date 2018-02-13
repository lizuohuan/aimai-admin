<!-- 解决layer.open 不居中问题   -->
<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <title>用户详情(档案管理)</title>
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
        <legend>用户详情</legend>
    </fieldset>
    <form class="layui-form" action="" id="formData" ng-controller="editCurriculumCtr" ng-cloak>

        <div class="layui-form-item">
            <label class="layui-form-label">姓名<span class="font-red">*</span></label>
            <div class="layui-input-inline">
                <input type="text" name="showName" value="{{user.showName}}" lay-verify="required" readonly placeholder="" autocomplete="off" class="layui-input" maxlength="50">
            </div>
        </div>

        <div class="layui-form-item">
            <label class="layui-form-label">身份证<span class="font-red">*</span></label>
            <div class="layui-input-inline">
                <input type="text" name="pid" value="{{user.pid}}" lay-verify="required" readonly placeholder="" autocomplete="off" class="layui-input" maxlength="50">
            </div>
        </div>

        <div class="layui-form-item">
            <label class="layui-form-label">行业<span class="font-red">*</span></label>
            <div class="layui-input-inline">
                <input type="text" name="year" value="{{user.tradeName}}" placeholder="" class="layui-input" readonly>
            </div>
        </div>

        <div class="layui-form-item">
            <label class="layui-form-label">联系方式<span class="font-red">*</span></label>
            <div class="layui-input-inline">
                <input type="text" name="phone" value="{{user.phone}}" placeholder="" class="layui-input" readonly>
            </div>
        </div>

        <div class="layui-form-item">
            <label class="layui-form-label">地区</label>
            <div class="layui-input-inline">
                <input type="text" name="phone" value="{{user.city.mergerName}}" placeholder="" class="layui-input" readonly>
            </div>
        </div>

        <div class="layui-form-item">
            <label class="layui-form-label">公司名<span class="font-red">*</span></label>
            <div class="layui-input-inline">
                <input type="text" name="companyName" value="{{user.companyName}}" readonly placeholder="" autocomplete="off" class="layui-input" maxlength="50">
            </div>
        </div>

        <%--<div class="layui-form-item">--%>
            <%--<div class="layui-input-block">--%>
                <%--<button class="layui-btn" lay-submit="" lay-filter="demo1">立即提交</button>--%>
                <%--<button type="reset" class="layui-btn layui-btn-primary">重置</button>--%>
            <%--</div>--%>
        <%--</div>--%>
    </form>
</div>
<!--引入抽取公共js-->
<%@include file="../common/public-js.jsp" %>
<script>

    var webApp=angular.module('webApp',[]);
    webApp.controller("editCurriculumCtr", function($scope,$http,$timeout){

        $scope.user = null;//JSON.parse(sessionStorage.getItem("curriculum"));//获取课程对象
        $scope.id = AM.getUrlParam("id");
        AM.ajaxRequestData("get", false, AM.ip + "/user/info", {id : $scope.id} , function(result) {
            $scope.user = result.data;
        });
        console.log($scope.user);
        $scope.imgUrl = AM.ipImg;
        layui.use(['form', 'layedit', 'laydate', 'upload', 'layedit'], function() {
            var form = layui.form(),
                    layer = layui.layer,
                    layedit = layui.layedit
                    ,$ = layui.jquery,
                    laydate = layui.laydate;
        });
    });

</script>
</body>
</html>
