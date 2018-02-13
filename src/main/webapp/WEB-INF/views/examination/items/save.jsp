<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- 解决layer.open 不居中问题   -->
<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <title>添加选项</title>
    <!--引入抽取css文件-->
    <%@include file="../../common/public-css.jsp" %>
    <style>
        .preview{height: 250px;width: 400px;margin-right: 10px;margin-bottom: 10px;float: left;text-align: center}
        .preview img{width: 100%;height:210px;border: 1px solid #eee;}

    </style>
</head>
<body>
<div style="margin: 15px;">
    <blockquote class="layui-elem-quote"><i class="fa fa-refresh" aria-hidden="true"></i>&nbsp;表单带有 <span class="font-red">“*”</span> 号的为必填项.</blockquote>
    <fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">

            <legend>添加选项</legend>

    </fieldset>
    <form class="layui-form" action="" id="formData">

        <div class="layui-form-item">
            <label class="layui-form-label">选项标题<span class="font-red">*</span></label>
            <div class="layui-input-block">
                <textarea name="itemTitle" placeholder="请输入选项标题" class="layui-textarea" maxlength="200" lay-verify="required" ></textarea>
            </div>
        </div>


        <div class="layui-form-item">
            <label class="layui-form-label">是否正确答案<span class="font-red">*</span></label>
            <div class="layui-input-inline">
                <select name="isCorrect" lay-verify="required" lay-search>
                    <option value="0">错误答案</option>
                    <option value="1">正确答案</option>
                </select>
            </div>
        </div>


        <div class="layui-form-item">
            <label class="layui-form-label">排序(升序)<span class="font-red">*</span></label>
            <div class="layui-input-inline">
                <input type="number" name="sortNum" lay-verify="required" placeholder="请设置排序" autocomplete="off" class="layui-input" maxlength="50">
            </div>
        </div>

        <input type="hidden" name="examinationId" value="${examinationId}">

        <div class="layui-form-item">
            <div class="layui-input-block">
                <button class="layui-btn" lay-submit="" lay-filter="demo1">立即提交</button>
                <button type="reset" class="layui-btn layui-btn-primary">重置</button>
            </div>
        </div>
    </form>
</div>
<!--引入抽取公共js-->
<%@include file="../../common/public-js.jsp" %>
<script>

    layui.use(['form', 'layedit', 'laydate', 'upload', 'layedit'], function() {
        var form = layui.form(),
                layer = layui.layer,
                layedit = layui.layedit
                ,$ = layui.jquery,
                laydate = layui.laydate;


        form.render();


        //监听提交
        form.on('submit(demo1)', function(data) {

            console.log(data.field);
            AM.ajaxRequestData("post", false, AM.ip + "/examination/saveItems", data.field  , function(result) {
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

    //删除图片
    function deleteImg (object) {
        var url = $(object).attr("cover");
        var covers = $("#cover").val().split(",");
        for (var i = 0; i < covers.length; i++) {
            if (covers[i] == url) {
                covers.splice(i, 1);
                $(object).parent().fadeOut();
                break;
            }
        }
        if (covers.length == 0) $("#preview").parent().hide();
        console.log(covers);
        $("#cover").val(covers.toString());
        $("#uploadImgDiv").show();
    }
</script>
</body>
</html>
