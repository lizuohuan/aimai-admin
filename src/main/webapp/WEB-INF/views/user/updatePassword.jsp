<!-- 解决layer.open 不居中问题   -->
<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <title>修改密码</title>
    <!--引入抽取css文件-->
    <%@include file="../common/public-css.jsp" %>
    <style>
        .layui-form-pane .layui-form-label{width: 120px;}
        .layui-form-pane .layui-input-block{margin-left: 120px;}
    </style>

</head>
<body>
    <div style="margin: 15px;">
        <blockquote class="layui-elem-quote"><i class="fa fa-refresh" aria-hidden="true"></i>&nbsp;表单带有 <span class="font-red">“*”</span> 号的为必填项.</blockquote>
        <br>
        <br>
        <br>
        <form class="layui-form" action="" id="formData">
            <div class="layui-form-item">
                <label class="layui-form-label">旧密码<span class="font-red">*</span></label>
                <div class="layui-input-inline">
                    <input type="password" name="oldPwd" lay-verify="required|isPwd" placeholder="请输入旧密码" autocomplete="off" class="layui-input" maxlength="16">
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label">新密码<span class="font-red">*</span></label>
                <div class="layui-input-inline">
                    <input type="password" name="newPwd" lay-verify="required|isPwd" placeholder="请输入新密码" autocomplete="off" class="layui-input" maxlength="16">
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label">再次输入新密码<span class="font-red">*</span></label>
                <div class="layui-input-inline">
                    <input type="password" name="confirmPassword" lay-verify="required" placeholder="请再次输入新密码" autocomplete="off" class="layui-input" maxlength="16">
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
    <script src="<%=request.getContextPath()%>/resources/js/common/jQuery.md5.js"></script>
    <script>
        var form = null;
        layui.use(['layer', 'form', 'layedit', 'laydate', 'element'], function() {
            form = layui.form(),
                    layer = layui.layer;

            //自定义验证规则
            form.verify({
                isPwd: function(value) {
                    if(value.length > 0 && !AM.isPwd.test(value)) {
                        return "请输入6-16位字母或数字密码";
                    }
                },
            });

            //监听提交
            form.on('submit(demo1)', function(data) {
                console.log(data.field);
                var oldPwd = $.md5(data.field.oldPwd);
                var newPwd = $.md5(data.field.newPwd);
                var confirmPassword = $.md5(data.field.confirmPassword);
                if (newPwd != confirmPassword) {
                    layer.msg('两次密码不一致.', {icon: 2, anim: 6, offset: 't'});
                    return false;
                }
                else if (oldPwd == newPwd) {
                    layer.msg('旧密码不能和新密码重复.', {icon: 2, anim: 6, offset: 't'});
                    return false;
                }
                data.field.oldPwd = oldPwd;
                data.field.newPwd = newPwd;
                AM.ajaxRequestData("post", false, AM.ip + "/user/editPassword", data.field , function(result) {
                    layer.alert('修改密码成功.', {
                        skin: 'layui-layer-molv' //样式类名
                        ,closeBtn: 0
                        ,anim: 3 //动画类型
                    }, function(){
                        AM.ajaxRequestData("post", false, AM.ip + "/user/logout", {}, function (result) {
                            if(result.flag == 0 && result.code == 200){
                                location.href = AM.ip + "/page/login";
                            }
                        });
                    });
                });
                return false;
            });
        });

    </script>
</body>
</html>
