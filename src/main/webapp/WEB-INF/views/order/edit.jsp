<!-- 解决layer.open 不居中问题   -->
<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <title>修改课程</title>
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
        <legend>修改课程</legend>
    </fieldset>
    <form class="layui-form" action="" id="formData" ng-controller="editCurriculumCtr" ng-cloak>

        <div class="layui-form-item">
            <label class="layui-form-label">订单号</label>
            <div class="layui-input-inline">
                <input type="text" name="orderNumber" value="{{order.orderNumber}}" readonly class="layui-input" >
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">购买方</label>
            <div class="layui-input-inline">
                <input type="text" name="showName" value="{{order.user.showName}}" readonly class="layui-input" >
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">课程名称</label>
            <div class="layui-input-inline">
                <input type="text" name="curriculumName" value="{{order.curriculumName}}" readonly class="layui-input" >
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">地区名</label>
            <div class="layui-input-inline">
                <input type="text" name="cityName" value="{{order.cityName}}" readonly class="layui-input" >
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">购买的数量</label>
            <div class="layui-input-inline">
                <input type="number" name="number" value="{{order.number}}" readonly class="layui-input" >
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">总金额(￥)</label>
            <div class="layui-input-inline">
                <input type="number" name="price" value="{{order.price}}" readonly class="layui-input" >
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">支付方式</label>
            <div class="layui-input-inline">
                <input type="text" name="payMethod" value="{{payMethod}}" readonly class="layui-input" >
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">支付状态</label>
            <div class="layui-input-inline">
                <input type="text" name="payStatus" value="{{payStatus}}" readonly class="layui-input" >
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">下单时间</label>
            <div class="layui-input-inline">
                <input type="text" name="createTime" value="{{order.createTime | date:'yyyy-MM-dd HH:mm:ss'}}" readonly class="layui-input" >
            </div>
        </div>

    </form>
</div>
<!--引入抽取公共js-->
<%@include file="../common/public-js.jsp" %>
<script>

    var webApp=angular.module('webApp',[]);
    webApp.controller("editCurriculumCtr", function($scope,$http,$timeout){

        $scope.order = null;//JSON.parse(sessionStorage.getItem("curriculum"));//获取课程对象
        $scope.id = AM.getUrlParam("id");
        $scope.payStatus = "未支付";
        $scope.payMethod = "支付宝";
        AM.ajaxRequestData("get", false, AM.ip + "/order/info", {id : $scope.id} , function(result) {
            $scope.order = result.data;
            console.log($scope.order);
        });

        if ($scope.order.payStatus == 1) {
            $scope.payStatus = "已支付";
        }


        if ($scope.order.payMethod == 1) {
            $scope.payMethod = "已支付";
        } else if ($scope.order.payMethod == 2) {
            $scope.payMethod = "已支付";
        } else if ($scope.order.payMethod == 3) {
            $scope.payMethod = "已支付";
        }
    });



</script>
</body>
</html>
