<!-- 解决layer.open 不居中问题   -->
<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <title>添加角色</title>
    <!--引入抽取css文件-->
    <%@include file="../common/public-css.jsp" %>
</head>
<body>
    <div style="margin: 15px;">
    <blockquote class="layui-elem-quote"><i class="fa fa-refresh" aria-hidden="true"></i>&nbsp;表单带有 <span class="font-red">“*”</span> 号的为必填项.</blockquote>
    <fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
        <legend>添加角色</legend>
    </fieldset>
    <form class="layui-form" action="" id="formData">


        <div class="layui-form-item">
            <label class="layui-form-label">角色名<span class="font-red">*</span></label>
            <div class="layui-input-inline">
                <input type="text" name="roleName" lay-verify="required" placeholder="请输入角色名" autocomplete="off" class="layui-input" maxlength="20">
            </div>
        </div>

        <div class="layui-form-item">
            <label class="layui-form-label">角色描述</label>
            <div class="layui-input-inline">
                <textarea type="text" name="describe" lay-verify="required" placeholder="请输入角色描述" autocomplete="off" class="layui-textarea" maxlength="200"></textarea>
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
        layui.use(['form', 'layedit', 'laydate'], function() {
            var form = layui.form(),
                    layer = layui.layer,
                    laydate = layui.laydate;

            //自定义验证规则
            form.verify({

            });

            //监听提交
            form.on('submit(demo1)', function(data) {
                data.field.type = Number(data.field.type);
                data.field.level = data.field.level == undefined ? 0 : 1;
                console.log(data.field);
                AM.ajaxRequestData("post", false, AM.ip + "/role/insert", data.field  , function(result) {
                    if (result.flag == 0 && result.code == 200) {
                        layer.alert('添加角色成功.', {
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
