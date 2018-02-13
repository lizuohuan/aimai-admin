<!-- 解决layer.open 不居中问题   -->
<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <title>添加试卷</title>
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
        <legend>添加试卷</legend>
    </fieldset>
    <form class="layui-form" action="" id="formData">

        <div class="layui-form-item">
            <label class="layui-form-label">添加试卷<span class="font-red">*</span></label>
            <div class="layui-input-inline">
                <input type="text" name="paperTitle" lay-verify="required" placeholder="请输入试卷名称" autocomplete="off" class="layui-input" maxlength="50">
            </div>
        </div>


        <div class="layui-form-item">
            <label class="layui-form-label">选择类型</label>
            <div class="layui-input-inline">
                <select name="type" lay-verify="required"  lay-filter="typeChange"  lay-search >
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
                <select name="targetId" lay-verify="required"  lay-search>
                    <option value="">选择课程/课件</option>
                </select>
            </div>
        </div>

        <div class="layui-form-item" id="useTimeDiv">
            <label class="layui-form-label">用时<span class="font-red">*</span></label>
            <div class="layui-input-inline">
                <input type="number" id="useTimeInput" name="useTime" placeholder="输入用时(单位：小时)" autocomplete="off" class="layui-input" lay-verify="required" >
            </div>
        </div>


        <div class="layui-form-item" >
            <label class="layui-form-label">及格分数<span class="font-red">*</span></label>
            <div class="layui-input-inline">
                <input type="number" name="passScore" placeholder="及格分数" autocomplete="off" class="layui-input" lay-verify="required"  >
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


    layui.use(['form', 'layedit', 'laydate', 'upload', 'layedit'], function() {
        var form = layui.form(),
                layer = layui.layer,
                layedit = layui.layedit
                ,$ = layui.jquery,
                laydate = layui.laydate;

        var curriculumList = null;
        var courseWareList = null;

        form.on('select(typeChange)', function(data){
            var type = data.value
            if(type == "" || null == type){
                return;
            }

            if(type == 0 ){

                $("#useTimeDiv").hide();
                $("#useTimeInput").removeAttr("lay-verify");

                if(null == courseWareList){
                    // 课件列表
                    AM.ajaxRequestData("get", false, AM.ip + "/courseWare/queryBaseCourseWare", {} , function(result){
                        if(result.flag == 0 && result.code == 200){
                            courseWareList = result.data;
                        }
                    });
                }
                var html = "<option value=\"\">选择或搜索课件</option>";
                for (var i = 0; i < courseWareList.length; i++) {
                    html += "<option value=\"" + courseWareList[i].id + "\">" + courseWareList[i].courseWareName + "("+courseWareList[i].curriculumName+")</option>";
                }
                if (courseWareList.length == 0) {
                    html += "<option value=\"0\" disabled>暂无</option>";
                }
                $("select[name='targetId']").html(html)
            }
            if(type == 1 || type == 2){
                $("#useTimeDiv").show();
                $("#useTimeInput").attr("lay-verify","required");

                if(null == curriculumList){
                    // 课程列表
                    AM.ajaxRequestData("get", false, AM.ip + "/curriculum/queryCurriculum", {} , function(result){
                        if(result.flag == 0 && result.code == 200){
                            curriculumList = result.data;
                        }
                    });
                }
                var html = "<option value=\"\">选择或搜索课程</option>";
                for (var i = 0; i < curriculumList.length; i++) {
                    html += "<option value=\"" + curriculumList[i].id + "\">" + curriculumList[i].curriculumName + "</option>";
                }
                if (curriculumList.length == 0) {
                    html += "<option value=\"0\" disabled>暂无</option>";
                }
                $("select[name='targetId']").html(html);
            }
            form.render();
        });



        form.render();

        //监听提交
        form.on('submit(demo1)', function(data) {
            data.field.useTime =  parseInt(data.field.useTime * 60 * 60);
            console.log(data.field);
            AM.ajaxRequestData("post", false, AM.ip + "/paper/save", data.field  , function(result) {
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
