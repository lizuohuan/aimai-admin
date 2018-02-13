<!-- 解决layer.open 不居中问题   -->
<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <!--引入抽取css文件-->
    <%@include file="common/public-css.jsp" %>
    <style type="text/css">
        *{margin:0;padding:0;}
        html{height: 100%}
        body {
            font-family: "open sans","Helvetica Neue",Helvetica,Arial,sans-serif;font-size: 13px;color: #676a6c;overflow-x: hidden;height: 100%;background: #eee;}
        .page-404{max-width: 400px;z-index: 100;margin: 0 auto;padding-top: 40px;text-align: center;}
        .page-404 h1{font-size: 50px;margin:0; font-weight: 100;}
        .page-404 h3{font-size: 16px;margin-top: 5px;margin-bottom: 10px;font-weight: 600;}
        .page-404 .error-desc span{font-size: 13px;}
        .page-404 .error-desc .form-control{height: 38px;line-height: 38px;padding-left: 10px;border: 1px solid #e6e6e6;border-radius: 2px;margin-right: 5px;width: 200px;outline: none;}
    </style>
</head>
<body class="gray-bg">
<div class="page-404">
    <h1>您没有权限</h1>
    <h3 class="font-bold">请联系管理员分配权限.</h3>
    <div class="error-desc">
        <%--<span>也许没有权限</span>--%>
        <br><br>
        <%--<a class="layui-btn layui-btn-small" data-type="tabChange" lay-filter="test1">返回主页</a>--%>
    </div>
</div>
<%@include file="common/public-js.jsp" %>
<script>
   /* layui.use(['element'], function() {
        var element = layui.element();
        element.tabDelete('demo', '44'); //删除：“商品管理”

        //获取hash来切换选项卡，假设当前地址的hash为lay-id对应的值
        var layid = location.hash.replace(/^#test1=/, '');
        element.tabChange('test1', layid); //假设当前地址为：http://a.com#test1=222，那么选项卡会自动切换到“发送消息”这一项

        //监听Tab切换，以改变地址hash值
        element.on('tab(test1)', function(){
            location.hash = 'test1='+ this.getAttribute('lay-id');
        });
    });*/
</script>
</body>
</html>
