<!-- 解决layer.open 不居中问题   -->
<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <title>新增订单</title>
    <!--引入抽取css文件-->
    <%@include file="../common/public-css.jsp" %>
    <style>
        .preview{height: 250px;width: 400px;margin-right: 10px;margin-bottom: 10px;float: left;text-align: center}
        .preview img{width: 100%;height:210px;border: 1px solid #eee;}

    </style>
</head>
<body>
<div style="margin: 15px;">
    <blockquote class="layui-elem-quote"><i class="fa fa-refresh" aria-hidden="true"></i>&nbsp;表单带有 <span class="font-red">“*”</span> 号的为必填项.</blockquote>
    <fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
        <legend>新增订单</legend>
    </fieldset>
    <form class="layui-form" action="" id="formData">

        <div class="layui-form-item">
            <label class="layui-form-label">角色类型<span class="font-red">*</span></label>
            <div class="layui-input-inline">
                <select name="roleId" lay-verify="required" lay-filter="role" lay-search>
                    <option value="">请选择或搜索角色类型</option>
                    <option value="3">企业</option>
                    <option value="5">分销商</option>
                </select>
            </div>
        </div>

        <div class="layui-form-item">
            <label class="layui-form-label">选择购买单位<span class="font-red">*</span></label>
            <div class="layui-input-inline">
                <select name="parentId" id="parentIdSelect" lay-verify="required" lay-filter="user" lay-search>
                    <option value="">请选择或搜索单位</option>
                </select>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">选择地区</label>
            <div class="layui-input-inline">
                <select id="provinceId" name="province" lay-search lay-filter="province">
                    <option value="">请选择或搜索省</option>
                </select>
            </div>
            <div class="layui-input-inline">
                <select id="cityId" name="city" lay-search lay-filter="city">
                    <option value="">请选择或搜索市</option>
                </select>
            </div>
            <div class="layui-input-inline">
                <select id="districtId" name="district" lay-search lay-filter="district">
                    <option value="">请选择或搜索县/区</option>
                </select>
            </div>
        </div>

        <div class="layui-form-item">
            <label class="layui-form-label">选择课程<span class="font-red">*</span></label>
            <div class="layui-input-inline">
                <select name="curriculumId" lay-verify="required" lay-search="" lay-filter="curriculum">
                    <option price="0.0" value="">请选择课程</option>
                </select>
            </div>
        </div>

        <div class="layui-form-item" ng-show="curriculum.type != 0">
            <label class="layui-form-label">单价(￥)<span class="font-red">*</span></label>
            <div class="layui-input-inline">
                <input type="number" id="price" readonly lay-verify="required|isZero" placeholder="单价" autocomplete="off" class="layui-input" maxlength="50">
            </div>
        </div>

        <div class="layui-form-item">
            <label class="layui-form-label">购买数量<span class="font-red">*</span></label>
            <div class="layui-input-inline">
                <input type="number" min="0" name="number" id="number"  lay-verify="required|isNumber" placeholder="请输入购买数量" autocomplete="off" class="layui-input" maxlength="50">
            </div>
        </div>

        <div class="layui-form-item">
            <label class="layui-form-label">总金额(￥)<span class="font-red">*</span></label>
            <div class="layui-input-inline">
                <input type="number" name="price"  id="totalPrice" lay-verify="required|isNumber" placeholder="总金额" autocomplete="off" class="layui-input" maxlength="50">
            </div>
        </div>

        <input type="number" name="userId"  id="userId" class="layui-hide">

        <div class="layui-form-item">
            <div class="layui-input-block">
                <button class="layui-btn" lay-submit="" lay-filter="demo1">立即提交</button>
                <%--<button type="button" onclick="reset()" class="layui-btn layui-btn-primary">重置</button>--%>
            </div>
        </div>

    </form>
</div>
<!--引入抽取公共js-->
<%@include file="../common/public-js.jsp" %>
<script>
//    function reset(){
//        alert("111")
//        selectProvince(0); //默认调用省
//        getCurriculumList(0,null,null,null); //查询所有课程
//        $("#totalPrice").val("");
//        $("#price").val("");
//        $("#number").val("");
//        form.render();
//    }
    layui.use(['form', 'layedit', 'laydate', 'upload', 'layedit'], function() {
        var form = layui.form(),
                layer = layui.layer,
                layedit = layui.layedit
                ,$ = layui.jquery,
                laydate = layui.laydate;

        selectProvince(0); //默认调用省
        getCurriculumList(0,null,null,null); //查询所有课程

        form.render();


        //自定义验证规则
        form.verify({
            isNumber: function(value) {
                if(value.length > 0 && !AM.isNumber.test(value)) {
                    return "请输入一个整数";
                }
            }

        });



        //监听用户
        form.on('select(user)', function(data) {
            $("#userId").val(data.value);
            form.render();
        });


        //监听角色
        form.on('select(role)', function(data) {
            getRoleUserList(0,data.value,null,null,null,"请选择或搜索购买单位");
            form.render();
        });

        //监听省
        form.on('select(province)', function(data) {
            $("select[name='district']").html("<option value=\"\">请选择或搜索县/区</option>");
            var provinceId = $("#provinceId").val();
            var cityId = $("#cityId").val();
            var districtId = $("#districtId").val();
            getCurriculumList(0,provinceId,cityId,districtId);
            $("#price").val("");
            selectCity(data.value);
            form.render();
        });

        //监听市
        form.on('select(city)', function(data) {
            var provinceId = $("#provinceId").val();
            var cityId = $("#cityId").val();
            var districtId = $("#districtId").val();
            getCurriculumList(0,provinceId,cityId,districtId);
            $("#price").val("");
            selectCounty(data.value);
            form.render();
        });

        //监听区
        form.on('select(district)', function(data) {
            var provinceId = $("#provinceId").val();
            var cityId = $("#cityId").val();
            var districtId = $("#districtId").val();
            getCurriculumList(0,provinceId,cityId,districtId);
            $("#price").val("");
            form.render();
        });

        //监听课程
        form.on('select(curriculum)', function(data) {
            var price = Number(data.elem[data.elem.selectedIndex].title);
            $("#price").val(price);
            var number = Number($("#number").val());
            if (number != null && number != "") {
                $("#totalPrice").val(number * price);
            }
            form.render();
        });

        //数量
        $('#number').bind('input propertychange', function() {
            var totalPrice = Number($("#totalPrice").val());
            if (totalPrice != null && totalPrice != "") {
                var number = Number($(this).val());
                $("#price").val(totalPrice / number);
            } else {
                $("#price").val(0);
            }
        });

        //数量
        $('#totalPrice').bind('input propertychange', function() {
            var number = Number($("#number").val());
            if (number != null && number != "") {
                var totalPrice = Number($(this).val());
                $("#price").val(totalPrice / number);
            } else {
                $("#price").val(0);
            }
        });
        //监听提交
        form.on('submit(demo1)', function(data) {

            console.log(data.field);

            AM.ajaxRequestData("post", false, AM.ip + "/order/save", data.field  , function(result) {
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



</script>
</body>
</html>
