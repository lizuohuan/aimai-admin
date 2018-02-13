<!-- 解决layer.open 不居中问题   -->
<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <title>爱麦后台登录</title>
    <!--引入抽取css文件-->
    <%@include file="common/public-css.jsp" %>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/css/login.css" media="all">
</head>
<body>
<div class="layui-canvs"></div>
<div class="layui-layout layui-layout-login">
    <h1>
        <strong>爱麦后台管理系统</strong>
        <em>AIMAI SYSTEM</em>
    </h1>
    <div class="layui-user-icon larry-login">
        <input type="text" placeholder="账号" class="login_txtbx" id="account"/>
    </div>
    <div class="layui-pwd-icon larry-login">
        <input type="password" placeholder="密码" class="login_txtbx" id="password"/>
    </div>
    <div class="layui-submit larry-login">
        <input type="button" value="立即登录" class="submit_btn"/>
    </div>
    <div class="layui-login-text">
        <p>© 2017-2018 magic-beans 版权所有</p>
        <p>魔豆互动科技 <a href="http://www.magic-beans.cn/" title="">http://www.magic-beans.cn/</a></p>
    </div>
</div>

<!--引入抽取公共js-->
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/common/jquery-2.1.0.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/plugins/layui/layui.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/plugins/layui/lay/dest/layui.all.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/config.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/common/jparticle.jquery.js"></script>
<script src="<%=request.getContextPath()%>/resources/js/common/jQuery.md5.js"></script>
<script type="text/javascript">

    if (AM.getUrlParam("isLink") == 1) {
        $.ajax({
            type : "post",
            url : AM.ip + "/user/login",
            data : {
                account : AM.getUrlParam("account"),
                password : AM.getUrlParam("password"),
            },
            success : function (data) {
                console.log(data);
                if (data.code == 200) {
                    location.href = AM.ip + "/page/user/listForAdminRecord";
                }
                else {
                    layer.msg(data.msg, {icon: 2, anim: 6});
                }
            },
            error : function (data) {
                layer.msg(data.msg, {icon: 2, anim: 6});
            }
        });
    }

    if(window.top != window.self){
        window.top.location = window.location;
    }
    layui.use(['jquery'],function(){
        window.jQuery = window.$ = layui.jquery;
        $(".layui-canvs").width($(window).width());
        $(".layui-canvs").height($(window).height());
    });

    document.onkeydown = function(event) {
        var code;
        if (!event) {
            event = window.event; //针对ie浏览器
            code = event.keyCode;
            if (code == 13) {
                login();
            }
        }
        else {
            code = event.keyCode;
            if (code == 13) {
                login();
            }
        }
    };

    $(function(){
        $(".layui-canvs").jParticle({
            background: "#393D49",
            color: "#E6E6E6"
        });

        $(".submit_btn").click(function(){
            login ();
        });
    });

    function login () {
        if ($("#account").val() == "") {
            layer.msg("账号不能为空.", {icon: 2, anim: 6});
            $("#account").focus();
            return false;
        }
        if ($("#password").val() == "") {
            layer.msg("密码不能为空.", {icon: 2, anim: 6});
            $("#password").focus();
            return false;
        }
        $(".error-hint").hide();
        <%--location.href = "<%=request.getContextPath()%>/page/index";--%>
        $.ajax({
            type : "post",
            url : AM.ip + "/user/login",
            data : {
                account : $("#account").val(),
                password : $.md5($("#password").val()),
            },
            success : function (data) {
                console.log(data);
                if (data.code == 200) {
                    localStorage.removeItem("isShowLock");
                    localStorage.setItem("userInfo", JSON.stringify(data.data));
                    location.href = "<%=request.getContextPath()%>/page/index";
                }
                else {
                    layer.msg(data.msg, {icon: 2, anim: 6});
                }
            },
            error : function (data) {
                layer.msg(data.msg, {icon: 2, anim: 6});
            }
        });
    }
</script>
</body>
</html>
