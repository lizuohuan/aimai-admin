<!-- 解决layer.open 不居中问题   -->
<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <!--引入抽取css文件-->
    <%@include file="common/public-css.jsp" %>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/main.css" />
</head>
<body>
<div class="admin-main">
    <blockquote class="layui-elem-quote">
        <div class="widget">
            <div class="row" id="rowDiv">
                <div class="col-xs-12 weather">
                    <iframe allowtransparency="true"
                            frameborder="0" width="575"
                            height="96" scrolling="no"
                            src="//tianqi.2345.com/plugin/widget/index.htm?s=2&z=1&t=0&v=0&d=5&bd=0&k=000000&f=000000&q=1&e=1&a=1&c=54511&w=575&h=96&align=center"></iframe>
                </div>
            </div>
        </div>
    </blockquote>


</div>

<!--引入抽取公共js-->
<%@include file="common/public-js.jsp" %>
<script>



</script>
</body>
</html>
